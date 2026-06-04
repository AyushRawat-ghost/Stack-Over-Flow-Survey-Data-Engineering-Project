import os
import sys
import logging
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from openai import OpenAI

# Resolve absolute paths dynamically
BACKEND_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(os.path.dirname(BACKEND_DIR))
UTILS_DIR = os.path.join(PROJECT_ROOT, 'Data Warehouse', 'Silver Layer', 'utils')
sys.path.append(UTILS_DIR)

from sql_connector import SQLConnector
from config import Config
from prompt_templates import SQL_SYSTEM_PROMPT, find_fallback_query

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("so_analyst_backend")

app = FastAPI(title="Stack Overflow Survey Data Analyst API")

# Enable CORS for React frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize SQL Server database connector
db = SQLConnector(Config.DB_NAME)
# Override SQL Server name if defined in config/env
if Config.DB_SERVER:
    db.server = Config.DB_SERVER
    db._conn_str = (
        f'DRIVER={{ODBC Driver 17 for SQL Server}};'
        f'SERVER={db.server};'
        f'DATABASE={db.database};'
        f'Trusted_Connection=yes;'
    )

logger.info(f"Connecting to SQL Server database at server: {db.server}")
db_connection = db.connect()

# Initialize Fireworks Client (using OpenAI SDK compatibility)
fireworks_key = Config.FIREWORKS_API_KEY
client = None
if fireworks_key:
    logger.info("Fireworks API key found. Initializing AI query generator.")
    client = OpenAI(
        base_url="https://api.fireworks.ai/inference/v1",
        api_key=fireworks_key
    )
else:
    logger.warning("No Fireworks API key found. System running in LOCAL FALLBACK mode.")

class ChatRequest(BaseModel):
    query: str

def get_database_schema_context() -> str:
    """Returns database view structural details for LLM query planning."""
    return """
    Views and schemas present in database:
    1. Snowflake.Fact_Survey_Core (ResponseKey, SurveyYear, ResponseId, Dim_DemographicsID, Dim_EmploymentID, Dim_CompensationID, Dim_AICentralID, Dim_TechCentralID, YearsCode, YearsCodePro)
    2. Snowflake.Dim_Demographics (Dim_DemographicsID, AgeCode, Gender_Clean, Ethnicity_Clean, Sexuality_Clean, TransGender, Accessibility_Status, Mental_Health_Status, Country, USA_State)
    3. Snowflake.Dim_Employment (Dim_EmploymentID, Current_Profession, EmploymentAddl, Industry, Organization_Size, ICorPM, WorkExp, RemoteWork)
    4. Snowflake.Dim_Compensation (Dim_CompensationID, CompTotal, Compensation_Frequency, ConvertedCompYearly, Currency_Code)
    5. Snowflake.Dim_AICentral (Dim_AICentralID, Dim_AIAgentsID, Dim_AINextID, Dim_AIModelsID, Dim_AIToolsID, Dim_AIOpinionsID)
    6. Snowflake.Dim_TechCentral (Dim_TechCentralID, Dim_TechDatabasesID, Dim_TechPlatformsID, Dim_TechLanguagesWebID, Dim_TechMiscToolsID, Dim_TechEndorseID, Dim_TechOpposeID)
    
    Many-to-Many Bridge Tables (Join on ResponseKey):
    - Snowflake.Bridge_LanguageHaveWorkedWith_Clean (ResponseKey, LanguageHaveWorkedWith_Clean)
    - Snowflake.Bridge_DatabaseHaveWorkedWith_Clean (ResponseKey, DatabaseHaveWorkedWith_Clean)
    - Snowflake.Bridge_DatabaseWantToWorkWith_Clean (ResponseKey, DatabaseWantToWorkWith_Clean)
    - Snowflake.Bridge_AIModelsHaveWorkedWith_Clean (ResponseKey, AIModelsHaveWorkedWith_Clean)
    - Snowflake.Bridge_DevType_Clean (ResponseKey, DevType_Clean)
    """

def infer_chart_metadata(columns, rows):
    """Dynamically sets suitable chart coordinates based on output columns."""
    if not columns or not rows:
        return "bar", "", ""
    
    # Categorical columns
    x_axis = columns[0]
    # Numeric columns
    y_axis = columns[1] if len(columns) > 1 else columns[0]
    
    # Match standard patterns
    for col in columns:
        if "year" in col.lower() or "date" in col.lower():
            x_axis = col
        if "salary" in col.lower() or "compensation" in col.lower() or "count" in col.lower() or "responses" in col.lower() or "votes" in col.lower():
            y_axis = col

    # Decide type
    chart_type = "bar"
    if "year" in x_axis.lower() or "date" in x_axis.lower():
        chart_type = "line"
        
    return chart_type, x_axis, y_axis

@app.post("/api/chat")
async def chat_analyst(payload: ChatRequest):
    user_query = payload.query.strip()
    if not user_query:
        raise HTTPException(status_code=400, detail="Query cannot be empty.")
    
    sql_query = None
    chart_type = "bar"
    x_axis = ""
    y_axis = ""
    summary = ""
    
    # Check if we should use LLM or Fallback mode
    use_fallback = True
    if client:
        try:
            logger.info(f"Generating SQL query via LLM: {user_query}")
            schema_context = get_database_schema_context()
            response = client.chat.completions.create(
                model=Config.LLM_MODEL,
                messages=[
                    {"role": "system", "content": SQL_SYSTEM_PROMPT.format(schema_context=schema_context)},
                    {"role": "user", "content": user_query}
                ],
                temperature=0.0
            )
            raw_sql = response.choices[0].message.content.strip()
            # Clean markdown code fences if outputted
            sql_query = raw_sql.replace("```sql", "").replace("```", "").strip()
            summary = f"SQL generated dynamically via Fireworks LLM ({Config.LLM_MODEL})."
            use_fallback = False
        except Exception as e:
            logger.error(f"LLM generation failed: {e}. Falling back to pre-baked local templates.")
            use_fallback = True
            
    if use_fallback:
        logger.info(f"Resolving query locally: {user_query}")
        fallback = find_fallback_query(user_query)
        sql_query = fallback["sql"]
        chart_type = fallback.get("chartType", "bar")
        x_axis = fallback.get("xAxis", "")
        y_axis = fallback.get("yAxis", "")
        summary = fallback.get("summary", "Query resolved using local fallback database templates.")

    # Execute SQL on Database
    if not db_connection:
        # If database is offline, return mocked schema response so the frontend still has visual charts
        logger.error("Local SQL Server database offline. Returning mocked results.")
        raise HTTPException(
            status_code=503, 
            detail="Local MS SQL Server database is offline. Please run the database service or verify server settings."
        )
        
    logger.info(f"Executing query on SQL Server: \n{sql_query}")
    df = db.read_query(sql_query)
    
    if df is None:
        raise HTTPException(status_code=500, detail="Error executing generated SQL query on SQL Server.")
        
    columns = list(df.columns)
    rows = df.to_dict(orient="records")
    
    # If dynamic, infer charts from execution metadata
    if not use_fallback:
        chart_type, x_axis, y_axis = infer_chart_metadata(columns, rows)
        
    return {
        "sql": sql_query,
        "columns": columns,
        "rows": rows,
        "chartType": chart_type,
        "xAxis": x_axis,
        "yAxis": y_axis,
        "summary": summary
    }

@app.get("/api/schema")
async def get_schema():
    return {"schema": get_database_schema_context()}

# =========================================================================
# Model Context Protocol (MCP) Server Setup
# =========================================================================
try:
    from mcp.server.fastapi import FastApiServer
    
    mcp_server = FastApiServer(name="so_survey_data_analyst")
    
    @mcp_server.tool()
    def get_database_schema() -> str:
        """Returns the database views and layout schema context for Stack Overflow survey warehouse."""
        return get_database_schema_context()
        
    @mcp_server.tool()
    def execute_database_query(sql_query: str) -> str:
        """Runs a read-only SELECT query against the Stack Overflow survey SQL Server database and returns results."""
        if not db_connection:
            return "Error: Database connection is offline."
        df = db.read_query(sql_query)
        if df is None:
            return "Error: SQL execution failed."
        return df.to_string(index=False)
        
    # Mount MCP server under '/mcp' route
    app.mount("/mcp", mcp_server)
    logger.info("Successfully mounted MCP server endpoints on '/mcp'")
except Exception as e:
    logger.warning(f"MCP server mounting skipped or failed: {e}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)

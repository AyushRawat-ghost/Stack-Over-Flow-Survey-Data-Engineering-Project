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
    logger.info(f"Fireworks API key found. Initializing AI query generator using model: {Config.LLM_MODEL}")
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
    Database Schema Layout for Stack Overflow survey warehouse (all views are in the Snowflake schema):
    
    1. FACT VIEW:
       - Snowflake.Fact_Survey_Core (ResponseKey, SurveyYear, ResponseId, Dim_DemographicsID, Dim_EmploymentID, Dim_CompensationID, Dim_EducationID, Dim_SatisfactionID, Dim_KnowledgeID, Dim_StackOverflowID, Dim_SOActionsID, Dim_MiscCategoricalID, Dim_AICentralID, Dim_TechCentralID, YearsCode, YearsCodePro)
         * PK: ResponseKey (VARCHAR(64), surrogate SHA2_256 hash of SurveyYear + ResponseId)
         * FK: Dim_DemographicsID, Dim_EmploymentID, Dim_CompensationID, Dim_EducationID, Dim_SatisfactionID, Dim_KnowledgeID, Dim_StackOverflowID, Dim_SOActionsID, Dim_MiscCategoricalID, Dim_AICentralID, Dim_TechCentralID
         * Note: SurveyYear is of DATE type (e.g. '2023-01-01'). You MUST use YEAR(SurveyYear) when filtering or grouping by year.
    
    2. 9 CORE DIMENSION VIEWS (Join directly on Snowflake.Fact_Survey_Core using respective ID keys):
       - Snowflake.Dim_Demographics (Dim_DemographicsID, AgeCode, Gender_Clean, Ethnicity_Clean, Sexuality_Clean, TransGender, Accessibility_Status, Mental_Health_Status, Country, USA_State)
       - Snowflake.Dim_Employment (Dim_EmploymentID, Current_Profession, EmploymentAddl, Industry, Organization_Size, ICorPM, WorkExp, RemoteWork)
       - Snowflake.Dim_Compensation (Dim_CompensationID, CompTotal, Compensation_Frequency, ConvertedCompYearly, Currency_Code)
       - Snowflake.Dim_Education (Dim_EducationID, Education_Level, LearnCodeOnline, LearnCodeChoose, LearnCodeCoursesCert, LearnCodeAI)
       - Snowflake.Dim_Satisfaction (Dim_SatisfactionID, JobSat, JobSatPoints_1, JobSatPoints_10, JobSatPoints_11, JobSatPoints_13, JobSatPoints_14, JobSatPoints_15, JobSatPoints_15_TEXT, JobSatPoints_16, JobSatPoints_2, JobSatPoints_3, JobSatPoints_4, JobSatPoints_5, JobSatPoints_6, JobSatPoints_7, JobSatPoints_8, JobSatPoints_9)
       - Snowflake.Dim_Knowledge (Dim_KnowledgeID, Knowledge_1, Knowledge_2, Knowledge_3, Knowledge_4, Knowledge_5, Knowledge_6, Knowledge_7, Knowledge_8, Knowledge_9)
       - Snowflake.Dim_StackOverflow (Dim_StackOverflowID, NewStackOverflow_Sites, SOAI, SODuration, SOFriction, SOHow, SOTagsAdmired, SOTagsHaveEntry, SOTagsWant Entry, SO_Dev_Content, StackOverflow_Account_exists, StackOverflow_Community_Experience, StackOverflow_Participation_Frequency, StackOverflow_Visit_Frequency)
       - Snowflake.Dim_SOActions (Dim_SOActionsID, SO_Actions_1, SO_Actions_10, SO_Actions_15, SO_Actions_15_TEXT, SO_Actions_16, SO_Actions_3, SO_Actions_4, SO_Actions_5, SO_Actions_6, SO_Actions_7, SO_Actions_9)
       - Snowflake.Dim_MiscCategorical (Dim_MiscCategoricalID, AgentUsesGeneral, BuildvsBuy, Check, CodingActivities, Frequency_1, Frequency_2, Frequency_3, Frustration, Know_Other_Community, MainBranch, NewRole, Onboarding, ProfessionalCloud, ProfessionalQuestion, PurchaseInfluence, Q120, Survey_Ease, Survey_Length, TBranch, TimeAnswering, TimeSearching, TrueFalse_1, TrueFalse_2, TrueFalse_3, VCHostingPersonal use, VCHostingProfessional use, VCInteraction)

    3. CENTRAL HUBS & SUB-DIMENSIONS:
       - Snowflake.Dim_AICentral (Dim_AICentralID, Dim_AIAgentsID, Dim_AINextID, Dim_AIModelsID, Dim_AIToolsID, Dim_AIOpinionsID)
         * Join with Fact_Survey_Core on Dim_AICentralID. Leads to AI sub-dimensions:
         - Snowflake.Dim_AIAgents (Dim_AIAgentsID, AIAgentChallengesNeutral, AIAgentChallengesSomewhat agree, AIAgentChallengesSomewhat disagree, AIAgentChallengesStrongly agree, AIAgentChallengesStrongly disagree, AIAgentChange, AIAgentExtWrite, AIAgentExternal, AIAgentImpactNeutral, AIAgentImpactSomewhat agree, AIAgentImpactSomewhat disagree, AIAgentImpactStrongly agree, AIAgentImpactStrongly disagree, AIAgentKnowWrite, AIAgentKnowledge, AIAgentObsWrite, AIAgentObserveSecure, AIAgentOrchWrite, AIAgentOrchestration, AIAgent_Uses, AIAgents)
         - Snowflake.Dim_AIModels (Dim_AIModelsID, AIModelsAdmired, AIModelsChoice, AIModelsHaveEntry, AIModelsWantEntry)
         - Snowflake.Dim_AINext (Dim_AINextID, AINextLess integrated, AINextMore integrated, AINextMuch less integrated, AINextMuch more integrated, AINextNeither different nor similar, AINextNo change, AINextSomewhat different, AINextSomewhat similar, AINextVery different, AINextVery similar)
         - Snowflake.Dim_AITools (Dim_AIToolsID, AIToolCurrently Using, AIToolCurrently mostly AI, AIToolCurrently partially AI, AIToolDon't plan to use AI for this task, AIToolInterested in Using, AIToolNot interested in Using, AIToolPlan to mostly use AI, AIToolPlan to partially use AI)
         - Snowflake.Dim_AIOpinions (Dim_AIOpinionsID, AIAcc, AIBen, AIChallenges, AIComplex, AIEthics, AIExplain, AIFrustration, AIHuman, AILearnHow, AIOpen, AISearchDevAdmired, AISearchDevHaveWorkedWith, AISearchDevWantToWorkWith, AISelect, AISent, AIThreat)
       
       - Snowflake.Dim_TechCentral (Dim_TechCentralID, Dim_TechDatabasesID, Dim_TechPlatformsID, Dim_TechLanguagesWebID, Dim_TechMiscToolsID, Dim_TechEndorseID, Dim_TechOpposeID)
         * Join with Fact_Survey_Core on Dim_TechCentralID. Leads to tech sub-dimensions:
         - Snowflake.Dim_TechDatabases (Dim_TechDatabasesID, DatabaseAdmired, DatabaseChoice, DatabaseHaveEntry, DatabaseWantEntry)
         - Snowflake.Dim_TechPlatforms (Dim_TechPlatformsID, OperatingSystem, OperatingSystem_Personal, OperatingSystem_Professional, PlatformAdmired, PlatformChoice, PlatformHaveEntry, PlatformWantEntry)
         - Snowflake.Dim_TechLanguagesWeb (Dim_TechLanguagesWebID, LanguageAdmired, LanguageChoice, LanguagesHaveEntry, LanguagesWantEntry, WebframeAdmired, WebframeChoice, WebframeHaveEntry, WebframeWantEntry)
         - Snowflake.Dim_TechMiscTools (Dim_TechMiscToolsID, Blockchain, BuyNewTool, CommPlatformAdmired, CommPlatformHaveEntr, CommPlatformWantEntr, DevEnvHaveEntry, DevEnvWantEntry, DevEnvsAdmired, DevEnvsChoice, EmbeddedAdmired, MiscTechAdmired, NEWCollabToolsAdmired, OfficeStackAsyncAdmired, OfficeStackHaveEntry, OfficeStackSyncAdmired, OfficeStackWantEntry, ProfessionalTech, TechDoc, TechList, ToolCountPersonal, ToolCountWork, ToolsTechAdmired, VersionControlSystem)
         - Snowflake.Dim_TechEndorse (Dim_TechEndorseID, TechEndorse, TechEndorseIntro, TechEndorse_1, TechEndorse_13, TechEndorse_13_TEXT, TechEndorse_2, TechEndorse_3, TechEndorse_4, TechEndorse_5, TechEndorse_6, TechEndorse_7, TechEndorse_8, TechEndorse_9)
         - Snowflake.Dim_TechOppose (Dim_TechOpposeID, TechOppose_1, TechOppose_11, TechOppose_13, TechOppose_15, TechOppose_15_TEXT, TechOppose_16, TechOppose_2, TechOppose_3, TechOppose_5, TechOppose_7, TechOppose_9)

    4. 35 MANY-TO-MANY BRIDGE VIEWS (Join on Snowflake.Fact_Survey_Core via ResponseKey):
       - Snowflake.Bridge_AIDevHaveWorkedWith_Clean (ResponseKey, AIDevHaveWorkedWith_Clean)
       - Snowflake.Bridge_AIDevWantToWorkWith_Clean (ResponseKey, AIDevWantToWorkWith_Clean)
       - Snowflake.Bridge_AIModelsHaveWorkedWith_Clean (ResponseKey, AIModelsHaveWorkedWith_Clean)
       - Snowflake.Bridge_AIModelsWantToWorkWith_Clean (ResponseKey, AIModelsWantToWorkWith_Clean)
       - Snowflake.Bridge_AISearchHaveWorkedWith_Clean (ResponseKey, AISearchHaveWorkedWith_Clean)
       - Snowflake.Bridge_AISearchWantToWorkWith_Clean (ResponseKey, AISearchWantToWorkWith_Clean)
       - Snowflake.Bridge_CommPlatformHaveWorkedWith_Clean (ResponseKey, CommPlatformHaveWorkedWith_Clean)
       - Snowflake.Bridge_CommPlatformWantToWorkWith_Clean (ResponseKey, CommPlatformWantToWorkWith_Clean)
       - Snowflake.Bridge_DatabaseHaveWorkedWith_Clean (ResponseKey, DatabaseHaveWorkedWith_Clean)
       - Snowflake.Bridge_DatabaseWantToWorkWith_Clean (ResponseKey, DatabaseWantToWorkWith_Clean)
       - Snowflake.Bridge_DevEnvsHaveWorkedWith_Clean (ResponseKey, DevEnvsHaveWorkedWith_Clean)
       - Snowflake.Bridge_DevEnvsWantToWorkWith_Clean (ResponseKey, DevEnvsWantToWorkWith_Clean)
       - Snowflake.Bridge_DevType_Clean (ResponseKey, DevType_Clean)
       - Snowflake.Bridge_EmbeddedHaveWorkedWith_Clean (ResponseKey, EmbeddedHaveWorkedWith_Clean)
       - Snowflake.Bridge_EmbeddedWantToWorkWith_Clean (ResponseKey, EmbeddedWantToWorkWith_Clean)
       - Snowflake.Bridge_LanguageHaveWorkedWith_Clean (ResponseKey, LanguageHaveWorkedWith_Clean)
       - Snowflake.Bridge_LanguageWantToWorkWith_Clean (ResponseKey, LanguageWantToWorkWith_Clean)
       - Snowflake.Bridge_LearnCode_Clean (ResponseKey, LearnCode_Clean)
       - Snowflake.Bridge_MiscTechHaveWorkedWith_Clean (ResponseKey, MiscTechHaveWorkedWith_Clean)
       - Snowflake.Bridge_MiscTechWantToWorkWith_Clean (ResponseKey, MiscTechWantToWorkWith_Clean)
       - Snowflake.Bridge_NEWCollabToolsHaveWorkedWith_Clean (ResponseKey, NEWCollabToolsHaveWorkedWith_Clean)
       - Snowflake.Bridge_NEWCollabToolsWantToWorkWith_Clean (ResponseKey, NEWCollabToolsWantToWorkWith_Clean)
       - Snowflake.Bridge_NEWStuck_Clean (ResponseKey, NEWStuck_Clean)
       - Snowflake.Bridge_OfficeStackAsyncHaveWorkedWith_Clean (ResponseKey, OfficeStackAsyncHaveWorkedWith_Clean)
       - Snowflake.Bridge_OfficeStackAsyncWantToWorkWith_Clean (ResponseKey, OfficeStackAsyncWantToWorkWith_Clean)
       - Snowflake.Bridge_OfficeStackSyncHaveWorkedWith_Clean (ResponseKey, OfficeStackSyncHaveWorkedWith_Clean)
       - Snowflake.Bridge_OfficeStackSyncWantToWorkWith_Clean (ResponseKey, OfficeStackSyncWantToWorkWith_Clean)
       - Snowflake.Bridge_PlatformHaveWorkedWith_Clean (ResponseKey, PlatformHaveWorkedWith_Clean)
       - Snowflake.Bridge_PlatformWantToWorkWith_Clean (ResponseKey, PlatformWantToWorkWith_Clean)
       - Snowflake.Bridge_SOTagsHaveWorkedWith_Clean (ResponseKey, SOTagsHaveWorkedWith_Clean)
       - Snowflake.Bridge_SOTagsWantToWorkWith_Clean (ResponseKey, SOTagsWantToWorkWith_Clean)
       - Snowflake.Bridge_ToolsTechHaveWorkedWith_Clean (ResponseKey, ToolsTechHaveWorkedWith_Clean)
       - Snowflake.Bridge_ToolsTechWantToWorkWith_Clean (ResponseKey, ToolsTechWantToWorkWith_Clean)
       - Snowflake.Bridge_WebframeHaveWorkedWith_Clean (ResponseKey, WebframeHaveWorkedWith_Clean)
       - Snowflake.Bridge_WebframeWantToWorkWith_Clean (ResponseKey, WebframeWantToWorkWith_Clean)
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
        
        # Dynamically generate natural language summary of findings from results
        if client:
            try:
                logger.info("Generating natural language summary of findings from query results...")
                rows_sample = rows[:20]
                explanation_prompt = f"""
                You are a helpful data analyst.
                The user asked the following question: "{user_query}"
                The generated T-SQL query was:
                {sql_query}
                
                Here are the query results (first 20 rows):
                {rows_sample}
                
                Based on these results, write a concise, professional explanation/insight of the findings in plain English (2-3 sentences max).
                
                CRITICAL RULES:
                1. Never mention any database table, view, schema, or column names (such as 'Snowflake.Fact_Survey_Core', 'Dim_Demographics', 'Dim_Compensation', etc.).
                2. Never show SQL fragments, raw brackets, or technical database terminology.
                3. Talk directly about the developer statistics, countries, years, or compensation figures in a clean business context.
                """
                explanation_response = client.chat.completions.create(
                    model=Config.LLM_MODEL,
                    messages=[
                        {"role": "system", "content": "You are a professional developer survey data analyst."},
                        {"role": "user", "content": explanation_prompt}
                    ],
                    temperature=0.3
                )
                summary = explanation_response.choices[0].message.content.strip()
            except Exception as e:
                logger.error(f"Failed to generate dynamic summary of findings: {e}")
                summary = "Query executed successfully on local SQL Server. Please see the visual charts and data grid for details."
        
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
    from mcp.server.fastmcp import FastMCP
    
    mcp_server = FastMCP("so_survey_data_analyst")
    
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
        
    # Mount MCP server under '/mcp' route via SSE
    app.mount("/mcp", mcp_server.sse_app())
    logger.info("Successfully mounted MCP server endpoints on '/mcp'")
except Exception as e:
    logger.warning(f"MCP server mounting skipped or failed: {e}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)

# Backend & MCP Server Implementation Guide

This guide details how to implement the FastAPI backend and MCP server so that it interfaces seamlessly with your React frontend dashboard.

---

## 1. Frontend Integration API Schema

The React UI makes requests to `http://localhost:8000/api/chat`. The backend must handle this route and return a matching JSON structure.

### Request Payload (`POST /api/chat`)
```json
{
  "query": "Show average yearly compensation by developer type."
}
```

### Expected Response Payload
```json
{
  "sql": "SELECT ... FROM Snowflake.Fact_Survey_Core ...",
  "columns": ["DevType", "AverageSalary"],
  "rows": [
    { "DevType": "Engineering Manager", "AverageSalary": 145000 },
    { "DevType": "Data Engineer", "AverageSalary": 122000 }
  ],
  "chartType": "bar",
  "xAxis": "DevType",
  "yAxis": "AverageSalary",
  "summary": "I executed an optimized query grouping compensation by profession."
}
```

---

## 2. FastAPI Backend Setup Template

Create a Python file `app.py` inside `Machine Learning and AI/backend/app.py` with the following structure:

```python
import os
import sys
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from openai import OpenAI
from dotenv import load_dotenv

# Resolve project paths and import your SQLConnector
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', 'Data Warehouse', 'Silver Layer', 'utils')))
from sql_connector import SQLConnector

load_dotenv()

app = FastAPI(title="Stack Overflow Survey AI Analyst Backend")

# Enable CORS for React Frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Connect to database
db = SQLConnector("Stack_Overflow_Survey")
db.connect()

# Configure Fireworks AI client using OpenAI-compatible SDK
client = OpenAI(
    base_url="https://api.fireworks.ai/inference/v1",
    api_key=os.getenv("FIREWORKS_API_KEY")
)

class QueryRequest(BaseModel):
    query: str

@app.post("/api/chat")
async def chat_analyst(payload: QueryRequest):
    try:
        user_prompt = payload.query
        
        # 1. Fetch Schema Metadata as LLM Context
        schema_context = get_database_schema_context()
        
        # 2. Translate Natural Language to SQL using Fireworks AI
        sql_query = generate_sql_from_llm(user_prompt, schema_context)
        
        # 3. Execute Generated SQL on Local SQL Server
        df = db.read_query(sql_query)
        if df is None:
            raise HTTPException(status_code=500, detail="Database query execution failed.")
            
        columns = list(df.columns)
        rows = df.to_dict(orient="records")
        
        # 4. Infer Chart Settings (dynamically choose chart type, x-axis, and y-axis)
        chart_type, x_axis, y_axis = infer_chart_settings(columns, rows)
        
        return {
            "sql": sql_query,
            "columns": columns,
            "rows": rows,
            "chartType": chart_type,
            "xAxis": x_axis,
            "yAxis": y_axis,
            "summary": f"Executed query: generated {len(rows)} data records."
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

def get_database_schema_context() -> str:
    # Query system views or return static details of Star Dims, Hubs, and Bridges
    return """
    Tables and Columns:
    - Snowflake.Fact_Survey_Core (SurveyYear, ResponseId, Dim_DemographicsID, Dim_EmploymentID, Dim_CompensationID, YearsCode, YearsCodePro)
    - Dim_Demographics (Dim_DemographicsID, Country, AgeCode, Gender_Clean)
    - Dim_Employment (Dim_EmploymentID, Current_Profession, RemoteWork, Organization_Size)
    - Dim_Compensation (Dim_CompensationID, ConvertedCompYearly, Currency_Code)
    """

def generate_sql_from_llm(prompt: str, schema: str) -> str:
    response = client.chat.completions.create(
        model="accounts/fireworks/models/llama-v3p1-70b-instruct",
        messages=[
            {"role": "system", "content": f"You are a SQL expert translating natural language queries to T-SQL for MS SQL Server. Only return the raw SQL code block, nothing else. Database Schema:\n{schema}"},
            {"role": "user", "content": prompt}
        ],
        temperature=0.0
    )
    sql = response.choices[0].message.content.strip()
    # Clean markdown fences if any
    sql = sql.replace("```sql", "").replace("```", "").strip()
    return sql

def infer_chart_settings(columns, rows):
    # Select categorical column as x-axis, numeric as y-axis
    # Example fallback:
    x = columns[0] if columns else ""
    y = columns[1] if len(columns) > 1 else ""
    return "bar", x, y

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

---

## 3. Model Context Protocol (MCP) Integration

To run this as a registered MCP server so other clients (like Claude Desktop) can interface with it, use the official Python `mcp` library:

```python
from mcp.server.fastapi import FastApiServer
from mcp.server.models import Tool

mcp_app = FastApiServer(name="so_survey_analyst")

@mcp_app.tool()
def get_schema() -> str:
    """Returns the Snowflake view database schema context."""
    return get_database_schema_context()

@mcp_app.tool()
def execute_query(sql_query: str) -> str:
    """Executes a read-only SELECT query on the survey database."""
    df = db.read_query(sql_query)
    return df.to_string() if df is not None else "Query execution failed."

# Mount MCP on your main FastAPI application
app.mount("/mcp", mcp_app)
```
Now, you can configure your MCP client to connect to `http://localhost:8000/mcp`.

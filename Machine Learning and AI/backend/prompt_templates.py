import re

# Prompt template for LLM SQL translation
SQL_SYSTEM_PROMPT = """You are a senior data engineer and Microsoft SQL Server expert.
Your job is to translate natural language questions into optimized, read-only SELECT queries for a SQL Server instance.

Database Schema Context (Snowflake Views & Dimensions):
{schema_context}

Guidelines:
1. Return ONLY the raw T-SQL code block. Do NOT enclose it in markdown code fences (like ```sql).
2. Do not write any conversational introductions or explanations. Just start with SELECT.
3. Keep queries read-only. Avoid inserts, updates, deletes, or drop commands.
4. For multi-valued inputs, utilize the correct bridge view (e.g. Bridge_LanguageHaveWorkedWith_Clean) joining on ResponseKey.
5. Generate queries compatible with MS SQL Server syntax (e.g. use TOP instead of LIMIT).
6. Data Quality Rule: When querying compensation or salary (ConvertedCompYearly), ALWAYS filter out the following imputed values to prevent data bias: 56211.0, 67845.0, 74963.0, 65000.0, 75320.0 (e.g. c.ConvertedCompYearly NOT IN (56211.0, 67845.0, 74963.0, 65000.0, 75320.0)).
"""

# Fallback queries for offline mode / insufficient credits
FALLBACK_QUERIES = [
    {
        "keywords": ["salary", "compensation", "developer type", "profession", "role"],
        "sql": """SELECT 
  d.Current_Profession AS DevType,
  ROUND(AVG(c.ConvertedCompYearly), 2) AS AverageSalary
FROM Snowflake.Fact_Survey_Core f
JOIN Snowflake.Dim_Employment d ON f.Dim_EmploymentID = d.Dim_EmploymentID
JOIN Snowflake.Dim_Compensation c ON f.Dim_CompensationID = c.Dim_CompensationID
WHERE c.ConvertedCompYearly IS NOT NULL 
  AND c.ConvertedCompYearly NOT IN (56211.0, 67845.0, 74963.0, 65000.0, 75320.0)
GROUP BY d.Current_Profession
ORDER BY AverageSalary DESC;""",
        "chartType": "bar",
        "xAxis": "DevType",
        "yAxis": "AverageSalary",
        "summary": "Average annual developer compensation grouped by current profession, excluding imputed values (Snowflake.Fact_Survey_Core & Snowflake.Dim_Employment)."
    },
    {
        "keywords": ["sentiment", "threat", "ai", "artificial intelligence", "worry"],
        "sql": """SELECT 
  f.SurveyYear,
  a.AIThreat AS ThreatLevel,
  COUNT(*) AS TotalResponses
FROM Snowflake.Fact_Survey_Core f
JOIN Snowflake.Dim_AICentral ac ON f.Dim_AICentralID = ac.Dim_AICentralID
JOIN Snowflake.Dim_AIOpinions a ON ac.Dim_AIOpinionsID = a.Dim_AIOpinionsID
WHERE a.AIThreat IS NOT NULL AND a.AIThreat <> 'Unknown'
GROUP BY f.SurveyYear, a.AIThreat
ORDER BY f.SurveyYear, TotalResponses DESC;""",
        "chartType": "line",
        "xAxis": "SurveyYear",
        "yAxis": "TotalResponses",
        "summary": "Year-over-year developer sentiments concerning AI threat levels (Snowflake.Fact_Survey_Core & Snowflake.Dim_AIOpinions)."
    },
    {
        "keywords": ["database", "want to work", "admired", "database popularity"],
        "sql": """SELECT TOP 5 
  b.DatabaseWantToWorkWith_Clean AS DatabaseName,
  COUNT(*) AS VoteCount
FROM Snowflake.Fact_Survey_Core f
JOIN Snowflake.Bridge_DatabaseWantToWorkWith_Clean b ON f.ResponseKey = b.ResponseKey
WHERE f.SurveyYear = 2025
GROUP BY b.DatabaseWantToWorkWith_Clean
ORDER BY VoteCount DESC;""",
        "chartType": "bar",
        "xAxis": "DatabaseName",
        "yAxis": "VoteCount",
        "summary": "Top 5 most desired database technologies developers want to work with in 2025 (Snowflake.Bridge_DatabaseWantToWorkWith_Clean)."
    },
    {
        "keywords": ["remote", "in-person", "hybrid", "country", "location"],
        "sql": """SELECT 
  d.Country,
  d.RemoteWork AS WorkType,
  ROUND(AVG(c.ConvertedCompYearly), 2) AS AverageSalary
FROM Snowflake.Fact_Survey_Core f
JOIN Snowflake.Dim_Demographics d ON f.Dim_DemographicsID = d.Dim_DemographicsID
JOIN Snowflake.Dim_Employment e ON f.Dim_EmploymentID = e.Dim_EmploymentID
JOIN Snowflake.Dim_Compensation c ON f.Dim_CompensationID = c.Dim_CompensationID
WHERE d.Country IN ('United States', 'Germany', 'United Kingdom', 'India')
  AND d.RemoteWork IS NOT NULL 
  AND c.ConvertedCompYearly IS NOT NULL 
  AND c.ConvertedCompYearly NOT IN (56211.0, 67845.0, 74963.0, 65000.0, 75320.0)
GROUP BY d.Country, d.RemoteWork
ORDER BY d.Country, AverageSalary DESC;""",
        "chartType": "bar",
        "xAxis": "Country",
        "yAxis": "AverageSalary",
        "summary": "Average annual compensation comparing remote vs in-person arrangements across major countries, excluding imputed values (Fact_Survey_Core, Dim_Demographics, & Dim_Compensation)."
    }
]

def find_fallback_query(user_query: str):
    """
    Scans the user query for keywords and returns a matching pre-written T-SQL query if found.
    """
    query_lower = user_query.lower()
    for item in FALLBACK_QUERIES:
        # Check if at least 2 keywords match, or if any major keyword matches
        matches = sum(1 for kw in item["keywords"] if kw in query_lower)
        if matches >= 1:
            return item
    
    # Generic fallback
    return {
        "sql": "SELECT TOP 10 Country, AgeCode, Gender_Clean FROM Snowflake.Dim_Demographics;",
        "chartType": "bar",
        "xAxis": "Country",
        "yAxis": "AgeCode",
        "summary": "Displaying a sample slice of developer demographics as no matching topic was found in offline mode."
    }

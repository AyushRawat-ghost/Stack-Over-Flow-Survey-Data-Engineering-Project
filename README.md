# Stack Overflow Survey Data Engineering Project

## LLM & MCP Integration: AI Data Analyst

This project is being enhanced with an **AI Data Analyst** powered by the **Model Context Protocol (MCP)** and state-of-the-art **LLMs**.

### Key Features
- **Natural Language Querying**: Ask complex questions about developer trends (2021-2025) in plain English.
- **MCP Tooling**: Direct integration with our SQL Server data warehouse via a custom MCP server.
- **Hybrid Compute**:
  - **Cloud (Fireworks AI)**: For high-accuracy reasoning and SQL generation.
  - **Local (AMD HI300x GPU)**: For high-performance local inference, embeddings, and sentiment analysis using ROCm.

### Project Structure
- `Data Warehouse/`: Bronze, Silver, and Gold layers of our medallion architecture.
  - `Bronze Layer/`: Ingests raw CSVs.
  - `Silver Layer/`: Cleans and normalizes columns per year.
  - `Gold Layer/`: Unified union views and our **Snowflake Schema** views under `snowflake/`.
- `Machine Learning and AI/`: AI Analyst agent and MCP server implementation.
- `Documentation/`: Architecture diagrams, ER diagrams, and CI/CD pipelines.

---

## Snowflake Schema Architecture (Gold Layer)
We have implemented a highly optimized **Snowflake Schema** under the `Snowflake` database schema using SQL Views to keep the data model normalized, performant, and dry:
1. **Core Fact table (`Snowflake.Fact_Survey_Core`)**: Contains core metrics and key dimensions.
2. **Core Star Dimensions (9 tables)**: Demographic and work-related categories connected directly to the fact view.
3. **Snowflake Central Hubs & Sub-Dimensions (13 tables)**: `Dim_AICentral` and `Dim_TechCentral` act as intermediate hub tables branching out to granular sub-dimensions (AI models, developer tools, database engines, etc.).
4. **Bridge Views (35 tables)**: Handle many-to-many multi-value survey questions. Joins are optimized using a single surrogate key `ResponseKey` (hashing `SurveyYear` + `ResponseId`) instead of composite keys, avoiding Cartesian product inflation.

Detailed ER diagrams can be reviewed in [Gold Layer ER diagram.md](Documentation/Gold%20Layer%20ER%20diagram.md).

---

## How to Execute the Pipeline

### Prerequisites
* Anaconda/Miniconda installed.
* Target environment `Purva_Patole` created and dependencies installed:
  ```bash
  conda activate Purva_Patole
  pip install -r requirements.txt
  ```

---
*Powered by AMD Instinct™ and Fireworks AI.*

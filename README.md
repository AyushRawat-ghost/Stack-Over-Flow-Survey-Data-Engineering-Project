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
- `Machine Learning and AI/`: (New) AI Analyst agent and MCP server implementation.
- `Documentation/`: Architecture diagrams and CI/CD pipelines.

### Detailed Implementation Plan
For the full technical roadmap, see the [Implementation Plan](file:///C:/Users/Ayush/.gemini/antigravity/brain/1a44299e-daef-4f49-86da-b1f89984ca15/implementation_plan.md).

---
*Powered by AMD Instinct™ and Fireworks AI.*

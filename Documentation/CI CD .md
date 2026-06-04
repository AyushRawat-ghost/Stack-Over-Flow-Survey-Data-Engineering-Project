# CI/CD & Orchestration Diagram

Here is the CI/CD and Orchestration workflow diagram for reference:

![CI/CD & Orchestration Diagram](Ci%20CD.png)

graph TD
    subgraph "Continuous Integration (CI)"
        DEV[Developer: Ayush] -->|Git Push| GITHUB[GitHub Repository]
        GITHUB -->|Trigger| ACTIONS[GitHub Actions]
        ACTIONS -->|Linting/Unit Tests| TEST[pytest / flake8]
        TEST -->|Success| BUILD[Docker Build / Package]
    end

    subgraph "Orchestration (Airflow DAG)"
        TRIGGER[Schedule: Annual/Weekly] -->|Start DAG| S1[Task 1: Fetch Raw CSV from Bronze]
        S1 --> S2[Task 2: Execute 05_cleaning_YYYY.ipynb]
        S2 --> S3[Task 3: Run Bridge Explosions]
        S3 --> S4[Task 4: Load to Silver SQL]
        S4 --> S5[Task 5: Refresh Gold Views]
    end

    subgraph "Deployment (CD)"
        BUILD -->|Push Image| REGISTRY[Container Registry]
        REGISTRY -->|Pull| PROD[Production SQL Server]
        S5 -->|Webhook| BI[Power BI Refresh]
    end

    %% Flow connections
    GITHUB -.->|Automated Deploy| TRIGGER
    
    %% Styling
    style GITHUB fill:#24292e,color:#fff
    style ACTIONS fill:#2088ff,color:#fff
    style TRIGGER fill:#ff4500,color:#fff
    style PROD fill:#0078d4,color:#fff
graph TD
    subgraph "External Data Sources"
        CSV[Stack Overflow Annual Surveys<br/>2021 - 2025]
    end

    subgraph "Bronze Layer (Raw Data)"
        SQL_B[(SQL Server: Bronze Schema)]
        CSV -->|Initial Load| SQL_B
    end

    subgraph "Silver Layer (Cleaning & Normalization)"
        NB[Jupyter Notebooks:<br/>05_cleaning_2021.ipynb ... 2025]
        UTILS[Utils Library:<br/>normalizer.py<br/>data_type_converter.py<br/>fake_na_detection.py]
        
        SQL_B -->|Extract Raw| NB
        NB <-->|Import Helpers| UTILS
        
        NB -->|Transform| FACT[Central Fact Table:<br/>Survey_YYYY_Cleaned]
        NB -->|Explode| BRIDGE[Bridge Tables:<br/>Languages, DevType, etc.]
    end

    subgraph "SQL Data Warehouse (Refined)"
        SQL_S_Fact[(SQL Server: Silver.Survey_YYYY)]
        SQL_S_Bridge[(SQL Server: Silver.Bridge_XXXX_YYYY)]
        
        FACT -->|write_to_sql| SQL_S_Fact
        BRIDGE -->|write_to_sql| SQL_S_Bridge
    end

    subgraph "Gold Layer (Analytics & Intelligence)"
        UNION_OP{Optional: Global Union}
        MASTER[(Gold.Global_Survey_Master)]
        VIEWS[SQL Views / 06_merging.sql]
        DASH[Power BI / Dashboards]
        ML[Model Tuning & Prediction]
        AI[AI Agents / Sentiment Analysis]
        
        SQL_S_Fact -->|UNION ALL| UNION_OP
        UNION_OP -.->|Master Fact Table| MASTER
        
        SQL_S_Fact --> VIEWS
        SQL_S_Bridge --> VIEWS
        MASTER --> VIEWS
        
        VIEWS --> DASH
        VIEWS --> AI
        VIEWS --> ML
    end

    %% Styling
    style CSV fill:#f9f,stroke:#333,stroke-width:2px
    style SQL_B fill:#dfd,stroke:#333
    style SQL_S_Fact fill:#bbf,stroke:#333
    style SQL_S_Bridge fill:#bbf,stroke:#333
    style MASTER fill:#ffd700,stroke:#333,stroke-width:2px
    style UNION_OP fill:#fff,stroke:#333,stroke-dasharray: 5 5
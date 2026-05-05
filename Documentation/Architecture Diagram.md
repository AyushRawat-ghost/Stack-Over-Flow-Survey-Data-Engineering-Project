---
config:
  layout: dagre
---
graph LR
    subgraph "Ingestion (Bronze)"
        A[CSV 2021] --> B[(SQL Server<br/>Bronze Schema)]
        A1[CSV 2022] --> B
        A2[CSV 2023] --> B
        A3[CSV 2024] --> B
        A4[CSV 2025] --> B
    end

    subgraph "Processing (Silver)"
        B --> C{Jupyter Hub}
        
        subgraph "Modular Cleaning Engine"
            D[normalizer.py]
            E[data_type_converter.py]
            F[fake_na_detection.py]
        end
        
        C <--> D
        C <--> E
        C <--> F
        
        C --> G[Fact Table:<br/>Survey_YYYY]
        C --> H[Bridge Tables:<br/>Tech/Roles]
    end

    subgraph "Storage (Silver Layer)"
        G --> I[(SQL Server<br/>Refined Schema)]
        H --> I
    end

    subgraph "Consumption (Gold)"
        I --> J[06_merging.sql]
        
        J --> K[Global Union Master<br/>2021-2025]
        
        K --> L[Power BI<br/>Dashboards]
        K --> M[ML Models<br/>Salary/Trend Prediction]
        K --> N[AI Agents<br/>Sentiment Analysis]
    end
    style B fill:#f96,stroke:#333
    style I fill:#3c9,stroke:#333
    style K fill:#ffd700,stroke:#333
    style M fill:#6af,stroke:#333
    style N fill:#6af,stroke:#333
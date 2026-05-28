# Data Warehouse Architecture

This directory houses the medallion data engineering pipeline for processing Stack Overflow survey data (2021-2025) using SQL Server.

```
Data Warehouse/
├── pipleine_runner.py          # Orchestrates the full ETL pipeline
├── README.md                   # Data Warehouse documentation
│
├── Bronze Layer/               # Ingestion of raw survey CSVs
│   ├── 03_Creator.sql          # Creates raw schema and bronze tables
│   └── 04_ingestor.sql         # Bulk inserts raw CSV data
│
├── Silver Layer/               # Data cleaning and standardization
│   ├── 05_cleaning_YYYY.ipynb  # Cleaning Notebooks (per year)
│   └── utils/                  # Helper modules (Normalizers, SQL connector, etc.)
│
└── Gold Layer/                 # Storage & consumption layer
    ├── merging/                # Unified physical Gold fact & bridge tables
    └── snowflake/              # SQL views implementing the Snowflake schema
```

---

## 1. Medallion Layer Flow

### 🟫 Bronze Layer (Raw Ingestion)
* **Goal**: Bulk load raw CSV survey data for years 2021 to 2025 into staging tables.
* **Implementation**: Uses T-SQL scripts to dynamically load CSV sources from local files.

### ⬜ Silver Layer (Refinement & Cleaning)
* **Goal**: Cast types, standardize labels, clean text inputs, handle fake/missing data, and normalize attributes.
* **Implementation**: Executed year-by-year using modular Python modules inside Jupyter Notebooks.
* **Utils**:
  * `sql_connector.py`: Core connector using `pyodbc` and `sqlalchemy`.
  * `mapping_categorical.py`: Matches survey responses to standard categories.
  * `normalizer.py`: Text cleaning utilities.
  * `data_type_converter.py`: Casts columns to their optimal data types.

### 🟨 Gold Layer (Consumption & Modeling)
Divided into two stages:
1. **Physical Merging (`merging/`)**: Consolidates cleaned yearly Silver data into a single unified physical `Gold.Fact_Survey` table and accompanying bridge tables.
2. **Snowflake Views (`snowflake/`)**: Exposes the physical Gold layer in a clean, highly normalized **Snowflake Schema** using SQL views:
   * **`Fact_Survey_Core`**: Central fact view containing key measures and IDs.
   * **Core Dimensions (9 Views)**: Directly connected standard dimensions.
   * **Central Hubs & Branches (13 Views)**: Hub views (`Dim_AICentral`, `Dim_TechCentral`) connect to nested sub-dimensions (AI models, databases, platforms) to optimize performance.
   * **Bridge Views (35 Views)**: Multi-value attributes mapped using a single hashed `ResponseKey` to prevent Cartesian products.

---

## 2. Pipeline Execution

The whole pipeline is managed by `pipleine_runner.py`.

### Execution Steps
1. **Activate the conda environment**:
   ```bash
   conda activate Purva_Patole
   ```
2. **Run the full orchestrator**:
   ```bash
   python "Data Warehouse/pipleine_runner.py"
   ```

### Execution Stages in Code:
* `run_bronze()`: Builds raw Bronze tables and ingests raw survey data.
* `run_silver(year)`: Automatically executes year-specific Jupyter cleaning notebooks via **Papermill**.
* `create_gold_schema()` & `run_gold(year)`: Unified merging of data into physical Gold tables.
* `create_snowflake_schema()`: Drops and recreates the Snowflake view and bridge hierarchy.

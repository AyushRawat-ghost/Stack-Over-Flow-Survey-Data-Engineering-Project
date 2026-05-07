import os
import papermill as pm
from Silver_Layer.utils.sql_connector import SQLConnector

class PipelineOrchestrator:
    def __init__(self, database="Stack_Overflow_Survey"):
        self.db = SQLConnector(database)
        self.db.connect()
        
    def run_notebook(self, path, params=None):
        print(f"🚀 Executing Notebook: {path}...")
        try:
            # Executes the notebook and saves a temporary output version
            pm.execute_notebook(path, f"output_{os.path.basename(path)}", parameters=params)
            print(f"✅ Finished: {path}")
        except Exception as e:
            print(f"❌ Error in {path}: {e}")

    def run_sql_script(self, path):
        print(f"💾 Executing SQL Script: {path}...")
        try:
            with open(path, 'r') as file:
                query = file.read()
                # Split by 'GO' if using SQL Server specific batches
                for statement in query.split(';'):
                    if statement.strip():
                        self.db.conn.execute(statement)
            self.db.conn.commit()
            print(f"✅ Finished: {path}")
        except Exception as e:
            print(f"❌ Error in {path}: {e}")

    def execute_full_pipeline(self, year):
        print(f"--- Starting Full Pipeline for {year} ---")
        
        # 1. Bronze Layer Ingestion
        self.run_sql_script(f"Data Warehouse/Bronze Layer/03_Creator.sql")
        self.run_sql_script(f"Data Warehouse/Bronze Layer/04_ingestor.sql")
        
        # 2. Silver Layer Cleaning (specific to year)
        self.run_notebook(f"Data Warehouse/Silver Layer/05_cleaning_{year}.ipynb")
        
        # 3. Gold Layer Merging/Views
        self.run_sql_script(f"Data Warehouse/Silver Layer/06_merging.sql")
        
        print(f"--- Pipeline for {year} Completed Successfully ---")

if __name__ == "__main__":
    # Example usage: python run_pipeline.py
    orchestrator = PipelineOrchestrator()
    
    # You can loop through your years here
    years = ["2021", "2022"]
    for year in years:
        orchestrator.execute_full_pipeline(year)
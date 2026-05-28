import os
import re
import sys
import papermill as pm

# Resolve project root (one level up from this file's directory)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.dirname(BASE_DIR)

# Add Silver Layer utils to path
sys.path.append(os.path.join(BASE_DIR, 'Silver Layer', 'utils'))
from sql_connector import SQLConnector


class PipelineOrchestrator:
    def __init__(self, database="Stack_Overflow_Survey"):
        self.database = database
        self.db = None

    def connect(self):
        self.db = SQLConnector(self.database)
        self.db.connect()

    def close(self):
        if self.db:
            self.db.close()

    def run_sql_script(self, rel_path):
        """Executes a SQL script, splitting on GO statements."""
        full_path = os.path.join(BASE_DIR, rel_path)
        print(f"[SQL] {rel_path}")
        try:
            with open(full_path, 'r', encoding='utf-8') as f:
                query = f.read()
            batches = re.split(r'(?i)^\s*GO\s*$', query, flags=re.MULTILINE)
            cursor = self.db.conn.cursor()
            for batch in batches:
                batch_stripped = batch.strip()
                if batch_stripped:
                    cursor.execute(batch_stripped)
            self.db.conn.commit()
            print(f"  Done: {rel_path}")
        except Exception as e:
            print(f"  ERROR in {rel_path}: {e}")
            raise

    def run_notebook(self, rel_path):
        """Executes a Jupyter notebook via Papermill."""
        full_path = os.path.join(BASE_DIR, rel_path)
        output_path = os.path.join(BASE_DIR, f"output_{os.path.basename(full_path)}")
        print(f"[NB]  {rel_path}")
        try:
            pm.execute_notebook(full_path, output_path)
            print(f"  Done: {rel_path}")
        except Exception as e:
            print(f"  ERROR in {rel_path}: {e}")
            raise

    # =========================================================================
    # STEP 1 — Bronze Layer
    # Run once: creates all Bronze tables and bulk-loads all years' CSV data.
    # =========================================================================
    def run_bronze(self):
        print("\n=== BRONZE LAYER ===")
        self.run_sql_script("Bronze Layer/03_Creator.sql")
        self.run_sql_script("Bronze Layer/04_ingestor.sql")

    # =========================================================================
    # STEP 2 — Silver Layer
    # Run per year: cleans raw Bronze data and writes to Silver tables.
    # =========================================================================
    def run_silver(self, year):
        print(f"\n=== SILVER LAYER — {year} ===")
        self.run_notebook(f"Silver Layer/05_cleaning_{year}.ipynb")

    # =========================================================================
    # STEP 3 — Gold Layer Schema
    # Run once: drops and recreates unified Gold.Fact_Survey + Bridge tables.
    # =========================================================================
    def create_gold_schema(self):
        print("\n=== GOLD LAYER — Schema Setup ===")
        self.run_sql_script("Gold Layer/06_create_gold_tables.sql")

    # =========================================================================
    # STEP 4 — Gold Layer Load
    # Run per year: upserts (delete+insert) that year's data into Gold tables.
    # =========================================================================
    def run_gold(self, year):
        print(f"\n=== GOLD LAYER — Load {year} ===")
        self.run_sql_script(f"Gold Layer/06_merging_{year}.sql")

    # =========================================================================
    # STEP 5 — Snowflake Schema Setup
    # Run once: Creates all normalized dimension, hub, and bridge views.
    # =========================================================================
    def create_snowflake_schema(self):
        print("\n=== SNOWFLAKE LAYER — Schema Setup ===")
        self.run_sql_script("Gold Layer/snowflake/07_split_fact_tables.sql")
        self.run_sql_script("Gold Layer/snowflake/08_split_bridge_tables.sql")

    # =========================================================================
    # FULL PIPELINE
    # One call to run everything from Bronze -> Silver -> Gold for all years.
    # =========================================================================
    def run_all(self, years=None):
        if years is None:
            years = ["2021", "2022", "2023", "2024", "2025"]

        print("=" * 60)
        print("  Stack Overflow Survey — Full Data Warehouse Pipeline")
        print("=" * 60)

        try:
            self.connect()

            # Step 1: Bronze (all years in one shot)
            self.run_bronze()

            # Step 2 + 4: Silver clean then Gold load, year by year
            self.create_gold_schema()

            for year in years:
                self.run_silver(year)
                self.run_gold(year)

            # Step 5: Snowflake schema creation
            self.create_snowflake_schema()

            print("\n" + "=" * 60)
            print("  Pipeline completed successfully for years:", years)
            print("=" * 60)

        finally:
            self.close()


if __name__ == "__main__":
    orchestrator = PipelineOrchestrator(database="Stack_Overflow_Survey")
    orchestrator.run_all(years=["2021", "2022", "2023", "2024", "2025"])
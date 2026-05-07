import pyodbc
import pandas as pd
from sqlalchemy import create_engine
import urllib

class SQLConnector:
    def __init__(self, database):
        self.server = r'LAPTOP-LFBT0G3K\SQLEXPRESS'
        self.database = database
        self._conn_str = (
            f'DRIVER={{ODBC Driver 17 for SQL Server}};'
            f'SERVER={self.server};'
            f'DATABASE={self.database};'
            f'Trusted_Connection=yes;'
        )
        self.conn = None
        self.engine = None
    
    def connect(self):
        try:
            self.conn = pyodbc.connect(self._conn_str)
            params = urllib.parse.quote_plus(self._conn_str)
            self.engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")
            
            print(f"Successfully Connected to {self.database}")
            return self 
        except Exception as e:
            print(f"Failed to Connect to {self.database}: {e}")
            return None

    def write_to_sql(self, df, table_name, schema='Silver'):
        if not self.engine:
            print("Error: Engine not initialized. Call connect() first.")
            return
        try:
            df.to_sql(table_name, self.engine, schema=schema, if_exists='replace', index=False)
            print(f"DataFrame written to {schema}.{table_name} successfully.")
        except Exception as e:
            print(f"Failed to write {table_name}: {e}")

    def read_query(self, query):
        if not self.conn:
            print("Error: Connection not initialized. Call connect() first.")
            return None
        try:
            df = pd.read_sql_query(query, self.conn)
            print("Query executed successfully")
            return df
        except Exception as e:
            print(f"Failed to execute query: {e}")
            return None

    def close(self):
        if self.conn:
            self.conn.close()
            print("Connection closed.")
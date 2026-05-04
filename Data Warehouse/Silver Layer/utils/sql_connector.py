import pyodbc
import pandas as pd
from sqlalchemy import create_engine
import urllib


def read_sql_query(query, conn):
    try:
        df = pd.read_sql_query(query, conn)
        print("Query executed successfully")
        return df
    except Exception as e:
        print("Failed to execute query", e)

def connect_sql(database):
    server = r'LAPTOP-LFBT0G3K\SQLEXPRESS'
    
    # 1. Standard Connection String
    conn_str = (
        f'DRIVER={{ODBC Driver 17 for SQL Server}};'
        f'SERVER={server};'
        f'DATABASE={database};'
        f'Trusted_Connection=yes;'
    )
    
    try:
        conn = pyodbc.connect(conn_str)
        params = urllib.parse.quote_plus(conn_str)
        engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")
        
        print("Successfully Connected")
        return conn, engine
    except Exception as e:
        print("Failed to Connect", e)
        return None, None

def write_to_sql(df, table_name, engine,schema):
    try:
        df.to_sql(table_name, engine,schema, if_exists='replace', index=False )
        print(f"DataFrame written to SQL table 'Silver.{table_name}' successfully.")
    except Exception as e:
        print(f"Failed to write DataFrame to SQL table '{table_name}':", e)

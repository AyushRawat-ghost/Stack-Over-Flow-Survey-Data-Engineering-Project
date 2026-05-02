import pyodbc
def connect_sql(database):
    # SQL Connector
    server = r'LAPTOP-LFBT0G3K\SQLEXPRESS'
    database = database

    conn_str=(
        f'DRIVER={{ODBC Driver 17 for SQL Server}};'
        f'Server={server};'
        f'DATABASE={database};'
        f'Trusted_Connection=yes;'
    )
  
    try:
        conn=pyodbc.connect(conn_str)
        print ("Succesfully Connected")
        return conn
    except Exception as e :
        print("Failed to Connect",e)


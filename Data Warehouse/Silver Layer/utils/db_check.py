import pyodbc

conn_str = (
    r'DRIVER={ODBC Driver 17 for SQL Server};'
    r'SERVER=LAPTOP-LFBT0G3K\SQLEXPRESS;'
    r'DATABASE=Stack_Overflow_Survey;'
    r'Trusted_Connection=yes;'
)

try:
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()
    print("Connection successful!")
    
    print("\n--- SAMPLE WorkExp VALUES IN Bronze.Survey_2025 ---")
    cursor.execute("""
        SELECT TOP 20 WorkExp, COUNT(*) 
        FROM Bronze.Survey_2025 
        GROUP BY WorkExp
        ORDER BY COUNT(*) DESC
    """)
    for row in cursor.fetchall():
        print(f"  Value: {row[0]}, Count: {row[1]}")
        
    print("\n--- SAMPLE YearsCodePro VALUES IN Bronze.Survey_2024 ---")
    cursor.execute("""
        SELECT TOP 20 YearsCodePro, COUNT(*) 
        FROM Bronze.Survey_2024 
        GROUP BY YearsCodePro
        ORDER BY COUNT(*) DESC
    """)
    for row in cursor.fetchall():
        print(f"  Value: {row[0]}, Count: {row[1]}")
        
    conn.close()
except Exception as e:
    print("Error:", e)

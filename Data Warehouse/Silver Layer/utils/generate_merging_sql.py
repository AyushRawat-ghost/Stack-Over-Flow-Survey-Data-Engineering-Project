import sys
import os
import re

sys.path.append(os.path.join(os.getcwd(), 'Data Warehouse', 'Silver Layer'))
from utils.sql_connector import SQLConnector

def get_sql_type(data_type, char_len):
    """
    Returns the SQL type string based on type and max length.
    """
    data_type_upper = data_type.upper()
    if data_type_upper in ('VARCHAR', 'NVARCHAR'):
        if char_len is None or char_len == -1:
            return f"{data_type_upper}(MAX)"
        else:
            return f"{data_type_upper}({char_len})"
    return data_type_upper

def main():
    db = SQLConnector('Stack_Overflow_Survey')
    if not db.connect():
        print("Failed to connect to the database.")
        sys.exit(1)
        
    try:
        print("Querying table columns metadata...")
        
        # Query fact columns
        query_fact = """
        SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = 'Silver' AND TABLE_NAME LIKE 'Survey_20%'
        ORDER BY COLUMN_NAME, TABLE_NAME;
        """
        df_fact = db.read_query(query_fact)
        
        # Query bridge columns
        query_bridge = """
        SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = 'Silver' AND TABLE_NAME LIKE 'Bridge_%_20%'
        ORDER BY TABLE_NAME, COLUMN_NAME;
        """
        df_bridge = db.read_query(query_bridge)
        
        if df_fact is None or df_bridge is None:
            print("Failed to retrieve columns from database.")
            sys.exit(1)
            
        print(f"Fact columns retrieved: {len(df_fact)}")
        print(f"Bridge columns retrieved: {len(df_bridge)}")
        
        # --- PROCESS FACT COLUMNS ---
        fact_cols = {}  # {col_name: {'type': sql_type, 'years': {yr: sql_type}, 'raw_type': dtype, 'char_len': char_len}}
        years = sorted(list(set(int(re.findall(r'\d{4}', t)[0]) for t in df_fact['TABLE_NAME'].unique())))
        print(f"Detected fact tables for years: {years}")
        
        for idx, row in df_fact.iterrows():
            tbl = row['TABLE_NAME']
            col = row['COLUMN_NAME']
            dtype = row['DATA_TYPE']
            try:
                char_len = int(row['CHARACTER_MAXIMUM_LENGTH']) if row['CHARACTER_MAXIMUM_LENGTH'] is not None and not sys.isnan(row['CHARACTER_MAXIMUM_LENGTH']) else None
            except:
                char_len = None
                
            yr = int(re.findall(r'\d{4}', tbl)[0])
            
            # Skip keys that will be handled explicitly
            if col in ('SurveyYear', 'ResponseId'):
                continue
                
            sql_type = get_sql_type(dtype, char_len)
            
            if col not in fact_cols:
                fact_cols[col] = {
                    'type': sql_type,
                    'years': {yr: sql_type},
                    'raw_type': dtype,
                    'char_len': char_len
                }
            else:
                fact_cols[col]['years'][yr] = sql_type
                if char_len is not None:
                    existing_char_len = fact_cols[col]['char_len']
                    if existing_char_len is None or existing_char_len == -1 or char_len > existing_char_len:
                        fact_cols[col]['char_len'] = char_len
                        fact_cols[col]['type'] = sql_type
                    elif char_len == -1:
                        fact_cols[col]['char_len'] = -1
                        fact_cols[col]['type'] = f"{dtype.upper()}(MAX)"
                        
        # --- PROCESS BRIDGE COLUMNS ---
        bridge_groups = {} # {base_col_name: {yr: {'tbl_name': t, 'val_col': c, 'type': sql_type}}}
        bridge_tbls = df_bridge['TABLE_NAME'].unique()
        bridge_pattern = re.compile(r'^Bridge_(.+)_(\d{4})$')
        
        for tbl in bridge_tbls:
            m = bridge_pattern.match(tbl)
            if not m:
                continue
            base_col, yr_str = m.groups()
            yr = int(yr_str)
            
            tbl_cols = df_bridge[df_bridge['TABLE_NAME'] == tbl]
            val_cols = tbl_cols[tbl_cols['COLUMN_NAME'] != 'ResponseId']
            if val_cols.empty:
                continue
                
            val_row = val_cols.iloc[0]
            val_col_name = val_row['COLUMN_NAME']
            dtype = val_row['DATA_TYPE']
            try:
                char_len = int(val_row['CHARACTER_MAXIMUM_LENGTH']) if val_row['CHARACTER_MAXIMUM_LENGTH'] is not None and not sys.isnan(val_row['CHARACTER_MAXIMUM_LENGTH']) else None
            except:
                char_len = None
                
            sql_type = get_sql_type(dtype, char_len)
            if dtype.upper() in ('VARCHAR', 'NVARCHAR') and (char_len is None or char_len == -1 or char_len > 255):
                sql_type = f"{dtype.upper()}(255)"
                
            if base_col not in bridge_groups:
                bridge_groups[base_col] = {}
            bridge_groups[base_col][yr] = {
                'tbl_name': tbl,
                'val_col': val_col_name,
                'type': sql_type
            }

        gold_dir = os.path.join(os.getcwd(), 'Data Warehouse', 'Gold Layer')
        
        # =========================================================================
        # 1. GENERATE DDL SCRIPT (06_create_gold_tables.sql)
        # =========================================================================
        ddl_content = []
        ddl_content.append("IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Gold') EXEC('CREATE SCHEMA Gold');")
        ddl_content.append("GO\n")
        
        # Drop bridge tables
        for base_col in sorted(bridge_groups.keys()):
            ddl_content.append(f"IF OBJECT_ID('Gold.Bridge_{base_col}', 'U') IS NOT NULL DROP TABLE Gold.Bridge_{base_col};")
        ddl_content.append("GO\n")
        
        # Drop fact table
        ddl_content.append("IF OBJECT_ID('Gold.Fact_Survey', 'U') IS NOT NULL DROP TABLE Gold.Fact_Survey;")
        ddl_content.append("GO\n")
        
        # Create fact table
        ddl_content.append("CREATE TABLE Gold.Fact_Survey (")
        ddl_content.append("    SurveyYear DATETIME NOT NULL,")
        ddl_content.append("    ResponseId VARCHAR(50) NOT NULL,")
        for col in sorted(fact_cols.keys()):
            ddl_content.append(f"    [{col}] {fact_cols[col]['type']} NULL,")
        ddl_content.append("    PRIMARY KEY (SurveyYear, ResponseId)")
        ddl_content.append(");")
        ddl_content.append("GO\n")
        
        # Create bridge tables
        for base_col in sorted(bridge_groups.keys()):
            bridge_type = "VARCHAR(255)"
            for yr, info in bridge_groups[base_col].items():
                bridge_type = info['type']
                
            ddl_content.append(f"CREATE TABLE Gold.Bridge_{base_col} (")
            ddl_content.append("    SurveyYear DATETIME NOT NULL,")
            ddl_content.append("    ResponseId VARCHAR(50) NOT NULL,")
            ddl_content.append(f"    [{base_col}] {bridge_type} NOT NULL,")
            ddl_content.append(f"    PRIMARY KEY (SurveyYear, ResponseId, [{base_col}]),")
            ddl_content.append("    FOREIGN KEY (SurveyYear, ResponseId) REFERENCES Gold.Fact_Survey(SurveyYear, ResponseId) ON DELETE CASCADE")
            ddl_content.append(");")
            ddl_content.append("GO\n")
            
        ddl_path = os.path.join(gold_dir, '06_create_gold_tables.sql')
        with open(ddl_path, 'w', encoding='utf-8') as f:
            f.write("\n".join(ddl_content))
        print(f"Successfully generated DDL: {ddl_path}")
        
        # =========================================================================
        # 2. GENERATE YEAR-WISE DML SCRIPTS (06_merging_YYYY.sql)
        # =========================================================================
        for yr in years:
            dml_content = []
            
            # --- FACT LOAD ---
            # Delete existing fact records for this year
            dml_content.append(f"DELETE FROM Gold.Fact_Survey WHERE SurveyYear = CAST('{yr}-01-01' AS DATETIME);")
            dml_content.append("GO\n")
            
            # Find columns present in this specific year
            yr_cols = []
            for col in sorted(fact_cols.keys()):
                if yr in fact_cols[col]['years']:
                    yr_cols.append(col)
                    
            dml_content.append("INSERT INTO Gold.Fact_Survey (SurveyYear, ResponseId, " + ", ".join(f"[{col}]" for col in yr_cols) + ")")
            dml_content.append(f"SELECT CAST('{yr}-01-01' AS DATETIME) AS SurveyYear, ResponseId, " + ", ".join(f"[{col}]" for col in yr_cols))
            dml_content.append(f"FROM Silver.Survey_{yr};")
            dml_content.append("GO\n")
            
            # --- BRIDGE LOAD ---
            for base_col in sorted(bridge_groups.keys()):
                # Only insert if this bridge column is present in this year
                if yr in bridge_groups[base_col]:
                    info = bridge_groups[base_col][yr]
                    dml_content.append(f"DELETE FROM Gold.Bridge_{base_col} WHERE SurveyYear = CAST('{yr}-01-01' AS DATETIME);")
                    dml_content.append("GO\n")
                    dml_content.append(f"INSERT INTO Gold.Bridge_{base_col} (SurveyYear, ResponseId, [{base_col}])")
                    dml_content.append(f"SELECT CAST('{yr}-01-01' AS DATETIME) AS SurveyYear, ResponseId, [{info['val_col']}]")
                    dml_content.append(f"FROM Silver.{info['tbl_name']}")
                    dml_content.append(f"WHERE [{info['val_col']}] IS NOT NULL;")
                    dml_content.append("GO\n")
                    
            dml_path = os.path.join(gold_dir, f'06_merging_{yr}.sql')
            with open(dml_path, 'w', encoding='utf-8') as f:
                f.write("\n".join(dml_content))
            print(f"Successfully generated DML for {yr}: {dml_path}")
            
    finally:
        db.close()

if __name__ == '__main__':
    main()

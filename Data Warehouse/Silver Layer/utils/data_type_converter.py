import pandas as pd
class DataTypeConverter:
    def __init__(self):
        pass
    def string_to_category(self,df, categorical_cols):
        for col in categorical_cols:
            df[col] = df[col].astype("category")
        return df

    def string_to_numeric(self,df, numeric_cols):
        for col in numeric_cols:
            df[col] = pd.to_numeric(df[col], errors='coerce')
        return df

import pandas as pd

def string_to_category(df, categorical_cols):
    for col in categorical_cols:
        df[col] = df[col].astype("category")
    return df

def string_to_numeric(df, numeric_cols):
    for col in numeric_cols:
        df[col] = pd.to_numeric(df[col], errors='coerce')
    return df

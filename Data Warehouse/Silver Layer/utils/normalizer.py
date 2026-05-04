import pandas as pd

def normalize_categorical_columns_manual_mapping(df, un_normalized_cols_name, normalized_cols_name, columns_map):
    for un_normalized_col,normalized_col, col_map in zip(
        un_normalized_cols_name,
        normalized_cols_name, 
        columns_map
    ):
        print(df[un_normalized_col].unique())
        df[un_normalized_col].value_counts(dropna=False)
        df[normalized_col] = df[un_normalized_col].map(col_map).fillna("Not Available or Applicable")
        print(df[normalized_col].value_counts(dropna=False))
    return df


def normalize_na_replacer_columns(df,nan_replacer_columns, cleaned_nan_replacer_columns,replacer_value="Not Available or Applicable"):
    for col,renamed_col in zip(nan_replacer_columns, cleaned_nan_replacer_columns):
        df[renamed_col] = df[col].fillna(replacer_value)
    return df


def normalize_categorical_columns_non_exploding(df, multi_select_cols, multi_select_normalized,multi_select_maps):
    for col, normalized_col, select_map in zip(multi_select_cols, multi_select_normalized, multi_select_maps):
        df[normalized_col] = df[col].map(select_map)

        is_multi = df[col].str.contains(';', na=False)
        df.loc[is_multi, normalized_col] = 'Diverse / Multiple'

        df[normalized_col] = df[normalized_col].fillna('Unknown')
        print(df[normalized_col].value_counts())
    return df


def normalize_categorical_columns_exploding(df, multi_select_cols, multi_select_normalized, multi_select_maps):
    bridge_results = {}
    
    for col, normalized_col, select_map in zip(multi_select_cols, multi_select_normalized, multi_select_maps):
        temp_bridge = df[['ResponseId', col]].copy()
        temp_bridge[col] = temp_bridge[col].str.split(';')
        
        temp_bridge = temp_bridge.explode(col)
        
        if select_map:
            temp_bridge[normalized_col] = temp_bridge[col].str.strip().map(select_map)
        else:
            temp_bridge[normalized_col] = temp_bridge[col].str.strip()

        temp_bridge[normalized_col] = temp_bridge[normalized_col].fillna('Other/Unknown')
        
        bridge_results[normalized_col] = temp_bridge
        print(f"--- Distribution for {normalized_col} ---")
        print(temp_bridge[normalized_col].value_counts())
        print("-" * 30)
    return bridge_results

def clean_years_columns(df, cols):
    for col in cols:
        df[col] = df[col].replace('Less than 1 year', 0.5)
        df[col] = df[col].replace('More than 50 years', 51)

        df[col] = pd.to_numeric(df[col], errors='coerce')

        df[col] = df[col].fillna(0).astype(int)
    return df

def fill_na_and_remove_outlier_percentaile_method(df, col, lower_percentile=0.01, upper_percentile=0.99):
    lower_bound = df[col].quantile(lower_percentile)
    upper_bound = df[col].quantile(upper_percentile)

    df[col] = df[col].clip(lower=lower_bound, upper=upper_bound)

    median_value = df[col].median()
    df[col] = df[col].fillna(median_value)

    return df

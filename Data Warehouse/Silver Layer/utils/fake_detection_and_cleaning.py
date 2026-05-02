# Detecting and removing fake nulls
import pprint
import numpy as np

fake_nulls=["NA","N/A","","None",'none','null',""," ","nan","Nan"]

def detect_fake_nulls(df,fake_nulls=fake_nulls):
    audit={}
    for col in df.columns:
        counts = df[col].value_counts(dropna=False)
        found = {k: counts[k] for k in fake_nulls if k in counts}
        if found:
            audit[col]=found
    pprint.pprint(audit)

def replace_fake_nulls(df,fake_null=fake_nulls):
    df.replace(fake_nulls,np.nan,inplace=True)
    return df
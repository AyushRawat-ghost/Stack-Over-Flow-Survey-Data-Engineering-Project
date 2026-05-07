# Detecting and removing fake nulls
import pprint
import numpy as np

fake_nulls=["NA","N/A","","None",'none','null',""," ","nan","Nan"]

class FakeNullDetector:
    def __init__(self, fake_nulls=fake_nulls):
        self.fake_nulls = fake_nulls
        
    def detect_fake_nulls(self, df, fake_nulls=None):
        if fake_nulls is None:
            fake_nulls = self.fake_nulls
        audit={}
        for col in df.columns:
            counts = df[col].value_counts(dropna=False)
            found = {k: counts[k] for k in fake_nulls if k in counts}
            if found:
                audit[col]=found
        pprint.pprint(audit)

    def replace_fake_nulls(self, df, fake_null=None):
        if fake_null is None:
            fake_null = self.fake_nulls
        df.replace(fake_null, np.nan, inplace=True)
        return df
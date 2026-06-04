import os
from dotenv import load_dotenv

# Load variables from .env
load_dotenv()

class Config:
    FIREWORKS_API_KEY = os.getenv("FIREWORKS_API_KEY", "")
    DB_SERVER = os.getenv("DB_SERVER", r"LAPTOP-LFBT0G3K\SQLEXPRESS")
    DB_NAME = os.getenv("DB_NAME", "Stack_Overflow_Survey")
    LLM_MODEL = os.getenv("LLM_MODEL", "accounts/fireworks/models/llama-v3p1-70b-instruct")

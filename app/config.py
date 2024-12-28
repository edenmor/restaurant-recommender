import os

class Config:
    DEBUG = os.getenv("DEBUG", True)
    DATABASE_URI = os.getenv("DATABASE_URI", "mongodb://localhost:27017")
    SECRET_KEY = os.getenv("SECRET_KEY", "your-secret-key")

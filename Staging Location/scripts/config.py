import os

# ---------- Application Configuration ----------

# Base Directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Log Directory
LOG_DIRECTORY = os.path.join(BASE_DIR, "logs")

# Log File
LOG_FILE = os.path.join(LOG_DIRECTORY, "dummy.log")

# ---------- Authentication Configuration ----------

CLIENT_ID = os.getenv("AZURE_CLIENT_ID")
TENANT_ID = os.getenv("AZURE_TENANT_ID")
CLIENT_SECRET = os.getenv("AZURE_CLIENT_SECRET")

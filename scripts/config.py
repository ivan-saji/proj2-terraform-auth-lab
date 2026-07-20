import os

# Base Directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Log Directory
LOG_DIRECTORY = os.path.join(BASE_DIR, "logs")

# Log File
LOG_FILE = os.path.join(LOG_DIRECTORY, "dummy.log")
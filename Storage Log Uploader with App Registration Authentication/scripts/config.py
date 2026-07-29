import os
import socket
from datetime import datetime

# ============================================================
# Local Application Configuration
# ============================================================

# Base directory of the project
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Local folder where logs are created
LOG_DIRECTORY = os.path.join(BASE_DIR, "logs")

HOSTNAME = socket.gethostname()

TIMESTAMP = datetime.now().strftime("%d%m%Y_%H%M%S")

LOG_FILENAME = f"{HOSTNAME}_log_{TIMESTAMP}.log"

LOG_FILE = os.path.join(LOG_DIRECTORY, LOG_FILENAME)


# ============================================================
# Azure Service Principal Configuration
# (Read from Environment Variables)
# ============================================================

CLIENT_ID = os.getenv("AZURE_CLIENT_ID")
TENANT_ID = os.getenv("AZURE_TENANT_ID")
CLIENT_SECRET = os.getenv("AZURE_CLIENT_SECRET")


# ============================================================
# Azure Key Vault Configuration
# ============================================================

KEYVAULT_NAME = "tf-keyvault-ivan-authlab"

# Secret stored inside Key Vault
SECRET_NAME = "storage-connection-string"


# ============================================================
# Azure Storage Configuration
# ============================================================

# Container where logs will be uploaded
STORAGE_CONTAINER = "logs"

# Blob name inside the container
BLOB_NAME = LOG_FILENAME
from datetime import datetime
import os

from azure.identity import ManagedIdentityCredential
from azure.storage.blob import BlobServiceClient

import config

def create_dummy_log():
    """
    Create a dummy log file locally.
    """
    os.makedirs(config.LOG_DIRECTORY, exist_ok=True)
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(config.LOG_FILE, "a") as logfile:
        logfile.write(f"{current_time} - Application is running\n")

    print("✅ Dummy log created successfully.")


def upload_log(credential):
    """
    Upload dummy.log to Azure Blob Storage.
    """

    print("Uploading log to Azure Storage...")

    blob_service_client = BlobServiceClient(
    account_url=f"https://{config.STORAGE_ACCOUNT_NAME}.blob.core.windows.net",
    credential=credential
)

    blob_client = blob_service_client.get_blob_client(
        container=config.STORAGE_CONTAINER,
        blob=config.BLOB_NAME
    )

    with open(config.LOG_FILE, "rb") as data:

        blob_client.upload_blob(
            data,
            overwrite=True
        )

    print("✅ Log uploaded successfully.\n")


def main():

    create_dummy_log()

    credential = ManagedIdentityCredential()
    print("✅ Managed Identity authenticated.")

    #Verify the token acquisition
    credential.get_token("https://storage.azure.com/.default")

    upload_log(credential)
    print("==============================")
    print("Project completed successfully!")
    print("==============================")


if __name__ == "__main__":
    main()

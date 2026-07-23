from datetime import datetime
import os

from azure.identity import ClientSecretCredential
from azure.keyvault.secrets import SecretClient
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


def authenticate():
    """
    Authenticate using Azure Service Principal.
    """

    print("\n===================================")
    print("Authenticating with Azure...")
    print("===================================\n")

    credential = ClientSecretCredential(
        tenant_id=config.TENANT_ID,
        client_id=config.CLIENT_ID,
        client_secret=config.CLIENT_SECRET
    )

    # Force authentication by requesting a token
    credential.get_token("https://vault.azure.net/.default")

    print("✅ Authentication successful.\n")

    return credential


def read_secret(credential):
    """
    Read Storage Account connection string from Key Vault.
    """

    print("Reading secret from Key Vault...")

    vault_url = f"https://{config.KEYVAULT_NAME}.vault.azure.net"

    secret_client = SecretClient(
        vault_url=vault_url,
        credential=credential
    )

    connection_string = secret_client.get_secret(
        config.SECRET_NAME
    ).value

    print("✅ Secret retrieved successfully.\n")

    return connection_string


def upload_log(connection_string):
    """
    Upload dummy.log to Azure Blob Storage.
    """

    print("Uploading log to Azure Storage...")

    blob_service_client = BlobServiceClient.from_connection_string(
        connection_string
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

    credential = authenticate()

    connection_string = read_secret(credential)

    upload_log(connection_string)

    print("==============================")
    print("Project completed successfully!")
    print("==============================")


if __name__ == "__main__":
    main()

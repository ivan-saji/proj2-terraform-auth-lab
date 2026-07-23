from datetime import datetime
import os

import config


def create_dummy_log():

    os.makedirs(config.LOG_DIRECTORY, exist_ok=True)

    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    with open(config.LOG_FILE, "a") as logfile:
        logfile.write(f"{current_time} - Application is running\n")

    print("Dummy log created successfully.")


def authenticate():

    print("Reading credentials...\n")

    print(f"Client ID     : {config.CLIENT_ID}")
    print(f"Tenant ID     : {config.TENANT_ID}")
    print(f"Client Secret : {config.CLIENT_SECRET}")

    print("\nAuthentication will be implemented next.")

def main():

    create_dummy_log()
    authenticate()
    

if __name__ == "__main__":
    main()
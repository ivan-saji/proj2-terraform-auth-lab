# Create you app registrations here

resource "azuread_application" "app_storage_uploader" {
    display_name = "terraform-storage-uploader"
}

# Service Principals

resource "azuread_service_principal" "sp_storage_uploader" {
    client_id = azuread_application.app_storage_uploader.client_id
}

# Client Secret

resource "azuread_application_password" "sp_storage_uploader_secret" {
    application_id = azuread_application.app_storage_uploader.id
    display_name   = "terraform-storage-uploader-secret"
    end_date_relative = "4320h"  # 180 days
}
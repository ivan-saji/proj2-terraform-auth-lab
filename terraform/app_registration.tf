# Create you app registrations here

resource "azuread_application" "storage_uploader" {
    display_name = "terraform-storage-uploader"
}


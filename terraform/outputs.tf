#mention the outputs here

output "app_storage_uploader_client_secret" {
    value = azuread_application_password.sp_storage_uploader_secret.value
    sensitive = true
}
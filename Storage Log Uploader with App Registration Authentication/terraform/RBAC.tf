#Set your RBAC rules here

#Role Assignment for Contributor for storage account
resource "azurerm_role_assignment" "contributor_storage_account" {
  scope                = azurerm_storage_account.st01_logs.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.sp_storage_uploader.object_id
}

resource "azurerm_role_assignment" "terraform_keyvault_admin" {

  scope                = azurerm_key_vault.tf_keyvault.id

  role_definition_name = "Key Vault Administrator"

  principal_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "sp_keyvault_secret_user" {

  scope = azurerm_key_vault.tf_keyvault.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = azuread_service_principal.sp_storage_uploader.object_id
}
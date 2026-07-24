#Set your RBAC rules here

#Fetch data from App Registration for Terraform Service Principal
data "azuread_service_principal" "terraform_storage_uploader" {
  display_name = "terraform-storage-uploader"
}

#Role Assignment for Contributor for storage account
resource "azurerm_role_assignment" "contributor_storage_account" {
  scope                = azurerm_storage_account.st01_logs.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_service_principal.terraform_storage_uploader.object_id
}

resource "azurerm_role_assignment" "terraform_keyvault_admin" {

  scope                = azurerm_key_vault.tf_keyvault.id

  role_definition_name = "Key Vault Administrator"

  principal_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "sp_keyvault_secret_user" {

  scope = azurerm_key_vault.tf_keyvault.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = data.azuread_service_principal.terraform_storage_uploader.object_id
}
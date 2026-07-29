#Set your RBAC rules here

#Role Assignment for Contributor for storage account
resource "azurerm_role_assignment" "contributor_storage_account" {
  scope                = azurerm_storage_account.st01_logs.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm01.identity[0].principal_id
}

resource "azurerm_role_assignment" "terraform_keyvault_admin" {

  scope                = azurerm_key_vault.tf_keyvault.id

  role_definition_name = "Key Vault Administrator"

  principal_id = azurerm_linux_virtual_machine.vm01.identity[0].principal_id
}
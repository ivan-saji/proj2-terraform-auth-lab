# Store Keyvault secrets here

resource "azurerm_key_vault_secret" "storage_connection_string" {
  name         = "storage-connection-string"
  value        = azurerm_storage_account.st01_logs.primary_connection_string
  key_vault_id = azurerm_key_vault.tf_keyvault.id
}

#Define the storage account to store logs

resource "azurerm_storage_account" "st01-logs" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg-infra-02-vm.name
  location                 = azurerm_resource_group.rg-infra-02-vm.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_id    = azurerm_storage_account.st01-logs.id
  container_access_type = "private"
}
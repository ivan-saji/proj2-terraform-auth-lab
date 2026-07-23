#Create a Key Vault to store secrets

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "tf_keyvault" {
  name                        = "tf-keyvault-ivan-authlab"
  location                    = azurerm_resource_group.rg_infra_02_vm.location
  resource_group_name         = azurerm_resource_group.rg_infra_02_vm.name

  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7

  purge_protection_enabled    = false
  rbac_authorization_enabled  = true

  sku_name = "standard"
}
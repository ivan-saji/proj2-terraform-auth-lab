#Define the resource groups here

resource "azurerm_resource_group" "rg_infra_02_vm" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
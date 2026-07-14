#Define the resource groups here

resource "azurerm_resource_group" "rg-infra-02-vm" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
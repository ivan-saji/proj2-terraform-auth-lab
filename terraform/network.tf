# Mention the network here

resource "azurerm_virtual_network" "rg02-vnet" {
  name                = "rg02-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-infra-02-vm.location
  resource_group_name = azurerm_resource_group.rg-infra-02-vm.name
}

resource "azurerm_subnet" "rg02-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg-infra-02-vm.name
  virtual_network_name = azurerm_virtual_network.rg02-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
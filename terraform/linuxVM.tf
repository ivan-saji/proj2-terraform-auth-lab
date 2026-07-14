# Create the Linux VM here

resource "azurerm_network_interface" "vm01-nic" {
  name                = "vm01-nic"
  location            = azurerm_resource_group.rg-infra-02-vm.location
  resource_group_name = azurerm_resource_group.rg-infra-02-vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.rg02-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.10"
  }
}

resource "azurerm_linux_virtual_machine" "vm01" {
  name                = "vm01"
  resource_group_name = azurerm_resource_group.rg-infra-02-vm.name
  location            = azurerm_resource_group.rg-infra-02-vm.location
  size                = "Standard_D4_v5"
  
  admin_username      = "adminuser"
  admin_password      = "P@ssword1234!"

  network_interface_ids = [
    azurerm_network_interface.vm01-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
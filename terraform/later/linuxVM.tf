# Create the Linux VM here

resource "azurerm_network_interface" "vm01_nic" {
  name                = "vm01-nic"
  location            = azurerm_resource_group.rg_infra_02_vm.location
  resource_group_name = azurerm_resource_group.rg_infra_02_vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.rg02_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.10"
  }
}

resource "azurerm_linux_virtual_machine" "vm01" {
  name                            = "vm01"
  resource_group_name             = azurerm_resource_group.rg_infra_02_vm.name
  location                        = azurerm_resource_group.rg_infra_02_vm.location
  size                            = "Standard_F1as_v7"
  disable_password_authentication = false

  admin_username = "adminuser"
  admin_password = "P@ssword1234!"

  custom_data = base64encode(
  templatefile("${path.module}/cloud_init.tftpl", {
    python_script     = file("${path.module}/../scripts/upload_logs.py")
    config_file       = file("${path.module}/../scripts/config.py")
    requirements_file = file("${path.module}/../scripts/requirements.txt")
    
    client_id     = var.sp_client_id
    tenant_id     = var.sp_tenant_id
    client_secret = var.sp_client_secret
    
  })
)

  network_interface_ids = [
    azurerm_network_interface.vm01_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

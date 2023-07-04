# Create the Private subnet
resource "azurerm_subnet" "private-subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = azurerm_resource_group.giit_rg.name
  virtual_network_name = azurerm_virtual_network.giit_virtual_network.name
  address_prefixes     = var.private_subnet_address_prefixes
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_virtual_network.giit_virtual_network
   ]
}

# Create the private Network Security Group (NSG)
resource "azurerm_network_security_group" "private-nsg" {
  name                = var.private_nsg_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  depends_on = [ 
    azurerm_resource_group.giit_rg
   ]
  tags = local.tags
}

resource "azurerm_network_interface" "frontend-vm-nic" {
  name                = var.frontend_nic_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_subnet.private-subnet
   ]
  tags = local.tags
}

# Create a Frontend Linux VM in the private subnet
resource "azurerm_linux_virtual_machine" "frontend-vm" {
  name                  = var.frontend_vm_name
  resource_group_name   = azurerm_resource_group.giit_rg.name
  location              = azurerm_resource_group.giit_rg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.frontend-vm-nic.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "frontendosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offered_by
    sku       = var.sku_type
    version   = var.version_of_image
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_network_interface.frontend-vm-nic
   ]
  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "frontend_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.frontend-vm-nic.id
  network_security_group_id = azurerm_network_security_group.private-nsg.id
  depends_on = [ 
    azurerm_network_interface.frontend-vm-nic,
    azurerm_network_security_group.private-nsg
   ]
}

resource "azurerm_network_interface" "backend-vm-nic" {
  name                = var.backend_nic_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_subnet.private-subnet
   ]
}

# Create a Backend Linux VM in the private subnet
resource "azurerm_linux_virtual_machine" "backend-vm" {
  name                  = var.backend_vm_name
  resource_group_name   = azurerm_resource_group.giit_rg.name
  location              = azurerm_resource_group.giit_rg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.backend-vm-nic.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "backendosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offered_by
    sku       = var.sku_type
    version   = var.version_of_image
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_network_interface.backend-vm-nic
   ]
  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "backend_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.backend-vm-nic.id
  network_security_group_id = azurerm_network_security_group.private-nsg.id
  depends_on = [ 
    azurerm_network_interface.backend-vm-nic,
    azurerm_network_security_group.private-nsg
   ]
}

resource "azurerm_network_interface" "db-vm-nic" {
  name                = var.db_nic_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_subnet.private-subnet
   ]
  tags = local.tags
}

# Create a db Linux VM in the private subnet
resource "azurerm_linux_virtual_machine" "db-vm" {
  name                  = var.db_vm_name
  resource_group_name   = azurerm_resource_group.giit_rg.name
  location              = azurerm_resource_group.giit_rg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.db-vm-nic.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "dbosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offered_by
    sku       = var.sku_type
    version   = var.version_of_image
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_network_interface.db-vm-nic
   ]
  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "db_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.db-vm-nic.id
  network_security_group_id = azurerm_network_security_group.private-nsg.id
  depends_on = [ 
    azurerm_network_interface.db-vm-nic,
    azurerm_network_security_group.private-nsg
   ]
}
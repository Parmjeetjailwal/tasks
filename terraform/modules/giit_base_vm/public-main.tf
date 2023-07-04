# Create the public subnet
resource "azurerm_subnet" "public-subnet" {
  name                 = var.public_subnet_name
  resource_group_name  = azurerm_resource_group.giit_rg.name
  virtual_network_name = azurerm_virtual_network.giit_virtual_network.name
  address_prefixes     = var.public_subnet_address_prefixes
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_virtual_network.giit_virtual_network
   ]
}

# Create the public Network Security Group (NSG)
resource "azurerm_network_security_group" "public-nsg" {
  name                = var.public_nsg_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  depends_on = [ 
    azurerm_resource_group.giit_rg
   ]
  tags = local.tags
}

# Create inbound security rules for the NSG
resource "azurerm_network_security_rule" "allow-http" {
  name                        = "Allow_HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.giit_rg.name
  network_security_group_name = azurerm_network_security_group.public-nsg.name
  depends_on = [ 
    azurerm_network_security_group.public-nsg,
    azurerm_resource_group.giit_rg
   ]
}

resource "azurerm_network_security_rule" "allow-https" {
  name                        = "Allow_HTTPS"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.giit_rg.name
  network_security_group_name = azurerm_network_security_group.public-nsg.name
  depends_on = [ 
    azurerm_network_security_group.public-nsg,
    azurerm_resource_group.giit_rg
   ]
}

resource "azurerm_network_security_rule" "allow-ssh" {
  name                        = "Allow_SSH"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.giit_rg.name
  network_security_group_name = azurerm_network_security_group.public-nsg.name
  depends_on = [ 
    azurerm_network_security_group.public-nsg,
    azurerm_resource_group.giit_rg
   ]
}

resource "azurerm_public_ip" "giit-public_ip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.giit_rg.name
  location            = azurerm_resource_group.giit_rg.location
  allocation_method   = var.publicip_allocation_method
  depends_on = [ 
    azurerm_resource_group.giit_rg
   ]
}

# Create a Linux VM in the public subnet
resource "azurerm_linux_virtual_machine" "public-vm" {
  name                  = var.public_vm_name
  resource_group_name   = azurerm_resource_group.giit_rg.name
  location              = azurerm_resource_group.giit_rg.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.public-nic.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    name                 = "publicosdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offered_by
    sku       = var.sku_type
    version   = var.version_of_image
  }
  custom_data = filebase64("${path.module}/app-scripts/app1-cloud-init.txt")

  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_network_interface.public-nic
   ]
  tags = local.tags
}

resource "azurerm_network_interface" "public-nic" {
  name                = var.public_nic_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.giit-public_ip.id
  }
  depends_on = [ 
    azurerm_resource_group.giit_rg,
    azurerm_subnet.public-subnet,
    azurerm_public_ip.giit-public_ip
   ]
  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "public_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.public-nic.id
  network_security_group_id = azurerm_network_security_group.public-nsg.id
  depends_on = [ 
    azurerm_network_interface.public-nic,
    azurerm_network_security_group.public-nsg
   ]
}
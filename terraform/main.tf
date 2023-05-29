module "terra_vm_server" {
  source = "./modules/giit_base_vm"

  # Resource Group arguments
  rg_name     = "giit-${terraform.workspace}-rg"
  rg_location = "Central India"

  # Network Security Group arguments
  nsg_name = "giit_base_nsg"

  # Virtual Network arguments
  vnet_name          = "giit_base_vnet"
  vnet_address_space = ["10.0.0.0/16", "10.1.0.0/16"]

  # Subnet arguments
  subnet_name             = "subnet-A"
  subnet_address_prefixes = ["10.0.0.0/24"]

  # publicip arguments
  public_ip_name             = "giit_public-ip"
  publicip_allocation_method = "Dynamic"

  # network Interface arguments
  nic_name = "giit_nic"

  # vm arguments
  vm_name        = "terraform-giit-vm"
  vm_size        = "Standard_DS1_V2"
  admin_username = "giituser"

  # vm image arguments
  publisher        = "Canonical"
  offered_by       = "UbuntuServer"
  sku_type         = "18.04-LTS"
  version_of_image = "latest"
}
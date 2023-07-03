module "terra_vm_server" {
  source = "./modules/giit_base_vm"

  # Resource Group arguments
  rg_name     = "${var.prefix}-${var.rg_name}-${var.env}"
  rg_location = var.rg_location

  # Network Security Group arguments
  nsg_name = "${var.prefix}-${var.nsg_name}-${var.env}"

  # Virtual Network arguments
  vnet_name          = "${var.prefix}-${var.vnet_name}-${var.env}"
  vnet_address_space = var.vnet_address_space

  # Subnet arguments
  subnet_name             = "${var.prefix}-${var.subnet_name}-${var.env}"
  subnet_address_prefixes = var.subnet_address_prefixes

  # publicip arguments
  public_ip_name             = "${var.prefix}-${var.env}-ip"
  publicip_allocation_method = "Dynamic"

  # network Interface arguments
  nic_name = "${var.prefix}_${var.env}_nic"

  # vm arguments
  vm_name        = "terraform-${var.prefix}-${var.env}-vm"
  vm_size        = var.vm_size
  admin_username = var.admin_username

  # vm image arguments
  publisher        = "Canonical"
  offered_by       = "UbuntuServer"
  sku_type         = "18.04-LTS"
  version_of_image = "latest"
}
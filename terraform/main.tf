module "terra_vm_server" {
  source = "./modules/giit_base_vm"

  # Resource Group arguments
  rg_name     = "${var.prefix}-${var.rg_name}-${var.env}"
  rg_location = var.rg_location

  # Network Security Group arguments
  public_nsg_name  = "${var.prefix}-${var.public_nsg_name}-${var.env}"
  private_nsg_name = "${var.prefix}-${var.private_nsg_name}-${var.env}"

  # Virtual Network arguments
  vnet_name          = "${var.prefix}-${var.vnet_name}-${var.env}"
  vnet_address_space = var.vnet_address_space

  # Public Subnet arguments
  public_subnet_name             = "${var.prefix}-${var.public_subnet_name}-${var.env}"
  public_subnet_address_prefixes = var.public_subnet_address_prefixes

  # Private Subnet arguments
  private_subnet_name             = "${var.prefix}-${var.private_subnet_name}-${var.env}"
  private_subnet_address_prefixes = var.private_subnet_address_prefixes

  # publicip arguments
  public_ip_name             = "${var.prefix}-${var.env}-ip"
  publicip_allocation_method = "Dynamic"

  # network Interface arguments
  public_nic_name   = "${var.prefix}_${var.env}_public_nic"
  frontend_nic_name = "${var.prefix}_${var.env}_frontend_nic"
  backend_nic_name  = "${var.prefix}_${var.env}_backend_nic"
  db_nic_name       = "${var.prefix}_${var.env}_db_nic"

  # vm arguments
  public_vm_name   = "${var.prefix}-public-${var.env}-vm"
  frontend_vm_name = "${var.prefix}-frontend-${var.env}-vm"
  backend_vm_name  = "${var.prefix}-backend-${var.env}-vm"
  db_vm_name       = "${var.prefix}-db-${var.env}-vm"
  vm_size          = var.vm_size
  admin_username   = var.admin_username

  # vm image arguments
  publisher        = "Canonical"
  offered_by       = "UbuntuServer"
  sku_type         = "18.04-LTS"
  version_of_image = "latest"
}
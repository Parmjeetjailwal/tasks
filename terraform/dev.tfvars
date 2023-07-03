# Prefix
prefix = "giit"

# Environments
env = "dev"
# Resource Group arguments
rg_name     = "rg"
rg_location = "East Asia"

# Network Security Group arguments
public_nsg_name = "public-nsg"

# Virtual Network arguments
vnet_name          = "vnet"
vnet_address_space = ["10.0.0.0/16", "192.168.0.0/16"]

# Subnet arguments
public_subnet_name              = "Public-subnet"
public_subnet_address_prefixes  = ["192.168.0.0/24"]
private_subnet_address_prefixes = ["10.0.0.0/24"]

# vm arguments
vm_size        = "Standard_DS1_V2"
admin_username = "devuser"

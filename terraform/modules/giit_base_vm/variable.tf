variable "rg_name" {
  description = "Name of the resource group"
  type = string
}

variable "rg_location" {
  description = "The Azure Region in which resource group should be created"
  type = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type = string
}

variable "vnet_address_space" {
  description = "Address space for Virtual Network"
  type = list(string)
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type = string
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type = string
}

variable "public_subnet_address_prefixes" {
  description = "Address prefix for public subnet"
  type = list(string)
}

variable "private_subnet_address_prefixes" {
  description = "Address prefix for private subnet"
  type = list(string)
}

variable "public_nsg_name" {
  description = "Name of public Network security group"
  type = string
}

variable "private_nsg_name" {
  description = "Name of private Network security group"
  type = string
}

variable "public_ip_name" {
  description = "Name of Public ip address"
  type = string
}

variable "publicip_allocation_method" {
  description = "publicip_allocation_method"
  type = string
}
variable "public_vm_name" {
  description = "Name of the virtual machine"
  type = string
}

variable "frontend_vm_name" {
  description = "Name of the frontend virtual machine"
  type = string
}

variable "backend_vm_name" {
  description = "Backend vm name"
  type = string
}

variable "db_vm_name" {
  description = "DB vm name"
  type = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type = string
}

variable "admin_username" {
  description = "admin_username"
  type = string
}

variable "publisher" {
  description = "Publisher of the vm image"
  type = string
}

variable "offered_by" {
  description = "vm image offered by"
  type = string
}

variable "sku_type" {
  description = "type of sku"
  type = string
}

variable "version_of_image" {
  description = "version_of_image"
  type = string
}

variable "public_nic_name" {
  description = "Name of the network interface card"
  type = string
}

variable "frontend_nic_name" {
  description = "Name of the frontend nic"
  type = string
}

variable "backend_nic_name" {
  description = "Name of the frontend nic"
  type = string
}

variable "db_nic_name" {
  description = "Name of the frontend nic"
  type = string
}




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

variable "subnet_name" {
  description = "Name of the subnet"
  type = string
}

variable "subnet_address_prefixes" {
  description = "Address prefix for subnet"
  type = list(string)
}

variable "nsg_name" {
  description = "Name of Network security group"
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
variable "vm_name" {
  description = "Name of the virtual machine"
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

# source image refrence

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

variable "nic_name" {
  description = "Name of the network interface card"
  type = string
}
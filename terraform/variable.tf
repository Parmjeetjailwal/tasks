variable "prefix" {
  type = string
}
variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "env" {
  type = string
}

variable "public_nsg_name" {
  type = string
}

variable "private_nsg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "public_subnet_name" {
  type = string
}

variable "public_subnet_address_prefixes" {
  type = list(string)
}

variable "private_subnet_name" {
  type = string
}

variable "private_subnet_address_prefixes" {
  type = list(string)
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}


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

variable "nsg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_address_prefixes" {
  type = list(string)
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}


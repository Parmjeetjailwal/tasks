# Terraform version with required provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "demo"
    storage_account_name = "giitsollutionbackend"
    container_name       = "tfstatefiles"
    key                  = "test/terraform.tfstate"
  }
}
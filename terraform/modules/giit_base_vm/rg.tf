# Create a resource group
resource "azurerm_resource_group" "giit_rg" {
  name     = var.rg_name
  location = var.rg_location
  tags = local.tags
}
# Create a virtual network
resource "azurerm_virtual_network" "giit_virtual_network" {
  name                = var.vnet_name
  location            = azurerm_resource_group.giit_rg.location
  resource_group_name = azurerm_resource_group.giit_rg.name
  address_space       = var.vnet_address_space
  depends_on = [ 
    azurerm_resource_group.giit_rg
   ]
}
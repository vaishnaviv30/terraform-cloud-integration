resource "azurerm_virtual_network" "vnet" {
  name     = "gopal-network"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  address_space       = ["10.0.0.0/16"]

}
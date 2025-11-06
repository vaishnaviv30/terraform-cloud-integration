resource "azurerm_subnet" "web_subnet" {
  name                 = "gopal-subnet"
  resource_group_name  = azurerm_resource_group.rg-kyn.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}
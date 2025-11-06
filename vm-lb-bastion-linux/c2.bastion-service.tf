#bastion service required its own subnet 
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"  #this name is mandatory for bastion service
  resource_group_name  = azurerm_resource_group.rg-kyn.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.101.0/27"]

}

resource "azurerm_public_ip" "bastion_vm_publicip" {
  name     = "bastion_public_ip"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tags
}

#bastion service 
resource "azurerm_bastion_host" "bastion" {
  name                = "gopal-bastion"
  location            = azurerm_resource_group.rg-kyn.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  
  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_vm_publicip.id
  }
  
}
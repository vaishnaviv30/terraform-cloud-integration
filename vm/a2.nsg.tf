#lets create the nsg 
resource "azurerm_network_security_group" "web_nsg" {
  name     = "gopal-nsg"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  tags                = local.project_tags
}
#once we create an nsg we will attach the same with our subnet
resource "azurerm_subnet_network_security_group_association" "web_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

#now we are going to add some rule inside our nsg. 
#but when we add some rule in nsg we need to attach multiple rules 
#22 80 443 3389
locals {
  web_nsg_rule_inbound = { #this is a name
    "110" : "3389",        #expressiong in key value format
    "120" : "80",          #key priority value if port number
    "130" : "443"
  }
}
resource "azurerm_network_security_rule" "web_nsg_rule" {
  for_each                    = local.web_nsg_rule_inbound
  name                        = "Rule_port_${each.value}" #Rule_port_22
  priority                    = each.key                  #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*" #30000-32767
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-kyn.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}
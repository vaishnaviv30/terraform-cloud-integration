resource "azurerm_network_interface" "web_nic" {
  for_each = var.vm                                          #so in the starting of the nic i have added for_each loop to create multiple nics based on the var.vm map variable
  name     = "${local.resource_name_prefix}-nic-${each.key}" #each.key will give the key of the map variable
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id #private ip 
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web_vm_publicip.id
  }
}
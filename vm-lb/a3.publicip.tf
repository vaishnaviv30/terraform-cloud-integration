/*resource "azurerm_public_ip" "web_vm_publicip" {
  name     = "acceptanceTestPublicIp1"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tags
}*/
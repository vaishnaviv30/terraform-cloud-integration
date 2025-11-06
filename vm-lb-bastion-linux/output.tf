output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg-kyn.name
}

output "resource_group_location" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg-kyn.location
}

output "vnet_name" {
  description = "name of the vnet"
  value       = azurerm_virtual_network.vnet.name
}

output "nsg_name" {
  description = "this is the name of the nsg"
  value       = azurerm_network_security_group.web_nsg.name
}
output "vm_privateip" {
  description = "vm private ip"
  #value = azurerm_network_interface.web_nic.private_ip_address
  value = values(azurerm_network_interface.web_nic)[*].private_ip_address
}
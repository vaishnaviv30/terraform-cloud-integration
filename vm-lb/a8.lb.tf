#lb balancer required an public ip 
resource "azurerm_public_ip" "lb_publicip" {
  name     = "${local.resource_name_prefix}-lb-publicip"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tags
}
#now we will create the lb
resource "azurerm_lb" "web_lb" {
  name     = "${local.resource_name_prefix}-lb"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
}

#now we will create the lb backend pool
resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "${local.resource_name_prefix}-lb-backend-pool"
}
#we will create the probe for my lb 
resource "azurerm_lb_probe" "web_lb_probe" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "${local.resource_name_prefix}-lb-backend-probe"
  protocol        = "Tcp"
  port            = 80
  # request_path = "/var/www/html/index.html"
  interval_in_seconds = 30
  number_of_probes    = 2 #it has probe two time 1 minutes
}

#we will create the lb rule 
resource "azurerm_lb_rule" "web_lb_rule" {
  loadbalancer_id            = azurerm_lb.web_lb.id
  name                       = "${local.resource_name_prefix}-lb-rule"
  protocol                   = "Tcp"
  frontend_port              = 80 #lb will listen on this port 443 
  backend_port               = 80 #it will of your instance port tomcat
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids    = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
  probe_id                   = azurerm_lb_probe.web_lb_probe.id
  
}
#lets attach the backend pool with nic 
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association" {
  for_each = var.vm
  network_interface_id = azurerm_network_interface.web_nic[each.key].id 
  ip_configuration_name = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id 
}

output "web_lb_publicIp" {
  description = "this is the public ip for the lb"
  value       = azurerm_public_ip.lb_publicip.ip_address
}
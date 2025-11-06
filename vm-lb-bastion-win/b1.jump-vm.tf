#custom subnet for jump vm
resource "azurerm_subnet" "jump_subnet" {
  name                 = "jump-subnet"
  resource_group_name  = azurerm_resource_group.rg-kyn.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
#jump vm public ip 
resource "azurerm_public_ip" "jump_vm_publicip" {
  name     = "jump-vm-publicip"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.project_tags
}

#jump nic card 
resource "azurerm_network_interface" "jump_nic" {
  #so in the starting of the nic i have added for_each loop to create multiple nics based on the var.vm map variable
  name     = "${local.resource_name_prefix}-jumpnic" #each.key will give the key of the map variable
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id #private ip 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jump_vm_publicip.id
  }
}

#we will create the jump vm now

/*resource "azurerm_linux_virtual_machine" "jump_vm" {

  name     = "${local.resource_name_prefix}-jumpvm" #add this line so that all the vm will have unique name 
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  size                = var.vm_instance_types["testing"] #refrence the instance size from instance-size.tf
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.jump_nic.id, #attach nic to vm
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = local.project_tags

}

output "jump_public_ip" {
  description = "this is jump vm public ip"
  value       = azurerm_public_ip.jump_vm_publicip.ip_address
}*/

resource "azurerm_linux_virtual_machine" "web_vm" {

  name     = "${local.resource_name_prefix}-vm" #add this line so that all the vm will have unique name 
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name
  size                = var.vm_instance_types["testing"] #refrence the instance size from instance-size.tf
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id, #attach nic to vm
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
  tags        = local.project_tags
  custom_data = filebase64("${path.module}/app/app.sh")
}
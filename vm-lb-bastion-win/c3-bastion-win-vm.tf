resource "azurerm_windows_virtual_machine" "winvm" {
  name                = "example-machine"
  location = azurerm_resource_group.rg-kyn.location
  #azurerm_resource_group.refrence_label.location
  resource_group_name = azurerm_resource_group.rg-kyn.name 
  size                = "Standard_D2s_v3" #let replace the same with Standard_D2s_v3
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.jump_nic.id, #add the nic card refrence 
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  #we will replace the same with windows 11

  source_image_reference {
    publisher = "microsoftwindowsdesktop" #go to your previous windows machine change the publisher as per the refrence 
    offer     = "windows-11" ##go to your previous windows machine change the publisher as per the refrence
    sku       = "win11-25h2-pro" ##go to your previous windows machine change the publisher as per the refrence
    version   = "latest"
  }
  tags = local.project_tags
  custom_data = filebase64("${path.module}/app/app.ps1")

}
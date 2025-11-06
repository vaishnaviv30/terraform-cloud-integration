resource "null_resource" "copy_ssh" {
  #it need to make a connection to the jump server 
  #if the vm is in provisioing state 
  depends_on = [ azurerm_linux_virtual_machine.jump_vm ]
  connection {
    type = "ssh" #rdp
    host =  azurerm_linux_virtual_machine.jump_vm.public_ip_address #this is having the public ip of jump server
    user = azurerm_linux_virtual_machine.jump_vm.admin_username  
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
    }
    #we need to upload a file 
    provisioner "file" {
      source      = "ssh-keys/terraform-azure.pem" #local path of the file which we want to upload
      destination = "/tmp/terraform-azure.pem"    #remote path where we want to upload the file 
    }
    provisioner "remote-exec" {
      inline = [ 
        "sudo chmod 400 /tmp/terraform-azure.pem"
       ]
    }
}
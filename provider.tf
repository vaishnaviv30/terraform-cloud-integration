#the provide we are going to create resource in azure so i need to find the azure provider. 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0" #if you do not provide the version 
    }
  }
  backend "azurerm" {
    resource_group_name   = "vaishnavi-storage-rg" #change it with your storage account rg name 
    storage_account_name  = "vaishstorageacc13" #change it with your storage account name
    container_name        = "tfstate" #change it with your container name 
    key                   = "project-1-eastus.tfstate" #this is the name of the state file 
  }
}

# Configure the Microsoft Azure Provider
# Configure the Microsoft Azure Provider
provider "azurerm" {
  # resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}



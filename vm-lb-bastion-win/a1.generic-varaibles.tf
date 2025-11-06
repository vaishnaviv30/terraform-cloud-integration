#to define an varaibles
#the name of the varaibles is an custom name
variable "resource_group_name" {
  description = "this is the name of the resource group"
  type        = string         #this is the varaibles type string, map, list, bool, number
  default     = "gopal-rg-kyn" #default value of the varaibles
}

variable "resource_group_location" {
  description = "resource group location"
  type        = string   #this is the varaibles type string, map, list, bool, number
  default     = "eastus" #def
}
#string will accept only single value
variable "environment" {
  type        = string
  description = "this is the environment"
  default     = "dev" #test
}

variable "business_unit" {
  type        = string
  description = "this is the business unit"
  default     = "sap"
}


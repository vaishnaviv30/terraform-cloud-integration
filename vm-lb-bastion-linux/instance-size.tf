variable "vm_instance_types" { #vm_instance_type is the name of the variable 
  description = "map of vm instance type for different environment"
  type        = map(string)       #type if map string
  default = {                     #in default we used to put the varaibles in value 
    development = "Standard_B1s", #the vvaribloe need to be define in key value format
    testing     = "Standard_F2",
    production  = "Standard_D2s_v3"
  }
}
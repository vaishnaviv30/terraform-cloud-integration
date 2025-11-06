variable "vm" {
  description = "the number of vm which will be created"
  type        = map(string)
  default = {
    vm1 = "vm-1"
    vm2 = "vm-2",
    
  }
}
#resource top level block
resource "azurerm_resource_group" "rg-kyn" {                            #this is also called as refrence lable
  name     = "${local.resource_name_prefix}-${var.resource_group_name}" #to call the local value we need to use local.nameoflocalvalue
  location = var.resource_group_location
  tags     = local.project_tags
}


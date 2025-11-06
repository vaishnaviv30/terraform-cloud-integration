#when you want to define local values
locals {
  owner                = var.business_unit
  environment          = var.environment
  resource_name_prefix = "${var.business_unit}-${var.environment}"
  #sap-dev
  #named expression 
  project_tags = { #project _tag is the name 
    Owner       = local.owner
    Environment = local.environment
    Project     = "kyn"
  }
  #in key value format 
}
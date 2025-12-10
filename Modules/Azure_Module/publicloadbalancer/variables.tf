variable "vcnname" {

}

variable "rgname" {

}

variable "location" {

}

locals {
  backend_address_pool_name      = "azureapplicationgw-beap"
  frontend_port_name             = "azureapplicationgw-feport"
  frontend_ip_configuration_name = "azureapplicationgw-feip"
  http_setting_name              = "azureapplicationgw-be-htst"
  listener_name                  = "azureapplicationgw-httplstn"
  request_routing_rule_name      = "azureapplicationgw-rqrt"
  redirect_configuration_name    = "azureapplicationgw-rdrcfg"
}



variable "azureservers" {

}

variable "ssl_password" {
  
}


locals {
  instances = [for instance in var.azureservers : instance.backenddetails.ip_address if length(regexall("worker", instance.backenddetails.server_name)) > 0 ? true : false]
}
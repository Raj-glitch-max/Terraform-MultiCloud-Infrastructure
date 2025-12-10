
variable "oracleservers" {

}

variable "azureservers" {

}

variable "oraclek8stemplatepath" {

}
variable "oraclek8sinventorypath" {

}

variable "azurek8stemplatepath" {

}
variable "azurek8sinventorypath" {

}
variable "dbtemplatepath" {

}
variable "dbinventorypath" {

}

variable "controllerinventorypath" {

}
variable "controllertemplatepath" {

}

locals {
  allservers = {
    ociservers      = [for server in var.oracleservers : server.server_details],
    ocibastionpubip =  [for server in var.oracleservers : server.server_details.public_ip if server.server_details.is_oracle_bastion == true] == [] ? ["127.0.0.1"] : [for server in var.oracleservers : server.server_details.public_ip if server.server_details.is_oracle_bastion == true],
    azservers       = [for server in var.azureservers : server.server_details]
    oracleips       = [for server in var.oracleservers : server.server_details.private_ip if server.server_details.is_oracle_bastion == false]
    azureips        = [for server in var.azureservers : server.server_details.private_ip]
  }
}
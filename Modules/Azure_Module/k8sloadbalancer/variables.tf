variable "rgname" {

}

variable "subnet_id" {

}

variable "location" {

}

variable "azureservers" {

}

variable "azurevnetid" {

}

locals {
  instances = [for instance in var.azureservers : instance.backenddetails if length(regexall("master", instance.backenddetails.server_name)) > 0 ? true : false]
}
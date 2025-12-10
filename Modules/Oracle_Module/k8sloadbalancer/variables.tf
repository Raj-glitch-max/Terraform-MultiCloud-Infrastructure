variable "compartment_ocid" {

}

variable "subnet_id" {

}

variable "oracleservers" {

}

locals {
  instances = [for instance in var.oracleservers : instance.backenddetails if length(regexall("master", instance.backenddetails.server_name)) > 0 ? true : false]
}
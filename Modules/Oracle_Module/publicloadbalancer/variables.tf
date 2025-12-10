variable "compartment_ocid" {

}

variable "subnet_id" {

}

variable "subnet2_id" {

}

variable "oracleservers" {

}

locals {
  instances = [for instance in var.oracleservers : instance.backenddetails if length(regexall("worker", instance.backenddetails.server_name)) > 0 ]
}
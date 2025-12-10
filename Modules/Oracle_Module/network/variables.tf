#Network variables
variable "vcn" {
  default = {
    name = "vcn"
    cidr = "10.0.0.0/16"
  }
}

variable "internet_gateway" {
  default = {
    name           = "igw"
    destination_ip = "0.0.0.0/0"
  }
}

variable "nat_gateway" {
  default = {
    name           = "ngw"
    destination_ip = "0.0.0.0/0"
  }
}

variable "privatesubnet" {
  default = {
    name = "privatesubnet",
    ip   = "10.0.1.0/24"
  }
}

variable "pubsubnet" {
  default = {
    name = "pubsubnet",
    ip   = "10.0.3.0/24"
  }
}

variable "pubsubnet2" {
  default = {
    name = "pubsubnet2",
    ip   = "10.0.5.0/24"
  }
}


variable "egress_rules" {
  default = {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}
variable "ingress_rules" {
  default = {
    protocol = "all"
    source   = "0.0.0.0/0"
  }
}

variable "compartment_id" {
}

variable "AD" {
}

variable "AD2" {
}

variable "azure_ipcidr" {
  default = "192.0.0.0/16"
}

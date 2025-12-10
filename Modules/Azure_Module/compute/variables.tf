variable "vm_size" {
  default = "Standard_B1s"
}

variable "username" {
  default = "ubuntu"
}

variable "hostname" {
  default = "server"
}

locals {
  source_image_reference = {
    offer     = "0001-com-ubuntu-server-${var.imagename}"
    publisher = "Canonical"
    version   = "latest"
  }
}
variable "os_disk" {
  default = {
    name    = "osdisk"
    caching = "ReadWrite"
  }
}

variable "diskstoragetype" {
  default = "Standard_LRS"
}

variable "diskstoragegbs" {
  default = "32"
}

variable "eviction_policy" {
  default = "Delete"
}
variable "priority" {
  default = "Spot"
}
variable "max_bid_price" {
  default = "0.011"
}

variable "location" {

}

variable "rgname" {

}

variable "subnet_id" {

}

variable "imagetype" {

}

variable "ssh_key" {

}

variable "imagename" {

}


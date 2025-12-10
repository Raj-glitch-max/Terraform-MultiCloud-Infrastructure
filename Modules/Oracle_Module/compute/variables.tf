
#Compute Variables

variable "vm_shape" {
  default = "VM.Standard.A1.Flex"
}

variable "assign_public_ip" {
  default = "false"
}
variable "boot_volume" {
}

variable "cpu" {
}

variable "memory" {
}

variable "server_name" {
}

variable "ssh_key" {
}

variable "AD" {
}

variable "compartment_id" {
}

variable "subnet_id" {
}

variable "image_id" {
}

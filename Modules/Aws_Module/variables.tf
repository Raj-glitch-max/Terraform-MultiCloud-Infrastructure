# variable "ports" {
#   default = [22, 443, 80]
# }

variable "cidr_block_ip" {
  default = "11.0.0.0/16"
}

variable "tag" {
  default = "aws_1"
}

variable "all_ips" {
  default = "0.0.0.0/0"
}

variable "subnet_ip" {
  default = "11.0.1.0/24"
}

variable "zone" {
  default = "us-east-1a"
}

variable "server_private_ip" {
  default = "11.0.1.50"
}

variable "ec2_ami" {
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "main.key"
}
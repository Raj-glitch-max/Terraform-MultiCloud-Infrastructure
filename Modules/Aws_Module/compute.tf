resource "aws_instance" "web-server-instance" {
  ami               = var.ec2_ami
  instance_type     = var.instance_type
  availability_zone = var.zone
  key_name          = var.key_name
  root_block_device {
    volume_size = "30"
    volume_type = "gp2"
    tags = {
      FileSystem = "/root"
    }
  }
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }
}

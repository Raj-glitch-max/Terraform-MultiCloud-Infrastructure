resource "aws_vpc" "vpc_a" {
  cidr_block = var.cidr_block_ip
  tags = {
    Name = var.tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_a.id
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc_a.id

  route {
    cidr_block = var.all_ips
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vpc_a.id
  cidr_block        = var.subnet_ip
  availability_zone = var.zone

  tags = {
    Name = var.tag
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.vpc_a.id


  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ips]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ips]
  }

  tags = {
    Name = "allow_web"
  }

  # dynamic "ingress" {
  #   for_each = toset(var.ports)
  #   content {
  #     protocol    = "tcp"
  #     from_port   = ingress.value
  #     to_port     = ingress.value
  #     cidr_blocks = [var.all_ips]
  #   }
  # }
}

resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = [var.server_private_ip]
  security_groups = [aws_security_group.allow_web.id]

}

resource "aws_eip" "one" {
  instance                  = aws_instance.web-server-instance.id
  vpc                       = true
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = var.server_private_ip
  depends_on                = [aws_internet_gateway.gw]
}


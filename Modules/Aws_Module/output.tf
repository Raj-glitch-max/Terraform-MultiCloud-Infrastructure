output "server_public_ip" {
  value = aws_eip.one.public_ip
}

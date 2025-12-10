output "public_ip" {
  value = azurerm_public_ip.publiclbip.ip_address
}
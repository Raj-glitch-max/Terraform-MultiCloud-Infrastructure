output "private_ip" {
  value = azurerm_lb.k8slb.private_ip_address
}
output "location" {
  value = azurerm_resource_group.azurerg.location
}

output "name" {
  value = azurerm_resource_group.azurerg.name
}

output "azureprivatesubnet_id" {
  value = azurerm_subnet.privatesubnet.id
}

output "vcnname" {
  value = azurerm_virtual_network.azurevcn.name
}

output "azurevnet_id" {
  value = azurerm_virtual_network.azurevcn.id
}
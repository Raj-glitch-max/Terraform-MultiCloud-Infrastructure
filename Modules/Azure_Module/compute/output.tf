output "server_details" {
  value = {
    name                 = join("", [azurerm_linux_virtual_machine.main.computer_name])
    all_details          = join("", [azurerm_linux_virtual_machine.main.computer_name, " ansible_host=", azurerm_linux_virtual_machine.main.private_ip_address, " ansible_user=ubuntu"])
    is_azure_master      = contains(regexall(".*master$", azurerm_linux_virtual_machine.main.computer_name), azurerm_linux_virtual_machine.main.computer_name)
    is_azure_worker      = contains(regexall(".*worker.*", azurerm_linux_virtual_machine.main.computer_name), azurerm_linux_virtual_machine.main.computer_name)
    is_azure_db          = contains(regexall(".*db.*", azurerm_linux_virtual_machine.main.computer_name), azurerm_linux_virtual_machine.main.computer_name)
    is_azure_extramaster = contains(regexall(".*master[1-9].*", azurerm_linux_virtual_machine.main.computer_name), azurerm_linux_virtual_machine.main.computer_name)
    private_ip           = azurerm_linux_virtual_machine.main.private_ip_address
  }
}

output "backenddetails" {
  value = {
    ip_address  = azurerm_linux_virtual_machine.main.private_ip_address
    server_name = azurerm_linux_virtual_machine.main.computer_name
  }
}

output "output_ips" {
  value = {
    server_ip   = azurerm_linux_virtual_machine.main.private_ip_address
    server_name = azurerm_linux_virtual_machine.main.computer_name
  }
}
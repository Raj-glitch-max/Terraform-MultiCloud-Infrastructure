resource "azurerm_network_interface" "azurenic" {
  name                = "${var.hostname}nic"
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "ipconfig${var.hostname}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
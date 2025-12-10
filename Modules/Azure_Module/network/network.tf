resource "azurerm_resource_group" "azurerg" {
  name     = "rg"
  location = var.region
}

# virtual network
resource "azurerm_virtual_network" "azurevcn" {
  name                = "vcn"
  address_space       = [var.cidr_ip_block]
  location            = azurerm_resource_group.azurerg.location
  resource_group_name = azurerm_resource_group.azurerg.name
}

# private subnet
resource "azurerm_subnet" "privatesubnet" {
  name                 = "privatesubnet"
  resource_group_name  = azurerm_resource_group.azurerg.name
  virtual_network_name = azurerm_virtual_network.azurevcn.name
  address_prefixes     = [var.privatesubnetip]
}

resource "azurerm_network_security_group" "privatesubnetazurensg" {
  name                = "privatesubnet-nsg"
  location            = azurerm_resource_group.azurerg.location
  resource_group_name = azurerm_resource_group.azurerg.name

  security_rule {
    name                       = "ingress_rules_all_allowed"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    priority                   = 100
    name                       = "egress_rules_all_allowed"
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsgsubnetassociation" {
  subnet_id                 = azurerm_subnet.privatesubnet.id
  network_security_group_id = azurerm_network_security_group.privatesubnetazurensg.id
}
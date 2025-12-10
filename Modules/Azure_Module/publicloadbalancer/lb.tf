resource "azurerm_subnet" "publiclbgwsubnet" {
  name                 = "azurepubliclbgw"
  resource_group_name  = var.rgname
  virtual_network_name = var.vcnname
  address_prefixes     = ["192.0.2.0/24"]
}

resource "azurerm_public_ip" "publiclbip" {
  name                = "azureappgw-pip"
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
  sku                = "Standard"
}


resource "azurerm_application_gateway" "publiclbgw" {
  name                = "publiclb-appgateway"
  resource_group_name = var.rgname
  location            = var.location

  sku {
    name           = "Standard_v2"
    tier           = "Standard_v2"
    capacity       = 1
  }

  ssl_certificate {
    name     = "certificate"
    data     = filebase64("~/ssl/cert.pfx")
    password = var.ssl_password
  }


  gateway_ip_configuration {
    name      = "azurepubliclb-gateway-ip-configuration"
    subnet_id = azurerm_subnet.publiclbgwsubnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.publiclbip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
    ip_addresses = local.instances
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 31736
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name = "certificate"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}
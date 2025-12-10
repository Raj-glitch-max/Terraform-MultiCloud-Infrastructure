resource "azurerm_lb" "k8slb" {
  name                = "k8slb"
  resource_group_name = var.rgname
  location            = var.location
  sku                 = "Standard"
  frontend_ip_configuration {
    name                          = "lbfrontendip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name            = "k8slbbackendpool"
  loadbalancer_id = azurerm_lb.k8slb.id
}

resource "azurerm_lb_probe" "lbhealthprobe" {
  name            = "k8slb-tcp-probe"
  protocol        = "Tcp"
  port            = 6443
  loadbalancer_id = azurerm_lb.k8slb.id
}

resource "azurerm_lb_rule" "lbrules" {
  name                           = "k8slbrule1"
  protocol                       = "Tcp"
  frontend_port                  = 6443
  backend_port                   = 6443
  frontend_ip_configuration_name = azurerm_lb.k8slb.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.lbhealthprobe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_address_pool.id]
  loadbalancer_id                = azurerm_lb.k8slb.id
}


resource "azurerm_lb_backend_address_pool_address" "backendip" {
  count                   = length(local.instances)
  name                    = "k8sbackend${local.instances[count.index].server_name}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
  virtual_network_id      = var.azurevnetid
  ip_address              = local.instances[count.index].ip_address
}
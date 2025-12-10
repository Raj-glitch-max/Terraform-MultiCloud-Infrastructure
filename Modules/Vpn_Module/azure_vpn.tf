resource "azurerm_subnet" "azurevpngatewaysubnet" {
  name                 = "gatewaysubnet"
  resource_group_name  = var.azurergname
  virtual_network_name = var.azurevcnname
  address_prefixes     = [var.azuregatewaysubnetcidr]
}


resource "azurerm_public_ip" "azurevpngwpubip" {
  name                = "azurevpngwpubip"
  location            = var.azurelocation
  resource_group_name = var.azurergname
  allocation_method   = "Static"
  sku = "Standard"
}

data "azurerm_public_ip" "gwip" {
  name                = "azurevpngwpubip"
  resource_group_name = var.azurergname
  depends_on          = [azurerm_public_ip.azurevpngwpubip, azurerm_virtual_network_gateway.azurevpn]
}

resource "azurerm_virtual_network_gateway" "azurevpn" {
  name                = "azurevpn"
  location            = var.azurelocation
  resource_group_name = var.azurergname

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "GatewayipConfig"
    public_ip_address_id          = azurerm_public_ip.azurevpngwpubip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.azurevpngatewaysubnet.id
  }

  bgp_settings {
    asn = 65515
    peering_addresses {
      apipa_addresses = ["169.254.21.5"]
    }
  }
}

resource "azurerm_virtual_network_gateway_connection" "tooracle" {
  for_each            = { for tunnel in local.tunnel_bgp_ips : tunnel.index => tunnel }
  name                = "oracle-connection${each.value.index + 1}"
  location            = var.azurelocation
  resource_group_name = var.azurergname

  type                           = "IPsec"
  connection_protocol            = "IKEv2"
  enable_bgp                     = true
  local_azure_ip_address_enabled = false
  virtual_network_gateway_id     = azurerm_virtual_network_gateway.azurevpn.id
  local_network_gateway_id       = azurerm_local_network_gateway.oraclecloud[each.value.index].id
  dpd_timeout_seconds            = 45

  shared_key = data.oci_core_ipsec_config.ip_sec_connection_device_config.tunnels[each.value.index].shared_secret

  ipsec_policy {

    dh_group         = "DHGroup2"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA384"
    ipsec_encryption = "GCMAES256"
    ipsec_integrity  = "GCMAES256"
    pfs_group        = "PFS2"
    sa_datasize      = 102400000
    sa_lifetime      = 27000
  }

}

resource "azurerm_local_network_gateway" "oraclecloud" {
  for_each            = { for tunnel in local.tunnel_bgp_ips : tunnel.index => tunnel }
  name                = "lgw-vpn-${each.value.index + 1}"
  resource_group_name = var.azurergname
  location            = var.azurelocation
  gateway_address     = data.oci_core_ipsec_config.ip_sec_connection_device_config.tunnels[each.value.index].ip_address
  address_space       = [var.oraclenetworkcidr]
  bgp_settings {
    asn                 = 31898
    bgp_peering_address = each.value.oip
  }
}
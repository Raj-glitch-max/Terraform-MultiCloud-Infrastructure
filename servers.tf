locals {
  oracleservers = [
    {
      display_name     = "oraclemaster"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oraclemaster2"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oraclemaster3"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oracleworker"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oracleworker2"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oracleworker3"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oracleworker4"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oracledb"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "oracledb2"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = false
      subnet_id        = module.oraclenetwork.ociprivatesubnet_id
    },
    {
      display_name     = "argocd"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = true
      subnet_id        = module.oraclenetwork.ocipublicsubnet_id
    },
    {
      display_name     = "jenkins"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = true
      subnet_id        = module.oraclenetwork.ocipublicsubnet_id
    },
    {
      display_name     = "oraclebastion"
      cpu              = 2
      memory           = 4
      image            = var.oci_ubuntu22_id
      boot_volume      = 50
      assign_public_ip = true
      subnet_id        = module.oraclenetwork.ocipublicsubnet_id
    }
  ]
}


variable "azureservers" {
  default = [
    {
      hostname  = "azuremaster"
      diskgb    = 32
      disktype  = "Standard_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azuremaster2"
      diskgb    = 32
      disktype  = "Standard_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azuremaster3"
      diskgb    = 32
      disktype  = "Standard_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azuredb"
      diskgb    = 64
      disktype  = "Premium_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azureworker"
      diskgb    = 64
      disktype  = "Premium_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azureworker2"
      diskgb    = 32
      disktype  = "Standard_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azureworker3"
      diskgb    = 32
      disktype  = "Standard_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
    {
      hostname  = "azureworker4"
      diskgb    = 32
      disktype  = "Standard_LRS"
      vm_size   = "Standard_D2ps_v5"
      imagetype = "22_04-lts-arm64"
      imagename = "jammy"
    },
  ]
}
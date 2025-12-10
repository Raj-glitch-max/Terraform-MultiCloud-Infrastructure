module "oci-azure-vpn" {
  providers = {
    azurerm = azurerm.azure_st
    oci     = oci.oci_us
  }
  source            = "./Modules/Vpn_Module"
  ocicompartment_id = var.oci_compartment_id
  drgid             = module.oraclenetwork.ocidrgid
  azurelocation     = module.azurenetwork.location
  azurergname       = module.azurenetwork.name
  azurevcnname      = module.azurenetwork.vcnname
  depends_on        = [module.oraclenetwork, module.azurenetwork]
}
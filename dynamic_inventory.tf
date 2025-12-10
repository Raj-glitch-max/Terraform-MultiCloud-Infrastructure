module "inventory" {
  source                  = "./Modules/Inventory_Module"
  oraclek8stemplatepath   = "../ansible-k8s-deployment/templates/oracleinventory.tpl"
  oraclek8sinventorypath  = "../ansible-k8s-deployment/inventory/oracleinventory"
  azurek8stemplatepath    = "../ansible-k8s-deployment/templates/azureinventory.tpl"
  azurek8sinventorypath   = "../ansible-k8s-deployment/inventory/azureinventory"
  dbtemplatepath          = "../ansible-galeracluster-deployment/templates/inventory.tpl"
  dbinventorypath         = "../ansible-galeracluster-deployment/inventory/inventory"
  controllerinventorypath = "../ansible-controller-setup/inventory"
  controllertemplatepath  = "../ansible-controller-setup/inventory.tpl"
  azureservers            = module.azureservers
  oracleservers           = module.oracleservers
  depends_on              = [module.oracleservers, module.azureservers]
}


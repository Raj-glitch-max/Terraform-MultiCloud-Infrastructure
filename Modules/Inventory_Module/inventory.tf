#oracle inventory
resource "local_file" "oraclek8sinventory_file" {
  content  = templatefile(var.oraclek8stemplatepath, local.allservers)
  filename = var.oraclek8sinventorypath
}

#db inventory
resource "local_file" "dbinventory_file" {
  content  = templatefile(var.dbtemplatepath, local.allservers)
  filename = var.dbinventorypath
}

# azure inventory
resource "local_file" "azurek8sinventory_file" {
  content  = templatefile(var.azurek8stemplatepath, local.allservers)
  filename = var.azurek8sinventorypath
}


# controller inventory
resource "local_file" "controllerinventory_file" {
  content  = templatefile(var.controllertemplatepath, local.allservers)
  filename = var.controllerinventorypath
}
terraform {
  required_version = ">= 0.15"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "5.19.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}
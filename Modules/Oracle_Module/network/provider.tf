terraform {
  required_version = ">= 0.15"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "5.19.0"
    }
  }
}
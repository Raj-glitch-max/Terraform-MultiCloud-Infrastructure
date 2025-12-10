terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "5.19.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  # backend "s3" {
  #   bucket         = "hybridinfrastatebucket"
  #   dynamodb_table = "hybridinfrastatelockdb"
  #   key            = "remote_backend/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  # }
}


provider "aws" {
  region = "us-east-1"
  alias  = "us"
}


provider "oci" {
  region = "us-phoenix-1"
  alias  = "oci_us"
}

provider "azurerm" { // using paid version of azurerm provider currently change to student subscription
  features {}
  subscription_id = var.az_subscription_id
  client_id       = var.az_client_id
  client_secret   = var.az_client_secret
  tenant_id       = var.az_tenant_id
  alias           = "azure_st"
}
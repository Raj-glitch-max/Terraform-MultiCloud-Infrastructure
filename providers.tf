terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# AWS Provider - Primary Cloud (us-east-1)
provider "aws" {
  region = "us-east-1"
  alias  = "primary"

  default_tags {
    tags = {
      Project     = "MultiCloud-Infrastructure"
      ManagedBy   = "Terraform"
      Environment = "production"
    }
  }
}

# AWS Provider - Secondary Region (us-west-2) for DR
provider "aws" {
  region = "us-west-2"
  alias  = "secondary"

  default_tags {
    tags = {
      Project     = "MultiCloud-Infrastructure"
      ManagedBy   = "Terraform"
      Environment = "production"
    }
  }
}

# Azure Provider - Secondary Cloud
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  
  subscription_id = var.az_subscription_id
  client_id       = var.az_client_id
  client_secret   = var.az_client_secret
  tenant_id       = var.az_tenant_id
  alias           = "azure_primary"
}

# GCP Provider - Tertiary Cloud
provider "google" {
  project = var.gcp_project_id
  region  = "us-central1"
  alias   = "gcp_primary"
}
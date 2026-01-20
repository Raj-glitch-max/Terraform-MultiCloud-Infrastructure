# SSH Key for accessing compute instances across all clouds
variable "ssh_key" {
  description = "Public SSH key for instance access"
  type        = string
}

# Azure Provider Variables
variable "az_subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "az_client_id" {
  description = "Azure service principal client ID"
  type        = string
  sensitive   = true
}

variable "az_client_secret" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
}

variable "az_tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
}

# GCP Provider Variables
variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_credentials_file" {
  description = "Path to GCP service account credentials JSON file"
  type        = string
  default     = "~/.config/gcloud/application_default_credentials.json"
}

# SSL Certificate Password (for load balancers)
variable "ssl_password" {
  description = "Password for SSL certificate PFX file"
  type        = string
  sensitive   = true
}

# Common Tags
variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "MultiCloud-Infrastructure"
}

variable "environment" {
  description = "Environment name (dev/staging/production)"
  type        = string
  default     = "production"
}
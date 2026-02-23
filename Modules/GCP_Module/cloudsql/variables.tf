variable "project_id" { type = string }
variable "region" { type = string }
variable "instance_name" { type = string }
variable "network_id" { type = string }
variable "database_version" { type = string; default = "POSTGRES_15" }
variable "tier" { type = string; default = "db-f1-micro" }

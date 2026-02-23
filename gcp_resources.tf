module "gcp_vpc" {
  source = "./Modules/GCP_Module/vpc"

  project_id   = var.gcp_project_id
  region       = "us-central1"
  project_name = var.project_name
}

module "gcp_gke" {
  source = "./Modules/GCP_Module/gke"

  project_id   = var.gcp_project_id
  region       = "us-central1"
  cluster_name = "${var.project_name}-gke"
  network_name = module.gcp_vpc.network_name
  subnet_name  = module.gcp_vpc.public_subnet_name

  node_count     = 3
  min_node_count = 2
  max_node_count = 5
  machine_type   = "e2-medium"

  depends_on = [module.gcp_vpc]
}

module "gcp_sql" {
  source = "./Modules/GCP_Module/cloudsql"

  project_id   = var.gcp_project_id
  region       = "us-central1"
  instance_name = "${var.project_name}-sql"
  network_id    = module.gcp_vpc.network_id

  database_version = "POSTGRES_15"
  tier             = "db-f1-micro"

  depends_on = [module.gcp_vpc]
}

output "gke_cluster_endpoint" {
  value = module.gcp_gke.endpoint
}

output "gcp_sql_ip" {
  value = module.gcp_sql.public_ip_address
}

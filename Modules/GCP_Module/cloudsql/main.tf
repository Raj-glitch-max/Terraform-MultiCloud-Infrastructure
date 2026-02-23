resource "google_sql_database_instance" "main" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  project          = var.project_id

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network_id
    }
  }
}

resource "google_sql_database" "database" {
  name     = "${var.instance_name}-db"
  instance = google_sql_database_instance.main.name
  project  = var.project_id
}

output "public_ip_address" {
  value = google_sql_database_instance.main.public_ip_address
}

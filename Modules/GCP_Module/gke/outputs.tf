output "cluster_id" {
  value = google_container_cluster.main.id
}

output "cluster_endpoint" {
  value = google_container_cluster.main.endpoint
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.main.master_auth[0].cluster_ca_certificate
  sensitive = true
}

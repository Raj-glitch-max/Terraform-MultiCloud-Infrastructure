output "private_ip" {
  value = oci_network_load_balancer_network_load_balancer.k8s_load_balancer.ip_addresses[0].ip_address
}


output "public_ip" {
  value = oci_load_balancer_load_balancer.public_load_balancer.ip_address_details[0].ip_address
}


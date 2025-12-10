output "ociprivatesubnet_id" {
  value = oci_core_subnet.privatesubnet.id
}

output "ocipublicsubnet_id" {
  value = oci_core_subnet.pubsubnet.id
}

output "ocipublicsubnet2_id" {
  value = oci_core_subnet.pubsubnet2.id
}

output "ocidrgid" {
  value = oci_core_drg.drg.id
}
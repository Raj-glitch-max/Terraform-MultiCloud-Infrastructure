resource "oci_load_balancer_load_balancer" "public_load_balancer" {
  #Required
  compartment_id = var.compartment_ocid
  display_name   = "publicloadbalancer"
  shape          = "flexible"
  subnet_ids     = [var.subnet_id,var.subnet2_id]
  #Optional
  is_private = false
  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "public_backend_set" {
  #Required
  health_checker {
    #Required
    protocol = "HTTP"
    #Optional
    port = 31736
    url_path = "/"
  }
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer.id
  name             = "public_workernodebackend_set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_certificate" "certificate" {
	#Required
	certificate_name = "sslcertificate"
	load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer.id

	#Optional
	private_key = file("~/ssl/private.txt")
	public_certificate = file("~/ssl/certificate.txt")

	lifecycle {
	    create_before_destroy = true
	}
}

resource "oci_load_balancer_listener" "public_listener" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.public_backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.public_load_balancer.id
  name                     = "public_loadbalancer_listener"
  port                     = 443
  protocol                 = "HTTP"
  ssl_configuration {
		certificate_name = oci_load_balancer_certificate.certificate.certificate_name
    verify_peer_certificate = false
  }
}

resource "oci_load_balancer_backend" "public_backends" {
  count = length(local.instances)
  #Required
  backendset_name  = oci_load_balancer_backend_set.public_backend_set.name
  ip_address       = local.instances[count.index].server_ip
  load_balancer_id = oci_load_balancer_load_balancer.public_load_balancer.id
  port             = 31736
}

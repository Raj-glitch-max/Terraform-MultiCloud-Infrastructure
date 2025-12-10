#vcn

resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_id
  cidr_block     = var.vcn.cidr
  display_name   = var.vcn.name
  dns_label      = var.vcn.name
}

#public subnet
resource "oci_core_subnet" "pubsubnet" {
  availability_domain = var.AD
  compartment_id      = var.compartment_id
  display_name        = var.pubsubnet.name
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = var.pubsubnet.ip
  route_table_id      = oci_core_route_table.publicrt.id
  security_list_ids   = [oci_core_security_list.publicsecuritylist.id]
  dns_label           = var.pubsubnet.name
}

resource "oci_core_subnet" "pubsubnet2" {
  availability_domain = var.AD2
  compartment_id      = var.compartment_id
  display_name        = var.pubsubnet2.name
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = var.pubsubnet2.ip
  route_table_id      = oci_core_route_table.publicrt.id
  security_list_ids   = [oci_core_security_list.publicsecuritylist.id]
  dns_label           = var.pubsubnet2.name
}

resource "oci_core_route_table" "publicrt" {
  compartment_id = var.compartment_id
  display_name   = "publicrt"
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    destination       = var.internet_gateway.destination_ip
    network_entity_id = oci_core_internet_gateway.igw.id
  }
  route_rules {
    destination       = var.azure_ipcidr
    network_entity_id = oci_core_drg.drg.id
  }
}

resource "oci_core_security_list" "publicsecuritylist" {

  display_name   = "publicsecuritylist"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id

  egress_security_rules {
    protocol    = var.egress_rules.protocol
    destination = var.egress_rules.destination
  }

  ingress_security_rules {
    protocol = var.ingress_rules.protocol
    source   = var.ingress_rules.source

  }
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  display_name   = var.internet_gateway.name
  vcn_id         = oci_core_vcn.vcn.id
}

resource "oci_core_drg" "drg" {
  compartment_id = var.compartment_id
}

resource "oci_core_drg_attachment" "vcndrgattachment" {
  drg_id = oci_core_drg.drg.id
  network_details {
    id   = oci_core_vcn.vcn.id
    type = "VCN"
  }
}

#private subnet

resource "oci_core_subnet" "privatesubnet" {
  availability_domain = var.AD
  compartment_id      = var.compartment_id
  display_name        = var.privatesubnet.name
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = var.privatesubnet.ip
  route_table_id      = oci_core_route_table.privatert.id
  security_list_ids   = [oci_core_security_list.privatesecuritylist.id]
  dns_label           = var.privatesubnet.name
}

resource "oci_core_security_list" "privatesecuritylist" {

  display_name   = "privatesecuritylist"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id

  egress_security_rules {
    protocol    = var.egress_rules.protocol
    destination = var.egress_rules.destination
  }

  ingress_security_rules {
    protocol = var.ingress_rules.protocol
    source   = var.ingress_rules.source

  }
}

resource "oci_core_route_table" "privatert" {
  compartment_id = var.compartment_id
  display_name   = "privatert"
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    destination       = var.nat_gateway.destination_ip
    network_entity_id = oci_core_nat_gateway.natgw.id
  }
  route_rules {
    destination       = var.azure_ipcidr
    network_entity_id = oci_core_drg.drg.id
  }
}

resource "oci_core_nat_gateway" "natgw" {

  compartment_id = var.compartment_id

  display_name = var.nat_gateway.name

  vcn_id = oci_core_vcn.vcn.id
}


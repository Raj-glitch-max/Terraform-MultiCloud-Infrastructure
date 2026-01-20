# GCP VPC Module - Simplified

resource "google_compute_network" "main" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "public" {
  name          = "${var.project_name}-public-subnet"
  ip_cidr_range = "10.2.0.0/20"
  region        = var.region
  network       = google_compute_network.main.id
  project       = var.project_id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.2.16.0/20"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.2.32.0/20"
  }
}

resource "google_compute_subnetwork" "private" {
  name          = "${var.project_name}-private-subnet"
  ip_cidr_range = "10.2.64.0/20"
  region        = var.region
  network       = google_compute_network.main.id
  project       = var.project_id
}

resource "google_compute_router" "router" {
  name    = "${var.project_name}-router"
  region  = var.region
  network = google_compute_network.main.id
  project = var.project_id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.project_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = var.project_id
}

resource "google_compute_firewall" "allow_internal" {
  name    = "${var.project_name}-allow-internal"
  network = google_compute_network.main.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.2.0.0/16"]
}

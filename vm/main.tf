provider "google" {
    credentials = "C:\\Users\\solar-haven-441912-j9-cb11460c2587.json"
  project = "solar-haven-441912-j9"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_network" "default" {
  name = "default-network"
}

resource "google_compute_subnetwork" "default" {
  name          = "default-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.default.id
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-vm-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.default.id
    subnetwork = google_compute_subnetwork.default.id

    access_config {
      # Allows external internet access
    }
  }
}

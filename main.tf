provider "google" {
 project      = var.gcp_project_id
 zone         = var.zone
}

resource "google_compute_instance" "apache_test" {
    project      = var.gcp_project_id
    name         = var.instance_name
    machine_type = var.machine_type
    zone         = var.zone
    tags = ["http-server"]

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }

    metadata_startup_script =  file("./apache.sh")

    scheduling {
        preemptible = true
        automatic_restart = false
    }

    network_interface {
        network ="default"
        access_config {

        }
    }
}
resource "google_storage_bucket" "example_bucket" {
  project  = var.gcp_project_id
  name     = var.bucket_name
  location = var.bucket_location
}

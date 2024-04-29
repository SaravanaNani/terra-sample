provider "google" {
  credentials = "ya29.a0Ad52N38cEFPNzankD2cArtk7XzS6tX1YoV61tRuZwR3NJtvYmdZZ4GN7t9dKUI5zyDgaAQ9RR9x4zKZP5jd4tyOLLBTvnbAmkRuU4Q_arL9UzyKc58d__TLOBSaheGHr3yy-BvquaFhK1mqBlrR02nJWMgnrgNWoDk0htb-ZPQaCgYKAdcSARISFQHGX2Mi6KuzjHHKlB0Q05nO8REXTw0177"
  project = "xenon-timer-414316"
  

}
 
resource "google_service_account" "default" {

  account_id   = "my-custom-sa"

  display_name = "Custom SA for VM Instance"

}
 
resource "google_compute_instance" "default" {

  name         = "my-instance"

  machine_type = "n2-standard-2"

  zone         = "us-central1-a"
 
  tags = ["foo", "bar"]
 
  boot_disk {

    initialize_params {

      image = "debian-cloud/debian-11"

      labels = {

        my_label = "value"

      }

    }

  }
 
  // Local SSD disk

  scratch_disk {

    interface = "NVME"

  }
 
  network_interface {

    network = "default"
 
    access_config {

      // Ephemeral public IP

    }

  }
 
  service_account {

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.

    email  = google_service_account.default.email

    scopes = ["cloud-platform"]

  }

}

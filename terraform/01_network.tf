terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "blood_network" {
  name   = "blood_donation_network"
  driver = "bridge"

  ipam_config {
    subnet  = "172.20.0.0/16"
    gateway = "172.20.0.1"
  }

  labels {
    label = "project"
    value = "blood-donation"
  }
}

output "network_name" {
  value       = docker_network.blood_network.name
  description = "Жасалған желінің атауы"
}

resource "docker_volume" "postgres_data" {
  name = "blood_postgres_data"

  labels {
    label = "project"
    value = "blood-donation"
  }

  labels {
    label = "module"
    value = "database"
  }
}

resource "docker_volume" "jenkins_data" {
  name = "blood_jenkins_data"

  labels {
    label = "project"
    value = "blood-donation"
  }
}

output "postgres_volume" {
  value       = docker_volume.postgres_data.name
  description = "PostgreSQL volume атауы"
}

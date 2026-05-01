resource "docker_image" "postgres" {
  name         = "postgres:15"
  keep_locally = true
}

resource "docker_container" "postgres" {
  name  = "tf_blood_db"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_USER=admin",
    "POSTGRES_PASSWORD=secret123",
    "POSTGRES_DB=blooddb"
  ]

  ports {
    internal = 5432
    external = 5433
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  restart = "unless-stopped"

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U admin"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}

output "db_container_name" {
  value       = docker_container.postgres.name
  description = "PostgreSQL контейнер атауы"
}

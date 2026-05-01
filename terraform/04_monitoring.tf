resource "docker_image" "prometheus" {
  name         = "prom/prometheus:latest"
  keep_locally = true
}

resource "docker_image" "grafana" {
  name         = "grafana/grafana:latest"
  keep_locally = true
}

resource "docker_container" "prometheus" {
  name  = "tf_blood_prometheus"
  image = docker_image.prometheus.image_id

  ports {
    internal = 9090
    external = 9091
  }

  restart = "unless-stopped"
}

resource "docker_container" "grafana" {
  name  = "tf_blood_grafana"
  image = docker_image.grafana.image_id

  ports {
    internal = 3000
    external = 3001
  }

  env = [
    "GF_SECURITY_ADMIN_USER=admin",
    "GF_SECURITY_ADMIN_PASSWORD=admin123"
  ]

  restart = "unless-stopped"
}

output "grafana_url" {
  value       = "http://localhost:3001"
  description = "Grafana URL мекенжайы"
}

output "prometheus_url" {
  value       = "http://localhost:9091"
  description = "Prometheus URL мекенжайы"
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = "tf_blood_nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8081
  }

  restart = "unless-stopped"
}

output "nginx_url" {
  value       = "http://localhost:8081"
  description = "Nginx Reverse Proxy URL"
}

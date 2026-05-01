variable "project_name" {
  description = "Жоба атауы"
  type        = string
  default     = "blood-donation"
}

variable "environment" {
  description = "Орта түрі"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Орта тек dev, staging, prod болуы керек."
  }
}

variable "db_password" {
  description = "Деректер қоры құпия сөзі"
  type        = string
  default     = "secret123"
  sensitive   = true
}

variable "app_port" {
  description = "Қосымша порты"
  type        = number
  default     = 5000

  validation {
    condition     = var.app_port > 1024 && var.app_port < 65535
    error_message = "Порт 1024-65535 аралығында болуы керек."
  }
}

locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
  }
}

output "project_summary" {
  description = "Жоба қорытындысы"
  value = <<-EOT
    =====================================
    Жоба: ${var.project_name}
    Орта: ${var.environment}
    Басқару: Terraform (Docker Provider)
    =====================================
  EOT
}

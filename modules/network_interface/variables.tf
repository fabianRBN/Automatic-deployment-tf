variable "subnet_ids" {
  description = "Subnet IDs para las interfaces de red"
  type        = list(string)
}

variable "web_sg_id" {
  description = "Security Group ID para el servidor web"
}

variable "db_sg_id" {
  description = "Security Group ID para el servidor de base de datos"
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}

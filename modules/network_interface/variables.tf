variable "subnet_ids" {
  description = "Lista de IDs de subredes para las interfaces de red"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del Security Group asociado con las interfaces de red"
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}

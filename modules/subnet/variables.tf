variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "Lista de bloques CIDR para las subredes"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para las subredes"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Si asignar IP p�blica en el lanzamiento de instancias EC2"
  default     = false
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}

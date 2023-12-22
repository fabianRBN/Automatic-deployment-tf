variable "vpc_id" {
  description = "ID de la VPC para la subred"
}

variable "subnet_cidr_blocks" {
  description = "Lista de bloques CIDR para las subredes publicas"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidad para las subredes publicas"
  type        = list(string)
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}

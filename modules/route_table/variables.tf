variable "vpc_id" {
  description = "ID de la VPC para la tabla de ruteo"
}

variable "gateway_id" {
  description = "ID de la Internet Gateway"
}

variable "destination_cidr_block" {
  description = "Bloque CIDR para la ruta"
  default     = "0.0.0.0/0"
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}

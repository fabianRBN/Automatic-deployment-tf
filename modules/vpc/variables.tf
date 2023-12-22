variable "cidr_block" {
  description = "CIDR block para la VPC"
  type        = string
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}
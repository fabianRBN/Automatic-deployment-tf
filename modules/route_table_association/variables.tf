variable "subnet_ids" {
  description = "IDs de las subredes para asociar"
  type        = list(string)
}

variable "route_table_id" {
  description = "ID de la tabla de rutas"
}
variable "environment" {
  description = "El entorno (dev, test, prod)"
}
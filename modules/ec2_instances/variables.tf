variable "subnet_ids" {
  description = "IDs de las subredes donde se desplegaron las instancias"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID para usar en las instancias EC2"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}

variable "security_group_id" {
  description = "ID del Security Group asociado con la instancia EC2"
}

variable "network_interface_ids" {
  description = "Lista de IDs de interfaces de red para asociar con las instancias EC2"
  type        = list(string)
}
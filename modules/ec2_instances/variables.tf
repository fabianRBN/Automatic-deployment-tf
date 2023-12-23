variable "subnet_ids" {
  description = "IDs de las subredes donde se desplegaron las instancias"
  type        = list(string)
}


variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t2.micro"
}

variable "environment" {
  description = "El entorno (dev, test, prod)"
}



variable "ami_web" {
  description = "AMI ID for the web server"
}


variable "ami_db" {
  description = "AMI ID for the MongoDB server"
}


variable "web_network_interface_ids" {
  description = "Network Interface IDs para los servidores web"
  type        = list(string)
}

variable "db_network_interface_ids" {
  description = "Network Interface IDs para los servidores de base de datos"
  type        = list(string)
}


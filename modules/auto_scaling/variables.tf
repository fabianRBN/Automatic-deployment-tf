variable "environment" {
  description = "Deployment environment"
}

variable "ami_id" {
  description = "AMI ID for the instances"
}

variable "instance_type" {
  description = "Instance type for the instances"
}

variable "associate_public_ip" {
  description = "Associate a public IP address with an instance in a VPC"
  type        = bool
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group"
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
}

variable "user_data" {
  description = "The user data to provide when launching the instances"
  default     = ""
}

# Puedes agregar más variables según sea necesario...

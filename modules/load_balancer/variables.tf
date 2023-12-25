variable "environment" {
  description = "Deployment environment"
}

variable "alb_security_group_id" {
  description = "Security group ID for the ALB"
}

variable "subnet_ids" {
  description = "Subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
}

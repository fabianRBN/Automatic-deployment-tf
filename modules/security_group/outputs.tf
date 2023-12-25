output "web_sg_id" {
  value = aws_security_group.web.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}
output "alb_sg_id" {
  description = "ID of the Security Group for the ALB"
  value       = aws_security_group.alb_sg.id
}
output "web_tg_arn" {
  description = "ARN of the Web Target Group"
  value       = aws_lb_target_group.web_tg.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.web_alb.dns_name
}
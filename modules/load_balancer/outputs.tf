output "web_tg_arn" {
  description = "ARN of the Web Target Group"
  value       = aws_lb_target_group.web_tg.arn
}
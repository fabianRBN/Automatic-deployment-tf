output "testing_alb_url" {
  description = "URL of the testing ALB"
  value       = module.load_balancer.alb_dns_name
}
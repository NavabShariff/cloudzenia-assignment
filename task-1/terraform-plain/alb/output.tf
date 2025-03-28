output "alb_dns" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.application_load_balancer.dns_name
}

output "wordpress_target_group_arn" {
  description = "ARN of the WordPress Target Group"
  value       = aws_lb_target_group.wordpress_tg.arn
}

output "microservice_target_group_arn" {
  description = "ARN of the Microservice Target Group"
  value       = aws_lb_target_group.microservice_tg.arn
}
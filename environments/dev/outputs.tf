# environments/dev/outputs.tf
# Environment outputs

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "alb_url" {
  description = "URL of the load balancer"
  value       = "http://${aws_lb.main.dns_name}/"
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "db_secret_arn" {
  description = "ARN of the database password secret"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "monitoring_dashboard_url" {
  description = "CloudWatch Dashboard URL"
  value       = module.monitoring.dashboard_url
}

output "security_alerts_topic" {
  description = "SNS topic for security alerts"
  value       = module.security_baseline.security_alerts_topic_arn
}

output "estimated_monthly_cost" {
  description = "Estimated monthly cost for this environment"
  value       = "$35-40 (with NAT instance optimization)"
}

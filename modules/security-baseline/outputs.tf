# modules/security-baseline/outputs.tf
output "security_alerts_topic_arn" {
  description = "ARN of the SNS topic for security alerts"
  value       = aws_sns_topic.security_alerts.arn
}

output "kms_key_arns" {
  description = "KMS key ARNs"
  value = {
    rds = aws_kms_key.main.arn
  }
}

output "app_instance_profile_name" {
  description = "Name of the app instance profile"
  value       = aws_iam_instance_profile.app.name
}

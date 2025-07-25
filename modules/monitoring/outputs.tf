# modules/monitoring/outputs.tf
output "dashboard_url" {
  description = "URL of the CloudWatch dashboard"
  value       = "https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards:name=${aws_cloudwatch_dashboard.main.dashboard_name}"
}

output "alarm_topic_arn" {
  description = "ARN of the SNS topic for alarms"
  value       = aws_sns_topic.alarms.arn
}

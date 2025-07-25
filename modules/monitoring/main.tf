# modules/monitoring/main.tf
# Placeholder monitoring module

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.project_name}-${var.environment}"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        width  = 12
        height = 1
        properties = {
          markdown = "# ${var.project_name} - ${var.environment} Dashboard"
        }
      }
    ]
  })
}

# SNS Topic for alarms
resource "aws_sns_topic" "alarms" {
  name = "${var.project_name}-${var.environment}-alarms"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-alarms"
    }
  )
}

resource "aws_sns_topic_subscription" "alarm_email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

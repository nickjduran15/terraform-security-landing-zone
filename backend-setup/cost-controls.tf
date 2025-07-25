# backend-setup/cost-controls.tf
# Early warning system for AWS spending

# SNS topic for budget alerts
resource "aws_sns_topic" "budget_alerts" {
  name = "terraform-budget-alerts"

  tags = {
    Name = "Terraform Budget Alerts"
  }
}

# Email subscription for alerts
resource "aws_sns_topic_subscription" "budget_email" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = "hariegglocke@gmail.com" # CHANGE THIS TO YOUR EMAIL!
}

# Monthly budget with alerts
resource "aws_budgets_budget" "monthly_budget" {
  name         = "terraform-monthly-budget"
  budget_type  = "COST"
  limit_amount = "10" # $10 monthly limit for safety
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["hariegglocke@gmail.com"] # CHANGE THIS TOO!
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["hariegglocke@gmail.com"] # AND THIS ONE!
  }
}

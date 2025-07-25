# backend-setup/outputs.tf
# These outputs will be needed for backend configuration

output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "backend_config" {
  description = "Backend configuration to use in other Terraform projects"
  value       = <<-EOT
  backend "s3" {
    bucket         = "${aws_s3_bucket.terraform_state.id}"
    key            = "path/to/your/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "${aws_dynamodb_table.terraform_locks.name}"
    encrypt        = true
    profile        = "terraform-dev"
  }
  EOT
}

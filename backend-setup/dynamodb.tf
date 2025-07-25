# backend-setup/dynamodb.tf
# DynamoDB table for state locking - prevents concurrent modifications

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST" # Cost-effective for our use case
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true # Enable backups
  }

  server_side_encryption {
    enabled = true # Encryption at rest
  }

  tags = {
    Name     = "Terraform State Lock Table"
    Critical = "true"
  }

  #  lifecycle {
  #    prevent_destroy = true # Prevent accidental deletion
  #  }
}

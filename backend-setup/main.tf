# backend-setup/main.tf
# This configuration creates the S3 bucket and DynamoDB table for Terraform state
# Run this ONCE before setting up remote backend

terraform {
  required_version = "~> 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Pinned to v5 to avoid v6 breaking changes
    }
  }
}

provider "aws" {
  region  = "us-east-1" # Using us-east-1 for cost optimization
  profile = var.aws_profile

  default_tags {
    tags = {
      Project     = "terraform-security-landing-zone"
      Environment = "global"
      ManagedBy   = "terraform"
      Purpose     = "backend"
    }
  }
}

# Generate random suffix for globally unique bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${random_string.bucket_suffix.result}"

  #  lifecycle {
  #    prevent_destroy = true # Prevent accidental deletion
  #  }

  tags = {
    Name       = "Terraform State Bucket"
    Critical   = "true"
    Compliance = "pci-dss"
  }
}

# Enable versioning for state file history
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rule for old versions
resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = "delete-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90 # Keep old versions for 90 days
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-nz4x4uva" # UPDATE THIS
    key            = "fintech-landing-zone/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
    profile        = "terraform-dev"
  }
}

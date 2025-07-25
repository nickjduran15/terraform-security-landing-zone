# backend-setup/variables.tf

variable "aws_profile" {
  description = "AWS profile to use for authentication"
  type        = string
  default     = "terraform-dev"
}

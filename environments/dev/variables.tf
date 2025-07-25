# environments/dev/variables.tf
# Environment-specific variables

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile to use"
  type        = string
  default     = "terraform-dev"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "fintech-landing-zone"
}

variable "owner_email" {
  description = "Email of the infrastructure owner"
  type        = string
}

variable "security_email" {
  description = "Email for security alerts"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Application Configuration
variable "app_instance_type" {
  description = "EC2 instance type for application servers"
  type        = string
  default     = "t2.micro" # Free tier eligible
}

variable "app_min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

variable "app_max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 2
}

variable "app_desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 1
}

# Database Configuration
variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro" # Free tier eligible
}

variable "db_allocated_storage" {
  description = "Allocated storage for RDS in GB"
  type        = number
  default     = 20 # Free tier provides 20GB
}

variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "fintechdb"
}

variable "db_username" {
  description = "Master username for database"
  type        = string
  default     = "admin"
  sensitive   = true
}

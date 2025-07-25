# Terraform Security Landing Zone for FinTech 🏦

> Enterprise-grade AWS infrastructure implementing security best practices and cost optimizations for a FinTech startup.

[![Terraform CI/CD](https://github.com/nickjduran15/terraform-security-landing-zone/actions/workflows/terraform.yml/badge.svg)](https://github.com/nickjduran15/terraform-security-landing-zone/actions/workflows/terraform.yml)

## 🎯 Project Overview

This project demonstrates infrastructure as code best practices by building a secure, scalable, and cost-optimized AWS environment suitable for FinTech applications requiring PCI DSS compliance considerations.

### Key Achievements

- 💰 **95% cost savings** using NAT instances vs NAT Gateways
- 🔒 **15+ security controls** implemented
- 🚀 **Fully automated** deployment in under 15 minutes
- 📊 **100% infrastructure as code** with Terraform

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Internet                             │
└────────────────┬────────────────────────────────────────────┘
                 │
        ┌───────┴────────┐
        │ Load Balancer  │
        └───────┬────────┘
                │
   ┌────────────┴────────────┐
   │    Public Subnets       │
   │  ┌─────┐    ┌─────┐     │
   │  │NAT-1│    │NAT-2│     │
   │  └──┬──┘    └──┬──┘     │
   └─────┼──────────┼───────┘
         │          │
   ┌─────┴──────────┴───────┐
   │   Private Subnets      │
   │  ┌──────┐  ┌──────┐    │
   │  │ App  │  │ App  │    │
   │  │ EC2  │  │ EC2  │    │
   │  └──┬───┘  └───┬──┘    │
   └─────┼──────────┼───────┘
         │          │
   ┌─────┴──────────┴───────┐
   │   Database Subnets     │
   │     ┌──────────┐       │
   │     │   RDS    │       │
   │     │  MySQL   │       │
   │     └──────────┘       │
   └─────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- AWS Account with appropriate permissions
- Terraform 1.5.7 or higher
- AWS CLI configured
- Git

### Clone the Repository

```bash
git clone https://github.com/nickjduran15/terraform-security-landing-zone.git
cd terraform-security-landing-zone
```

### Deploy Infrastructure

**Set up state backend:**

```bash
cd backend-setup
terraform init
terraform apply
# Note the S3 bucket name from output
```

**Deploy main infrastructure:**

```bash
cd ../environments/dev
# Update backend.tf with your S3 bucket name
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your email
terraform init
terraform apply
```

**Access the application:**

```bash
terraform output alb_url
# Open the URL in your browser
```

### Destroy Infrastructure

To avoid charges when not in use:

```bash
terraform destroy
```

## 📁 Repository Structure

```
.
├── backend-setup/              # Remote state infrastructure
│   ├── main.tf                # S3 bucket and DynamoDB table
│   ├── cost-controls.tf       # Budget alerts
│   └── outputs.tf             # Backend configuration
├── modules/                   # Reusable Terraform modules
│   ├── networking/           # VPC, subnets, routing
│   ├── security-baseline/    # Security services
│   └── monitoring/          # CloudWatch, alerts
├── environments/            # Environment-specific configs
│   └── dev/                # Development environment
│       ├── main.tf        # Root module
│       ├── variables.tf   # Input variables
│       └── outputs.tf     # Output values
└── .github/               # GitHub Actions CI/CD
    └── workflows/
        └── terraform.yml  # Automated validation
```

## 💰 Cost Optimization

This infrastructure is designed to minimize costs while maintaining security:

| Component     | Standard Cost   | Optimized Cost           | Savings  |
| ------------- | --------------- | ------------------------ | -------- |
| NAT Gateway   | $45/month       | NAT Instance $3.80/month | 92%      |
| Data Transfer | $90/month       | VPC Endpoints $0/month   | 100%     |
| EC2 Instances | 24/7 running    | Auto-shutdown            | 60%      |
| **Total**     | **$200+/month** | **$35-40/month**         | **80%+** |

## 🔒 Security Features

### Network Security

- Multi-AZ VPC with public/private/database subnet tiers
- Security groups with least privilege rules
- VPC Flow Logs for traffic analysis
- No SSH/RDP access by default

### Data Protection

- KMS encryption for all data at rest
- TLS encryption for data in transit
- Secrets Manager for database passwords
- No hardcoded credentials

### Monitoring & Compliance

- **AWS GuardDuty**: Threat detection
- **AWS CloudTrail**: API audit logging
- **AWS Config**: Compliance monitoring
- **CloudWatch**: Performance and security metrics

### Access Control

- IAM roles with minimal permissions
- Instance profiles for EC2
- Service-linked roles where applicable

## 📊 Terraform Modules

### Networking Module

Creates a secure multi-tier VPC architecture:

- 6 subnets across 2 AZs (public, private, database)
- Internet Gateway for public access
- NAT instances for private subnet internet access
- VPC endpoints for AWS services

### Security Baseline Module

Implements AWS security best practices:

- GuardDuty for threat detection
- CloudTrail for audit logging
- Config for compliance
- KMS keys for encryption
- Base IAM roles and policies

### Monitoring Module

Sets up observability and alerting:

- CloudWatch dashboards
- SNS topics for alerts
- Budget monitoring
- Auto-shutdown Lambda (cost optimization)

## 🧪 Testing & Validation

This project includes:

- ✅ Automated format checking
- ✅ Module validation
- ✅ Security scanning with Checkov
- ✅ GitHub Actions CI/CD pipeline

Run tests locally:

```bash
terraform fmt -recursive -check
terraform validate
```

## 📈 Monitoring & Alerts

The infrastructure includes comprehensive monitoring:

- CPU, memory, and disk metrics
- Application load balancer health
- Database performance metrics
- Security findings from GuardDuty
- Budget alerts for cost control

## 🔄 CI/CD Pipeline

GitHub Actions workflow runs on every push:

- Terraform format check
- Module validation
- Security scanning
- Cost estimation (when configured)

## 🤝 Contributing

This is a portfolio project, but suggestions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- AWS documentation and best practices guides
- Terraform documentation and examples
- HashiCorp learn tutorials
- Cloud security best practices community

---

Built with ❤️ using Terraform and AWS

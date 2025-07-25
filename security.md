# Security Policy

## Supported Versions

Currently supporting the latest version of this infrastructure.

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability in this infrastructure code, please report it to:

📧 **Email**: hariegglocke@gmail.com

Please include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

**Do not** create public issues for security vulnerabilities.

## Security Measures Implemented

This infrastructure implements multiple layers of security:

### Network Security

- Private subnets for application and database tiers
- Security groups with least privilege access
- VPC Flow Logs for network monitoring
- No direct internet access for critical resources

### Data Security

- Encryption at rest using AWS KMS
- Encrypted RDS storage
- Secrets managed via AWS Secrets Manager
- SSL/TLS for data in transit

### Access Control

- IAM roles with minimal required permissions
- No hardcoded credentials
- Instance profiles for EC2 access

### Monitoring & Compliance

- AWS GuardDuty for threat detection
- AWS CloudTrail for audit logging
- AWS Config for compliance monitoring
- CloudWatch alarms for security events

### Cost Security

- Budget alerts to prevent bill shock
- Auto-shutdown for non-production resources
- Resource tagging for cost allocation

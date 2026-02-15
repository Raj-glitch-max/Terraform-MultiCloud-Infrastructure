# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

**DO NOT** open public issues for security vulnerabilities.

If you have discovered a security vulnerability, please create a private issue or email the maintainer directly.

**Response Time**: 48 hours for acknowledgment, 7 days for initial assessment.

## Security Measures

This project implements the following security measures:

- **Infrastructure as Code Scanning**: All Terraform code is scanned with `tfsec` and `Checkov` in the CI/CD pipeline.
- **Secrets Management**: No hardcoded secrets. AWS Secrets Manager/Azure Key Vault/GCP Secret Manager are used for sensitive data.
- **State Encryption**: Terraform state files are encrypted at rest using S3 Server-Side Encryption (SSE) and DynamoDB (AWS), or equivalent in other clouds.
- **Network Isolation**: Resources are deployed in private subnets where possible, with strictly scoped Security Groups/NSGs/Firewall Rules.
- **Least Privilege**: IAM roles and service accounts are configured with minimum required permissions.
- **Audit Logging**: VPC Flow Logs and CloudTrail (AWS) are enabled for network and API activity auditing.

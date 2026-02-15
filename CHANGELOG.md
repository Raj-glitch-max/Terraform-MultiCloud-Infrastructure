# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Essential repository files: LICENSE, CODE_OF_CONDUCT, SECURITY.md, CONTRIBUTING.md.
- GitHub Issue and PR templates.
- CI/CD workflow for Terraform validation and security scanning.
- Documentation structure in `docs/`.
- Project architecture diagrams.

### Changed
- Refactored `main.tf` to remove hardcoded secrets (moved to variables).
- Cleaned up `.gitignore` to better handle sensitive files.
- Formatted all Terraform files to comply with `terraform fmt`.

## [1.0.0] - 2026-02-15

### Initial Release
- Multi-cloud infrastructure setup for AWS, Azure, and GCP.
- AWS: VPC, EKS, RDS (Multi-AZ).
- Azure: VNet, AKS, PostgreSQL.
- GCP: VPC, GKE, Cloud SQL.
- Modular Terraform structure.
- Jenkins setup with Docker Compose.
- Remote state management with S3 and DynamoDB.

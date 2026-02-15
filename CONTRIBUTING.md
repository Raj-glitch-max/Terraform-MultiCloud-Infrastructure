# Contributing to Terraform Multi-Cloud Infrastructure

Thank you for your interest in contributing! We welcome all contributions to make this project better.

## Development Setup

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5.0
- [AWS CLI](https://aws.amazon.com/cli/)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Docker](https://docs.docker.com/get-docker/) & Docker Compose (for Jenkins)

### Local Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/terraform-multicloud-infra.git
   cd terraform-multicloud-infra
   ```

2. **Environment Configuration**
   Copy the example environment file and configure your credentials.
   ```bash
   cp .env.example .env
   # Edit .env with your api keys and secrets
   ```
   *Note: Never commit your `.env` file!*

3. **Initialize Terraform**
   ```bash
   terraform init
   ```

## Pull Request Process

1. **Create a Branch**: Use a descriptive name (e.g., `feat/add-gcp-redis` or `fix/aws-vpc-cidr`).
2. **Make Changes**: Implement your feature or fix.
3. **Format Code**: Run `terraform fmt -recursive` to ensure code style consistency.
4. **Validate**: Run `terraform validate` to check for syntax errors.
5. **Test**: 
   - Run `terraform plan` to verify resource changes.
   - If adding a new module, verify it works in isolation.
6. **Commit**: Use clear commit messages (e.g., `feat(aws): add rds read replica`).
7. **Push & Open PR**: Push to your fork and submit a Pull Request to the `main` branch.

## Coding Standards

- **Naming**: Use `snake_case` for all Terraform resources and variables.
- **Variables**: Always use `description` and `type` for input variables.
- **Outputs**: Output useful values like IDs and endpoints, but mark sensitive data with `sensitive = true`.
- **Modules**: Keep modules small, focused, and reusable.
- **Documentation**: Update `README.md` or module documentation if you change infrastructure architecture.

## CI/CD

This repository uses GitHub Actions and Jenkins for CI/CD. All PRs are automatically checked for:
- Terraform formatting
- Terraform validation
- Security vulnerabilities (tfsec)

Ensure all checks pass before requesting a review.

# Local Setup Guide

Follow these steps to set up the infrastructure from your local machine.

## 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/terraform-multicloud-infra.git
cd terraform-multicloud-infra
```

## 2. Configure Environment

Copy the example environment file:
```bash
cp .env.example .env
```

Edit `.env` with your actual credentials:
```bash
nano .env
```

## 3. Configure Terraform Variables

Copy the example variables file:
```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your specific configuration:
```bash
nano terraform.tfvars
```

## 4. Initialize Terraform

Initialize the working directory and download provider plugins:
```bash
terraform init
```

## 5. Validate Configuration

Check if your configuration is valid:
```bash
terraform validate
```

## 6. Plan Deployment

Generate an execution plan to see what resources will be created:
```bash
terraform plan
```

## 7. Apply Changes

Apply the configuration to create resources (Warning: This will incur costs):
```bash
terraform apply
```
Type `yes` when prompted.

## 8. Destroy Infrastructure

To tear down all resources and stop billing:
```bash
terraform destroy
```

# Terraform Multi-Cloud Infrastructure

> **Production-grade infrastructure-as-code for AWS, Azure, and GCP with automated CI/CD**

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)](https://aws.amazon.com/)
[![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoft-azure)](https://azure.microsoft.com/)
[![GCP](https://img.shields.io/badge/GCP-Cloud-red?logo=google-cloud)](https://cloud.google.com/)
[![Jenkins](https://img.shields.io/badge/CI/CD-Jenkins-red?logo=jenkins)](https://www.jenkins.io/)

---

## 📋 Overview

A comprehensive **multi-cloud infrastructure** project demonstrating enterprise-grade DevOps practices across AWS, Azure, and Google Cloud Platform. This project showcases infrastructure-as-code, CI/CD automation, security scanning, and production-ready Kubernetes deployments.

### Cloud Distribution
- **AWS (40%)** - Primary Cloud
  - EKS Cluster (Kubernetes 1.28)
  - RDS PostgreSQL (Multi-AZ)
  - VPC with 3 Availability Zones
  
- **Azure (30%)** - Secondary Cloud
  - AKS Cluster
  - Azure Database for PostgreSQL
  - VNet with redundant subnets

- **GCP (30%)** - Tertiary Cloud
  - GKE Cluster
  - Cloud SQL
  - VPC with Cloud NAT

---

## ✨ Features

### Infrastructure
- ✅ **Multi-Cloud Architecture** across AWS, Azure, and GCP
- ✅ **Kubernetes Clusters** (EKS, AKS, GKE) with auto-scaling
- ✅ **Managed Databases** (RDS, Azure Database, Cloud SQL)
- ✅ **High Availability** with Multi-AZ deployments
- ✅ **Network Isolation** with private subnets
- ✅ **VPC Flow Logs** for security monitoring

### DevOps & CI/CD
- ✅ **Jenkins Pipeline** for Terraform automation
- ✅ **Security Scanning** (tfsec + Checkov)
- ✅ **Cost Estimation** (Infracost integration)
- ✅ **Manual Approval Gates** for production changes
- ✅ **Terraform 1.5+** with latest features
- ✅ **Remote State** (S3 + DynamoDB locking)

### Security
- ✅ **Encryption at Rest** for all databases
- ✅ **Security Groups** with least privilege
- ✅ **Secrets Management** ready (AWS Secrets Manager)
- ✅ **Automated Security Scanning** in CI/CD
- ✅ **VPC Flow Logs** for audit trails

---

## 🚀 Quick Start

### Prerequisites

1. **Terraform 1.5+**
2. **Cloud Provider Accounts** (AWS, Azure, GCP)
3. **Docker** (for Jenkins)

### Installation

```bash
git clone https://github.com/Raj-glitch-max/Terraform-MultiCloud-Infrastructure.git
cd Terraform-MultiCloud-Infrastructure

# Set up Jenkins
./setup-jenkins.sh

# Deploy infrastructure
terraform init
terraform plan
terraform apply
```

See full documentation in the README for detailed setup instructions.

---

## 📁 Project Structure

```
.
├── Modules/
│   ├── AWS_Module/     # AWS VPC, EKS, RDS
│   ├── Azure_Module/   # Azure VNet, AKS, Database
│   ├── GCP_Module/     # GCP VPC, GKE, Cloud SQL
│   └── Backend_Module/ # S3 + DynamoDB state
├── Jenkinsfile         # CI/CD pipeline
├── docker-compose.yml  # Local Jenkins setup
└── setup-jenkins.sh    # Automated installer

```

---

## 👤 Author

**Raj** - [@Raj-glitch-max](https://github.com/Raj-glitch-max)

---

**⭐ Star this repo if you find it helpful!**
# TODO: Fix OCI compartment configuration
# Project Status
Currently working on multi-cloud deployment automation
# Security Notes
# CI/CD Integration

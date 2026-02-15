# Terraform Multi-Cloud Infrastructure

> **Production-grade infrastructure-as-code for AWS, Azure, and GCP with automated CI/CD**

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazon-aws)
![Azure](https://img.shields.io/badge/Azure-Cloud-blue?logo=microsoft-azure)
![GCP](https://img.shields.io/badge/GCP-Cloud-red?logo=google-cloud)
![Jenkins](https://img.shields.io/badge/CI/CD-Jenkins-red?logo=jenkins)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

---

## 📋 Overview

A comprehensive **multi-cloud infrastructure** project demonstrating enterprise-grade DevOps practices across AWS, Azure, and Google Cloud Platform. This project showcases infrastructure-as-code, CI/CD automation, security scanning, and production-ready Kubernetes deployments.

### System Architecture

```mermaid
graph TB
    subgraph AWS [AWS (Primary 40%)]
        AWS_VPC[VPC] --> AWS_EKS[EKS Cluster]
        AWS_VPC --> AWS_RDS[RDS (Multi-AZ)]
    end
    
    subgraph Azure [Azure (Secondary 30%)]
        AZ_VNET[VNet] --> AZ_AKS[AKS Cluster]
        AZ_VNET --> AZ_DB[PostgreSQL]
    end
    
    subgraph GCP [GCP (Tertiary 30%)]
        GCP_VPC[VPC] --> GCP_GKE[GKE Cluster]
        GCP_VPC --> GCP_SQL[Cloud SQL]
    end
    
    Jenkins[Jenkins CI/CD] --> AWS
    Jenkins --> Azure
    Jenkins --> GCP
```

For detailed architecture documentation, see [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md).

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

---

## 🚀 Quick Start

### Prerequisites

1. **Terraform 1.5+**
2. **Cloud Provider Accounts** (AWS, Azure, GCP)
3. **Docker** (for Jenkins)

See [docs/getting-started/prerequisites.md](./docs/getting-started/prerequisites.md) for full details.

### Installation

```bash
git clone https://github.com/Raj-glitch-max/Terraform-MultiCloud-Infrastructure.git
cd Terraform-MultiCloud-Infrastructure

# Copy example environment variables
cp .env.example .env
cp terraform.tfvars.example terraform.tfvars

# Set up Jenkins (Optional)
./setup-jenkins.sh

# Deploy infrastructure manually
terraform init
terraform plan
terraform apply
```

See [docs/getting-started/local-setup.md](./docs/getting-started/local-setup.md) for detailed setup instructions.

---

## 📁 Project Structure

```
.
├── Modules/            # Reusable Terraform modules
│   ├── AWS_Module/     # AWS VPC, EKS, RDS
│   ├── Azure_Module/   # Azure VNet, AKS, Database
│   ├── GCP_Module/     # GCP VPC, GKE, Cloud SQL
│   └── Backend_Module/ # S3 + DynamoDB state
├── docs/               # Documentation
├── .github/            # GitHub templates and workflows
├── Jenkinsfile         # CI/CD pipeline
├── docker-compose.yml  # Local Jenkins setup
└── setup-jenkins.sh    # Automated installer
```

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md).

---

## 👤 Author

**Raj** - [@Raj-glitch-max](https://github.com/Raj-glitch-max)

---

**⭐ Star this repo if you find it helpful!**

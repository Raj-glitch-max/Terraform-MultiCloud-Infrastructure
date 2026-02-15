# System Architecture

## Overview

This project implements a multi-cloud architecture spanning AWS, Azure, and GCP. It uses Terraform for Infrastructure as Code (IaC) to provision a consistent and secure environment across all three providers.

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

## Cloud Distribution

- **AWS (Primary)**: Hosts the core application services on EKS and the primary relational database on RDS.
- **Azure (Secondary)**: Provides disaster recovery capabilities and additional compute capacity via AKS.
- **GCP (Tertiary)**: Used for specialized data processing workloads on GKE.

## Networking

- **VPN Tunnels**: Site-to-Site VPNs connect all three cloud environments to ensure private communication.
- **Private Subnets**: All databases and worker nodes are deployed in private subnets.
- **Load Balancers**: Public traffic is handled by cloud-native load balancers (ALB, Azure LB, GCP LB).

## Security

- **Encryption**: All data at rest is encrypted using provider-managed keys (KMS, Key Vault).
- **Secrets**: Sensitive data is managed via AWS Secrets Manager and Azure Key Vault.
- **IAM**: Least privilege access controls are enforced across all clouds.

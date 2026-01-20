# Main Terraform Configuration - Multi-Cloud Infrastructure
# AWS (Primary 40%) + Azure (Secondary 30%) + GCP (Tertiary 30%)

terraform {
  required_version = ">= 1.5.0"
}

# Data sources
data "aws_caller_identity" "current" {
  provider = aws.primary
}

# ========================================
# AWS INFRASTRUCTURE (40% - Primary Cloud)
# ========================================

module "aws_vpc" {
  source = "./Modules/AWS_Module/vpc"

  providers = {
    aws = aws.primary
  }

  region       = "us-east-1"
  vpc_cidr     = "10.0.0.0/16"
  project_name = var.project_name

  tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
    Cloud       = "AWS"
  }
}

module "aws_eks" {
  source = "./Modules/AWS_Module/eks"

  cluster_name       = "${var.project_name}-eks"
  kubernetes_version = "1.28"
  
  public_subnet_ids  = module.aws_vpc.public_subnet_ids
  private_subnet_ids = module.aws_vpc.private_subnet_ids

  desired_size   = 3
  min_size       = 2
  max_size       = 5
  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
    Cloud       = "AWS"
  }

  depends_on = [module.aws_vpc]
}

module "aws_rds" {
  source = "./Modules/AWS_Module/rds"

  db_name            = "${var.project_name}-db"
  database_name      = "multicloud_db"
  vpc_id             = module.aws_vpc.vpc_id
  vpc_cidr           = module.aws_vpc.vpc_cidr
  private_subnet_ids = module.aws_vpc.private_subnet_ids

  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  multi_az            = true

  master_username     = "dbadmin"
  master_password     = "ChangeMeInProduction123!" # TODO: Move to AWS Secrets Manager

  tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
    Cloud       = "AWS"
  }

  depends_on = [module.aws_vpc]
}

# ========================================
# OUTPUTS
# ========================================

output "aws_vpc_id" {
  description = "AWS VPC mesh ID"
  value       = module.aws_vpc.vpc_id
}

output "aws_eks_cluster_endpoint" {
  description = "AWS EKS cluster endpoint"
  value       = module.aws_eks.cluster_endpoint
}

output "aws_rds_endpoint" {
  description = "AWS RDS endpoint"
  value       = module.aws_rds.db_endpoint
  sensitive   = true
}

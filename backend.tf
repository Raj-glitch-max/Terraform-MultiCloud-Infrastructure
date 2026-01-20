# # Remote State Backend Configuration
# Uncomment after creating the S3 bucket and DynamoDB table
# Run: terraform init -migrate-state to migrate from local to remote

terraform {
  backend "s3" {
    bucket         = "terraform-multicloud-state-${data.aws_caller_identity.current.account_id}"
    key            = "multicloud-infra/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-multicloud-state-lock"
    
    # Enable versioning for state file recovery
    # versioning = true
  }
}

# Create backend resources (S3 + DynamoDB)
module "backend" {
  source = "./Modules/Backend_Module"
  providers = {
    aws = aws.primary
  }
  
  project_name = "multicloud-infra"
}
#   bucket_name   = "hybridinfrastatebucket"
#   dynamodb_name = "hybridinfrastatelockdb"
# }
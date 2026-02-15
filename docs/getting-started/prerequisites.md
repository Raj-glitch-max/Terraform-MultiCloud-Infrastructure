# Prerequisites

Before setting up the project, ensure you have the following tools installed.

## Required Tools

| Tool | Version | Purpose |
|------|---------|---------|
| [Terraform](https://developer.hashicorp.com/terraform/downloads) | >= 1.5.0 | Infrastructure provisioning |
| [Docker](https://docs.docker.com/get-docker/) | Latest | Container runtime for Jenkins |
| [Docker Compose](https://docs.docker.com/compose/install/) | Latest | Orchestrating Jenkins container |
| [AWS CLI](https://aws.amazon.com/cli/) | Latest | AWS authentication |
| [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) | Latest | Azure authentication |
| [gcloud CLI](https://cloud.google.com/sdk/docs/install) | Latest | GCP authentication |

## Cloud Accounts

You will need active accounts for:
- **AWS**: Access Key and Secret Key with AdministratorAccess (or scoped permissions).
- **Azure**: Subscription ID, Tenant ID, Client ID, and Client Secret (Service Principal).
- **GCP**: Project ID and Service Account JSON key.

## Keys

- **SSH Key**: Generate an SSH key pair (`ssh-keygen -t rsa -f ~/.ssh/id_rsa`) for accessing compute instances.

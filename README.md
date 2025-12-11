# Terraform Multicloud Infrastructure

This repository contains Terraform code to provision infrastructure across multiple clouds, including Azure and Oracle Cloud.

## Prerequisites

- **Oracle and Azure Paid Accounts**: Necessary to set up their respective Terraform providers.
- **Oracle Provider Setup**: Follow the instructions [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm). This setup uses the SDK and CLI options.
- **Azure Provider Setup**: Review the `variables.tf` file for variables starting with 'az_' and set their values in an environment file. Watch [this video](https://www.youtube.com/watch?v=wB52Rd5N9IQ&list=PLLc2nQDXYMHowSZ4Lkq2jnZ0gsJL3ArAw&index=5) for guidance.
  - Ensure environment variables follow the format: `export TF_VAR_az_client_id="someclientid"`
- **Compartment ID for Oracle**: In Oracle, create a new compartment beyond the default and export its ID to the environment (e.g., `export TF_VAR_oci_compartment_id="your_compartment_id"`).
- **SSH Key Pair**: Create an SSH key pair for the servers and add its public key path to the `ssh_key` variable in `variables.tf` (or export it to the environment).
- **SSL Certificate for Load Balancers**: Place your SSL certificate files in `~/ssl`, which should contain `ca.txt`, `certificate.txt`, `cert.pfx`, and `private.txt`. Export the `cert.pfx` SSL password to the environment, as needed by Azure's application gateway.
- **Software Requirements**: Ensure Terraform CLI , Node.js and tsc are installed, the latter for advanced VPN configuration since it's unsupported by the OCI provider.

## Installation

```bash
git clone https://github.com/Moody-san/terraform-multicloud-infra.git
cd terraform-multicloud-infra
```

## Usage

```bash
terraform init
terraform plan
terraform apply
```
## Configuration

Edit the server.tf file to easily scale up and down on Oracle and Azure Cloud

## Optional Configuration

- **Disable Azure Resources**: Comment out `azureresources.tf` and its references in `server.tf` if Azure is not needed.
- **VM Instance Type**: To provision regular VMs instead of spot instances in Azure, comment the appropriate lines in the compute module file as indicated by the comments.
- **VPN Setup**: Comment out `vpn.tf` if a VPN between the clouds is not required. Our use case for the VPN was to synchronize MariaDB and reuse Jenkins, Argo, and Bastion servers.
- **Automated Inventory**: Comment out `inventory.tf` if not required . This uses inventory module to automatically setup inventory for ansible repositories mentioned in additional resources. 

## Additional Resources

- **Kubernetes Setup**: For setting up Kubernetes on this infrastructure, see [ansible-k8s-deployment](https://github.com/Moody-san/ansible-k8s-deployment).
- **MariaDB Cluster Setup**: For setting up a MariaDB cluster with Kubernetes-based failover, visit [ansible-galeracluster-deployment](https://github.com/Moody-san/ansible-galeracluster-deployment).
- **CI/CD and Automation**: For CI/CD and other automation scripts, refer to [ansible-controller-setup](https://github.com/Moody-san/ansible-controller-setup).
## Demo

https://www.youtube.com/watch?v=HC4oogjLf64

## Presentation

https://docs.google.com/presentation/d/1peuU2K6cA1b9EeZd8g-iz_ve9KucFXQJLtqBe5yV294/edit?usp=sharing

## Todo

- Set up a jenkins controller that will watch terraform repository for infrastructure changes based on commits and update the deployed resources . Will have to use remote backend for state files for this .
- Better more modular code with mockups for validating modules
- Distributing the galera cluster across cloud kinda makes one cloud read only in case vpn is down , so instead either use an entirely different cloud for database or use 2 galera clusters (each on a different cloud) which remain in sync  .
# TODO: Fix OCI compartment configuration

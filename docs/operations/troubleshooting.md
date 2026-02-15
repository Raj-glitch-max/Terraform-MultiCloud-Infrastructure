# Troubleshooting

## Common Issues

### 1. Terraform Init Fails

**Error**: `Failed to query available provider packages`
**Solution**:
- Check your internet connection.
- Ensure you have the latest version of Terraform installed.
- Delete `.terraform/` folder and `.terraform.lock.hcl` and run `terraform init` again.

### 2. Authentication Errors

**Error**: `Status=403 AccessDenied` or `AuthFailure`
**Solution**:
- Verify your credentials in `.env` or `terraform.tfvars`.
- Ensure your IAM user/Service Principal has sufficient permissions.
- Check if your system time is synchronized.

### 3. State Lock

**Error**: `Error acquiring the state lock`
**Solution**:
- If a previous run crashed, the state might be locked in DynamoDB.
- Go to AWS Console > DynamoDB > Tables > `terraform-multicloud-state-lock`.
- Manually delete the lock item matching your State Lock ID.
- **Warning**: Only do this if you are sure no other process is running.

### 4. Quota Exceeded

**Error**: `VcpuLimitExceeded` or `QuotaExceeded`
**Solution**:
- Request a quota increase from the cloud provider.
- Or reduce the number of instances/nodes in `variables.tf`.

## Debugging

To get more verbose logs from Terraform:

```bash
export TF_LOG=DEBUG
terraform plan > plan.log 2>&1
```

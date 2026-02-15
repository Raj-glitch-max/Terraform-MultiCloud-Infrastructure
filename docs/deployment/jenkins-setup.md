# Jenkins Setup Guide

This project includes an automated setup script for Jenkins.

## Automated Setup

1. **Run the Setup Script**
   ```bash
   ./setup-jenkins.sh
   ```
   This script will:
   - Check for Docker installation.
   - Create valid initial configuration.
   - Start Jenkins using Docker Compose.
   - Output the initial admin password.

2. **Access Jenkins**
   - Open [http://localhost:8080](http://localhost:8080) in your browser.
   - Login with the credentials provided by the script (usually `admin` / `admin123`).

## Configuration

### 1. Credentials
Navigate to **Manage Jenkins** > **Manage Credentials** and add the following:
- `aws-credentials`: AWS Access Key and Secret Key.
- `azure-credentials`: Azure Service Principal details.
- `gcp-credentials`: GCP Service Account JSON.
- `github-token`: Personal Access Token for GitHub (if using private repo).

### 2. Pipeline Job
1. Click **New Item**.
2. Enter a name (e.g., `Multicloud-Deploy`).
3. Select **Pipeline**.
4. Scroll to **Pipeline** section.
5. Select **Pipeline script from SCM**.
6. Set **SCM** to **Git**.
7. Enter your repository URL.
8. Set **Script Path** to `Jenkinsfile`.
9. Click **Save**.

### 3. Run Pipeline
Click **Build Now** to trigger the deployment pipeline.

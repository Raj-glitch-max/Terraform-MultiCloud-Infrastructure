pipeline {
    agent any
    
    environment {
        // AWS Credentials (configure in Jenkins)
        AWS_CREDENTIALS = credentials('aws-credentials')
        
        // Azure Credentials
        AZURE_CREDENTIALS = credentials('azure-credentials')
        
        // GCP Credentials
        GCP_CREDENTIALS = credentials('gcp-credentials')
        
        // Terraform Version
        TF_VERSION = '1.6.0'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'git --version'
            }
        }
        
        stage('Setup Terraform') {
            steps {
                script {
                    // Install Terraform if not present
                    sh '''
                        if ! command -v terraform &> /dev/null; then
                            wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
                            unzip terraform_${TF_VERSION}_linux_amd64.zip
                            sudo mv terraform /usr/local/bin/
                            rm terraform_${TF_VERSION}_linux_amd64.zip
                        fi
                        terraform version
                    '''
                }
            }
        }
        
        stage('Terraform Format Check') {
            steps {
                sh 'terraform fmt -check -recursive || true'
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh '''
                    terraform init -upgrade
                '''
            }
        }
        
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        
        stage('Security Scan - tfsec') {
            steps {
                script {
                    sh '''
                        # Install tfsec if not present
                        if ! command -v tfsec &> /dev/null; then
                            wget https://github.com/aquasecurity/tfsec/releases/download/v1.28.1/tfsec-linux-amd64
                            chmod +x tfsec-linux-amd64
                            sudo mv tfsec-linux-amd64 /usr/local/bin/tfsec
                        fi
                        
                        # Run tfsec scan
                        tfsec . --format json --out tfsec-report.json || true
                        tfsec . || true
                    '''
                }
            }
        }
        
        stage('Security Scan - Checkov') {
            steps {
                script {
                    sh '''
                        # Install Checkov if not present
                        if ! command -v checkov &> /dev/null; then
                            pip3 install checkov || sudo pip3 install checkov
                        fi
                        
                        # Run Checkov scan
                        checkov -d . --framework terraform --output json --output-file checkov-report.json || true
                        checkov -d . --framework terraform || true
                    '''
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan -out=tfplan
                    terraform show -json tfplan > tfplan.json
                '''
            }
        }
        
        stage('Cost Estimation') {
            steps {
                script {
                    sh '''
                        # Install Infracost if not present
                        if ! command -v infracost &> /dev/null; then
                            curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
                        fi
                        
                        # Run cost estimation
                        infracost breakdown --path . --format json --out-file infracost-report.json || echo "Infracost failed or not configured"
                    '''
                }
            }
        }
        
        stage('Approval for Apply') {
            when {
                branch 'main'
            }
            steps {
                script {
                    def userInput = input(
                        id: 'userInput',
                        message: 'Apply Terraform changes?',
                        parameters: [
                            choice(
                                choices: ['Apply', 'Abort'],
                                description: 'Choose to apply or abort',
                                name: 'action'
                            )
                        ]
                    )
                    
                    if (userInput == 'Abort') {
                        error('User aborted the deployment')
                    }
                }
            }
        }
        
        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
        
        stage('Output Results') {
            steps {
                sh 'terraform output -json > terraform-outputs.json'
            }
        }
    }
    
    post {
        always {
            // Archive artifacts
            archiveArtifacts artifacts: '*-report.json,tfplan.json,terraform-outputs.json', allowEmptyArchive: true
            
            // Clean workspace
            cleanWs()
        }
        
        success {
            echo '✅ Pipeline completed successfully!'
        }
        
        failure {
            echo '❌ Pipeline failed. Check the logs for details.'
        }
    }
}

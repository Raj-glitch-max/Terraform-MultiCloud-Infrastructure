#!/bin/bash

# Jenkins Local Setup Script for Multi-Cloud Infrastructure Project
# This script will set up Jenkins with all required plugins and configurations

set -e

COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_YELLOW='\033[1;33m'
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m' # No Color

echo -e "${COLOR_BLUE}======================================${COLOR_NC}"
echo -e "${COLOR_BLUE}   Jenkins Setup for Multi-Cloud     ${COLOR_NC}"
echo -e "${COLOR_BLUE}======================================${COLOR_NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${COLOR_RED}❌ Docker is not installed!${COLOR_NC}"
    echo -e "${COLOR_YELLOW}Please install Docker first:${COLOR_NC}"
    echo "Ubuntu/Debian: sudo apt-get install docker.io docker-compose"
    echo "Mac: brew install docker docker-compose"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${COLOR_RED}❌ Docker Compose is not installed!${COLOR_NC}"
    echo -e "${COLOR_YELLOW}Installing Docker Compose...${COLOR_NC}"
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

echo -e "${COLOR_GREEN}✅ Docker and Docker Compose are installed${COLOR_NC}"

# Create jenkins-init directory for automatic setup
mkdir -p jenkins-init

# Create Jenkins configuration script
cat > jenkins-init/basic-security.groovy << 'EOF'
#!groovy
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

// Create admin user
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin123")
instance.setSecurityRealm(hudsonRealm)

// Set authorization strategy
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

instance.save()
EOF

# Create plugin installation script
cat > jenkins-init/install-plugins.groovy << 'EOF'
#!groovy
import jenkins.model.Jenkins

def plugins = [
    "git",
    "workflow-aggregator",
    "pipeline-stage-view",
    "terraform",
    "credentials",
    "credentials-binding",
    "github",
    "slack",
    "email-ext",
    "ansicolor"
]

def pm = Jenkins.instance.pluginManager
def uc = Jenkins.instance.updateCenter

plugins.each {
    if (!pm.getPlugin(it)) {
        println("Installing ${it}")
        def plugin = uc.getPlugin(it)
        plugin.deploy()
    }
}
EOF

echo -e "${COLOR_GREEN}✅ Jenkins configuration files created${COLOR_NC}"

# Start Jenkins
echo -e "${COLOR_BLUE}🚀 Starting Jenkins container...${COLOR_NC}"
docker-compose up -d

# Wait for Jenkins to start
echo -e "${COLOR_YELLOW}⏳ Waiting for Jenkins to start (this may take 1-2 minutes)...${COLOR_NC}"
sleep 30

# Check if Jenkins is running
if docker ps | grep -q multicloud-jenkins; then
    echo -e "${COLOR_GREEN}✅ Jenkins is running!${COLOR_NC}"
    echo ""
    echo -e "${COLOR_GREEN}======================================${COLOR_NC}"
    echo -e "${COLOR_GREEN}   Jenkins is ready!                 ${COLOR_NC}"
    echo -e "${COLOR_GREEN}======================================${COLOR_NC}"
    echo ""
    echo -e "${COLOR_BLUE}📍 URL:${COLOR_NC} http://localhost:8080"
    echo -e "${COLOR_BLUE}👤 Username:${COLOR_NC} admin"
    echo -e "${COLOR_BLUE}🔒 Password:${COLOR_NC} admin123"
    echo ""
    echo -e "${COLOR_YELLOW}Next Steps:${COLOR_NC}"
    echo "1. Open http://localhost:8080 in your browser"
    echo "2. Login with admin/admin123"
    echo "3. Go to 'Manage Jenkins' > 'Manage Credentials'"
    echo "4. Add your cloud provider credentials"
    echo "5. Create a new Pipeline job pointing to your GitHub repo"
    echo ""
    echo -e "${COLOR_BLUE}📖 Full guide:${COLOR_NC} See docs/jenkins-setup.md"
else
    echo -e "${COLOR_RED}❌ Jenkins failed to start${COLOR_NC}"
    echo "Check logs with: docker-compose logs jenkins"
    exit 1
fi

#!/bin/bash

echo "==========================================="
echo "  Jenkins Password Reset Guide           "
echo "==========================================="
echo ""

# Check if Jenkins is running
if pgrep -x "java" > /dev/null && ps aux | grep jenkins.war | grep -v grep > /dev/null; then
    echo "✅ Jenkins is running"
    echo ""
    
    # Find Jenkins home
    JENKINS_HOME=$(ps aux | grep jenkins.war | grep -v grep | grep -oP '(?<=-Djava.io.tmpdir=)[^ ]*' || echo "/var/lib/jenkins")
    
    echo "Jenkins appears to be installed at: /var/lib/jenkins (typical location)"
    echo ""
    echo "==========================================="
    echo "METHOD 1: Disable Security (Easiest)"
    echo "==========================================="
    echo ""
    echo "1. Stop Jenkins:"
    echo "   sudo systemctl stop jenkins"
    echo ""
    echo "2. Edit config.xml to disable security:"
    echo "   sudo sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/g' /var/lib/jenkins/config.xml"
    echo ""
    echo "3. Start Jenkins:"
    echo "   sudo systemctl start jenkins"
    echo ""
    echo "4. Go to http://localhost:8080"
    echo "   (You'll be logged in automatically)"
    echo ""
    echo "5. Create new admin user:"
    echo "   - Go to: Manage Jenkins → Manage Users"
    echo "   - Create new user with password you'll remember"
    echo ""
    echo "6. Re-enable security:"
    echo "   - Go to: Manage Jenkins → Configure Global Security"
    echo "   - Enable 'Jenkins' own user database'"
    echo "   - Save"
    echo ""
    echo "==========================================="
    echo "METHOD 2: Find Initial Password"
    echo "==========================================="
    echo ""
    echo "Try to find the initial admin password:"
    echo "   sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    echo ""
    echo "==========================================="
    echo "METHOD 3: Start Fresh (Nuclear Option)"
    echo "==========================================="
    echo ""
    echo "Kill old Jenkins and start our new Docker one:"
    echo "   sudo systemctl stop jenkins"
    echo "   sudo systemctl disable jenkins"
    echo "   # Then change our docker-compose.yml back to port 8080"
    echo "   # And run: docker-compose up -d"
    echo ""
    echo "==========================================="
    
else
    echo "❌ Jenkins doesn't appear to be running"
fi

echo ""
echo "Choose your method and let me know!"

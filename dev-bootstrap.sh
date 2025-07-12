#!/bin/bash

set -e

echo "🔧 Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

echo "🐳 Installing Docker (from Docker CE official repo)..."
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker ${USER}

echo "✅ Docker installed."

echo "🔧 Installing Docker Compose..."
sudo apt install -y docker-compose
echo "✅ Docker Compose installed."

echo "⚙️ Installing Terraform (HashiCorp official repo)..."
sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update -y && sudo apt install -y terraform
echo "✅ Terraform installed."

echo "⚙️ Installing Jenkins (LTS)..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y openjdk-17-jdk jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "✅ Jenkins installed."

echo "⚙️ Installing Ansible (official PPA)..."
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update -y && sudo apt install -y ansible
echo "✅ Ansible installed."

echo "⚙️ Installing Azure CLI (official Microsoft repo)..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "✅ Azure CLI installed."

echo "🚀 DevOps environment setup complete. Please reboot the server for group/user changes to take effect."

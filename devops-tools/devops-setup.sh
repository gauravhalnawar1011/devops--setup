#!/bin/bash
set -e

# ===== Functions for each tool ===== #

install_docker() {
    echo "🐳 Installing Docker..."
    sudo apt-get update -y
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo usermod -aG docker $USER
    echo "✅ Docker installed. Log out & back in to use without sudo."
}

install_git() {
    echo "📦 Installing Git..."
    sudo apt-get update -y
    sudo apt-get install -y git
    git --version
    echo "✅ Git installed."
}

install_python() {
    echo "🐍 Installing Python..."
    sudo apt-get update -y
    sudo apt-get install -y software-properties-common curl
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update -y
    sudo apt-get install -y python3.12 python3.12-venv python3.12-dev python3-pip
    sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
    sudo update-alternatives --set python3 /usr/bin/python3.12
    python3 --version
    pip3 --version
    echo "✅ Python installed."
}

install_terraform() {
    echo "🌍 Installing Terraform..."
    TERRAFORM_VERSION="1.12.2"
    wget -q "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
    unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    terraform -version
    echo "✅ Terraform installed."
}

install_helm() {
    echo "📦 Installing Helm..."
    curl https://baltocdn.com/helm/signing.asc | sudo gpg --dearmor -o /usr/share/keyrings/helm.gpg
    echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | \
        sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update -y
    sudo apt-get install -y helm
    helm version
    echo "✅ Helm installed."
}

install_kubectl() {
    echo "☸️ Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    kubectl version --client
    echo "✅ kubectl installed."
}

install_ansible() {
    echo "🔧 Installing Ansible..."
    sudo apt-get update -y
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible
    ansible --version
    echo "✅ Ansible installed."
}

install_awscli() {
    echo "☁️ Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
    aws --version
    echo "✅ AWS CLI installed."
}



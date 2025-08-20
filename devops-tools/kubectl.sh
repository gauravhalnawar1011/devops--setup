#!/bin/bash
set -e

echo "🚀 Installing kubectl..."

sudo apt-get update -y
sudo apt-get install -y curl

# Download latest stable release
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "✅ kubectl installed successfully!"
kubectl version --client

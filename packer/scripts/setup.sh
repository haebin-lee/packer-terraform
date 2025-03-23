#!/bin/bash

# Update system
sudo dnf update -y

# Install Docker
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user

# Install additional useful packages
sudo dnf install -y git curl wget

# Configure system for Docker
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Restart Docker to apply changes
sudo systemctl restart docker

# Clean up
sudo dnf clean all
sudo rm -rf /var/cache/dnf/* 
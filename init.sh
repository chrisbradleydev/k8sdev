#!/usr/bin/env bash

# Set absolute path to project
read -p "Enter absolute project path: " absolute_path
gsed -i 's|mymac:/Users/mymacuser/absolutepath|mymac:'$absolute_path'|' ./k8s/deployment.yaml

# Set mac user
mac_user="$(whoami)"
gsed -i 's|mymacuser|'$mac_user'|' ./k8s/deployment.yaml

# Set mac ip
mac_ip="$(ifconfig -l | xargs -n1 ipconfig getifaddr)"
gsed -i 's|192.168.1.100|'$mac_ip'|' ./k8s/deployment.yaml

# Set private key
private_key=$(cat id_ed25519 | base64)
gsed -i 's|base64-privatekey|'$private_key'|' ./k8s/deployment.yaml

# Set public key
public_key=$(cat id_ed25519.pub | base64)
gsed -i 's|base64-publickey|'$public_key'|' ./k8s/deployment.yaml

# Open Docker Desktop
open -a Docker

# Wait for Docker to start
while ! docker info >/dev/null 2>&1; do
    echo "Waiting for Docker Desktop to start..."
    sleep 2
done

# Build Docker images
docker build -t alpine321 -f Dockerfile.alpine321 .
docker build -t rclone169 -f Dockerfile.rclone169 .

# Create cluster
kind create cluster

# Load images
kind load docker-image alpine321
kind load docker-image rclone169

# Create deployment
kubectl apply -f k8s/deployment.yaml

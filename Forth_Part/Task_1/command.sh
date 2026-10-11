#!/bin/bash

# Extract the EC2 private IP address
EC2_IP=$(grep -m 1 '"PrivateIpAddress"' info.json | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')

# Check if IP was found
if [[ -z "$EC2_IP" ]]; then
    echo "Error: EC2 private IP not found."
    exit 1
fi

# Display extracted IP
echo "EC2 Private IP: $EC2_IP"

# Create a backup of the Terraform file
cp terraform.tf terraform.tf.bak

# Replace placeholder with actual IP
sed -i "s/ec2-private_ip/$EC2_IP/g" terraform.tf

echo "Terraform file updated successfully."
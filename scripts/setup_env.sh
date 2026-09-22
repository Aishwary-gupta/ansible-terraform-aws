#!/usr/bin/env bash
set -e

echo "=== Syncing AWS Credentials ==="
mkdir -p /root/.aws
if [ -d "/mnt/c/Users/AISHWARY GUPTA/.aws" ]; then
    cp -r "/mnt/c/Users/AISHWARY GUPTA/.aws/"* /root/.aws/
    chmod 600 /root/.aws/*
    echo "AWS credentials synced to /root/.aws"
fi

echo "=== Verifying Python & Ansible in WSL ==="
python3 -c "import boto3; sts = boto3.client('sts', region_name='ap-south-1'); print('Authenticated ARN:', sts.get_caller_identity()['Arn'])"
ansible --version | head -n 2

echo "=== Setup Completed Successfully ==="
#!/usr/bin/env bash
set -e

PROJECT_ROOT="/mnt/c/Users/AISHWARY GUPTA/.gemini/antigravity/scratch/ansible-terraform-aws"
export ANSIBLE_CONFIG="$PROJECT_ROOT/ansible/ansible.cfg"

# Fix SSH key permissions for OpenSSH client
chmod 600 "$PROJECT_ROOT/keys/ansible_ed25519" 2>/dev/null || true

cd "$PROJECT_ROOT/ansible"
exec "$@"
#!/bin/bash
set -e

# Install certbot + cloudflare plugin
apt update
apt install -y certbot python3-certbot-dns-cloudflare

# Create secrets dir
mkdir -p /etc/letsencrypt/secrets
chown root:root /etc/letsencrypt/secrets
chmod 700 /etc/letsencrypt/secrets

# Download the certbot script
curl -sL https://raw.githubusercontent.com/DogG0d/script-store/main/scripts/certificate-management/certbot-issue.sh > /usr/local/bin/certbot-cloudflare-issue.sh
chmod +x /usr/local/bin/certbot-cloudflare-issue.sh

echo "Certbot + script installed"

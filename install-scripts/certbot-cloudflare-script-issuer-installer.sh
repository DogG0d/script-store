#!/bin/bash
set -e

LETS_ENCRYPT_SECRETS_PATH=/etc/letsencrypt/secrets

# Install certbot + cloudflare plugin
apt update
apt install -y certbot python3-certbot-dns-cloudflare

# Create secrets dir
mkdir -p ${LETS_ENCRYPT_SECRETS_PATH}
chown root:root ${LETS_ENCRYPT_SECRETS_PATH}
chmod 700 ${LETS_ENCRYPT_SECRETS_PATH}

# Create cloudflare.ini with placeholder
cat > ${LETS_ENCRYPT_SECRETS_PATH}/cloudflare.ini << EOF
DNS_CLOUDFLARE_API_TOKEN=your_token_here
EOF
chown root:root ${LETS_ENCRYPT_SECRETS_PATH}/cloudflare.ini
chmod 600 ${LETS_ENCRYPT_SECRETS_PATH}/cloudflare.ini

# Download the certbot script
curl -s https://raw.githubusercontent.com/DogG0d/script-store/main/scripts/certificate-management/certbot-issue.sh > /usr/local/bin/certbot-cloudflare-issue
chmod +x /usr/local/bin/certbot-cloudflare-issue

echo "Certbot + script installed, please make sure to add a Cloudflare api key to ${LETS_ENCRYPT_SECRETS_PATH}/cloudflare.ini"

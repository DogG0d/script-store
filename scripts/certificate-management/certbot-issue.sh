#!/usr/bin/env bash
set -eu

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <email> <domain1> [domain2 ...]"
  exit 1
fi

EMAIL="$1"
shift

if [ ! -f /etc/letsencrypt/secrets/cloudflare.ini ]; then
  echo "Missing /etc/letsencrypt/secrets/cloudflare.ini"
  exit 1
fi

CF_CRED_FILE="/etc/letsencrypt/secrets/cloudflare.ini"
chmod 600 "$CF_CRED_FILE"

# First domain is the cert name
CERT_NAME="$1"

# Build -d args for all domains
DOMAINS_ARGS=()
for d in "$@"; do
  DOMAINS_ARGS+=( -d "$d" )
done

certbot certonly \
  --non-interactive \
  --agree-tos \
  --email "$EMAIL" \
  --dns-cloudflare \
  --dns-cloudflare-credentials "$CF_CRED_FILE" \
  --dns-cloudflare-propagation-seconds 30 \
  --cert-name "$CERT_NAME" \
  "${DOMAINS_ARGS[@]}"
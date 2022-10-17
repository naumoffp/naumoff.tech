# Ensure the proper environment variables are set
if [[ -z "${CERT_EMAIL}" ]]; then
  exit 1;
else
  CERT_EMAIL="${CERT_EMAIL}"
fi

if [[ -z "${CERT_DOMAIN}" ]]; then
  exit 1;
else
  CERT_DOMAIN="${CERT_DOMAIN}"
fi


# >> If no certificates are found, get new ones:

# Create relevant directories

# Pull dummy certificates

# Inject dummy certificates into swarm secrets

# Launch server

# Obtain real certificates
sudo docker run --rm --name DiE4uBot \
    -v $PWD/certmaster/letsencrypt:/etc/letsencrypt \
    -v $PWD/certmaster/certs:/etc/letsencrypt/live/${CERT_DOMAIN} \
    -v $PWD/certmaster/verify:/verify/letsencrypt \
    -v $PWD/certmaster/servers-data/DiE4uBot:/var/log/letsencrypt \
    certbot/certbot:v1.8.0 \
    certonly --webroot --agree-tos \
    --preferred-challenges http-01 --server https://acme-v02.api.letsencrypt.org/directory \
    --text --email ${CERT_EMAIL} \
    -w /verify/letsencrypt -d ${CERT_DOMAIN} -d ${CERT_DOMAIN}

# Change ownership of certificates to root

# Delete dummy certificate secrets

# Create symlink folder to certificates
cd x
ln -s letsencrypt/live/${CERT_DOMAIN} certs

# Run post-hook for adding real certificates to swarm secrets

# >> Renew certificates and deploy over swarm secrets:

sudo docker run --rm --name DiE6uBot \
    -v $PWD/certmaster/letsencrypt:/etc/letsencrypt \
    -v $PWD/certmaster/servers-data/DiE6uBot:/var/log/letsencrypt \
    certbot/certbot:v1.8.0 \
    renew \
    --agree-tos --email ${CERT_EMAIL} \
    --force-renewal \
    --post-hook scripts/update_deploy.sh

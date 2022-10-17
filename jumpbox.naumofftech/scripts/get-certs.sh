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

curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "data/certbot/conf/options-ssl-nginx.conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "data/certbot/conf/ssl-dhparams.pem"


sudo docker compose -f docker-compose.yml -f scripts/dummy-certs.yml up --force-recreate serf
sudo docker compose -f docker-compose.yml up --force-recreate serf

sudo docker compose exec --privileged --user root serf sh -c 'rm -rf /etc/letsencrypt/live/${CERT_DOMAIN}/'

# --rm automatically remove the container when it exists
sudo docker run --name tmp_certbot \
  -v /data/certbot/letsencrypt:/etc/letsencrypt \
  -v /data/certbot/www:/var/tmp/certbot \
  -v /data/servers-data/certbot/log:/var/log \
  --entrypoint " \
  certbot certonly --webroot -w /var/tmp/certbot \
    --email ${CERT_EMAIL} \
    -d ${CERT_DOMAIN} \
    -d www.${CERT_DOMAIN} \
    --rsa-key-size 4096 \
    --force-renewal \
    -v" certbot

sudo docker compose restart serf

# Staging
# https://acme-staging-v02.api.letsencrypt.org/directory

# Real
# https://acme-v02.api.letsencrypt.org/directory

sudo docker run --name temp_certbo35225t \
    -v $PWD/certmaster/letsencrypt:/etc/letsencrypt \
    -v $PWD/certmaster/certs:/etc/letsencrypt/live/${CERT_DOMAIN} \
    -v $PWD/certmaster/verify:/verify/letsencrypt \
    -v $PWD/certmaster/servers-data/certbot/log:/var/log \
    certbot/certbot:v1.8.0 \
    certonly --webroot --agree-tos \
    --preferred-challenges http-01 --server https://acme-v02.api.letsencrypt.org/directory \
    --text --email ${CERT_EMAIL} \
    -w /verify/letsencrypt -d ${CERT_DOMAIN} -d ${CERT_DOMAIN}

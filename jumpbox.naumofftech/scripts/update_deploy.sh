#!/bin/bash
# This script is to be run as a post hook to certbot renewal or certbot certonly

CERT_MD5=$(md5sum certmaster/certs/fullchain.pem | awk '{ print $1 }')
KEY_MD5=$(md5sum certmaster/certs/privkey.pem | awk '{ print $1 }')
CHAIN_MD5=$(md5sum certmaster/certs/chain.pem | awk '{ print $1 }')

sudo docker stack deploy --compose-file docker-compose.yml tswarm --with-registry-auth

#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

DOMAIN=$(jq --raw-output ".domain" $CONFIG_PATH)
HOST=$(jq --raw-output ".host" $CONFIG_PATH)
KEYFILE=$(jq --raw-output ".keyfile" $CONFIG_PATH)
CERTFILE=$(jq --raw-output ".certfile" $CONFIG_PATH)

# Prepare config file
sed -i "s/%%FULLCHAIN%%/$CERTFILE/g" /etc/nginx.conf
sed -i "s/%%PRIVKEY%%/$KEYFILE/g" /etc/nginx.conf
sed -i "s/%%DOMAIN%%/$DOMAIN/g" /etc/nginx.conf
sed -i "s/%%HOST%%/$HOST/g" /etc/nginx.conf

# start server
exec nginx -c /etc/nginx.conf < /dev/null
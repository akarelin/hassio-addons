#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

HOST=$(jq --raw-output ".host" $CONFIG_PATH)
DOMAIN=$(jq --raw-output ".domain" $CONFIG_PATH)
KEYFILE=$(jq --raw-output ".keyfile" $CONFIG_PATH)
CERTFILE=$(jq --raw-output ".certfile" $CONFIG_PATH)

sed -i "s/%%HOST%%/$HOST/g" /etc/nginx.conf
sed -i "s/%%DOMAIN%%/$DOMAIN/g" /etc/nginx.conf
sed -i "s/%%CERTFILE%%/$CERTFILE/g" /etc/nginx.conf
sed -i "s/%%KEYFILE%%/$KEYFILE/g" /etc/nginx.conf

exec nginx -c /etc/nginx.conf < /dev/null
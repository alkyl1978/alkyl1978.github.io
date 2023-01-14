#!/bin/sh
set -x
set -e
mkdir /root/.ssh/
echo $DEPLOY_KEY > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
npm install --production
npm run build
npm run deploy

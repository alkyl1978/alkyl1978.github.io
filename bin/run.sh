#!/bin/sh
set -x
set -e
mkdir /root/.ssh/
echo "$DEPLOY_KEY" > /root/.ssh/id_rsa

npm install --production
npm run build
#npm run deploy

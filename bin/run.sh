#!/bin/sh
set -x
set -e
npm install --only=prod
npm run clean
npm run build
#rm -rf node_modules scaffolds source themes package.json package-lock.json _config.yml db.json

#!/bin/sh
set -x
set -e
npm install
npm run build
#rm -rf node_modules scaffolds source themes package.json package-lock.json _config.yml db.json

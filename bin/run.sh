#!/bin/sh
set -x
set -e
npm install
npm run clean
npm run build
npm run deploy
#rm -rf node_modules scaffolds source themes package.json package-lock.json _config.yml db.json

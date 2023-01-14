#!/bin/sh
set -x
set -e
npm install --production
npm run build
npm run deploy

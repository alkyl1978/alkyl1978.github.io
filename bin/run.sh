#!/bin/sh
set -x
set -e
npm install --production
npm run clean
npm run build


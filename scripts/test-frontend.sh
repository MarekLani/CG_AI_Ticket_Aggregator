#!/usr/bin/env bash
set -euo pipefail
if [ ! -f src/frontend/package.json ]; then
  echo 'Frontend not initialized yet.'
  exit 0
fi
cd src/frontend
npm ci
npm run build
npm run test

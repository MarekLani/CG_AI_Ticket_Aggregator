#!/usr/bin/env bash
set -euo pipefail

if ! command -v func >/dev/null 2>&1; then
  npm install --global azure-functions-core-tools@4 --unsafe-perm true
fi

printf 'Dev Container toolchain:\n'
printf '  .NET: %s\n' "$(dotnet --version)"
printf '  Node: %s\n' "$(node --version)"
printf '  npm: %s\n' "$(npm --version)"
printf '  Azure Functions Core Tools: %s\n' "$(func --version)"
printf '  Docker: %s\n' "$(docker --version)"
printf '  Docker Compose: %s\n' "$(docker compose version --short)"

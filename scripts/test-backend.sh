#!/usr/bin/env bash
set -euo pipefail
if [ -f UnifiedWorkItems.sln ]; then
  dotnet restore UnifiedWorkItems.sln
  dotnet build UnifiedWorkItems.sln --no-restore --configuration Release
  dotnet test UnifiedWorkItems.sln --no-build --configuration Release
else
  project=$(find src/backend -name '*.csproj' -print -quit)
  test -n "$project" || { echo 'Backend not initialized yet.'; exit 0; }
  dotnet restore "$project"
  dotnet build "$project" --no-restore --configuration Release
  dotnet test --configuration Release
fi

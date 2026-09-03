#!/usr/bin/env bash
set -euo pipefail

solution=""
for candidate in UnifiedWorkItems.slnx UnifiedWorkItems.sln; do
  if [ -f "$candidate" ]; then
    solution="$candidate"
    break
  fi
done

if [ -n "$solution" ]; then
  dotnet restore "$solution"
  dotnet build "$solution" --no-restore --configuration Release
  dotnet test "$solution" --no-build --configuration Release
else
  project=$(find src/backend -name '*.csproj' -print -quit)
  test -n "$project" || { echo 'Backend not initialized yet.'; exit 0; }
  dotnet restore "$project"
  dotnet build "$project" --no-restore --configuration Release
  dotnet test "$project" --no-build --configuration Release
fi

#!/usr/bin/env bash
set -euo pipefail

required=(
  README.md
  AGENTS.md
  CONTRIBUTING.md
  docs/product/solution-overview.md
  docs/architecture/overview.md
  docs/ai/issue-authoring-prompt.md
  docs/ai/planning-agent-prompt.md
  docs/ai/implementation-agent-prompt.md
  docs/ai/review-agent-prompt.md
  docs/ai/remediation-plan-prompt.md
  docs/ai/task-levels.md
  .github/ISSUE_TEMPLATE/ai-assisted-task.yml
)

for f in "${required[@]}"; do
  test -f "$f" || { echo "Missing required file: $f"; exit 1; }
done

if grep -RInE '^(<<<<<<<|=======|>>>>>>>)' --exclude-dir=.git .; then
  echo "Merge conflict markers found."
  exit 1
fi

echo "Repository bootstrap validation passed."

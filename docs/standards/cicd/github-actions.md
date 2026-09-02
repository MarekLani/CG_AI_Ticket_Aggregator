# GitHub Actions standard

GitHub Actions is the CI/CD platform for this repository.

Delivery triggers, environments, and release strategy are defined in `docs/architecture/deployment.md`.

## Rules

- Keep workflows focused and easy to understand.
- Use repository scripts for build, test, and validation logic where practical instead of large inline shell blocks.
- Do not add workflow triggers that conflict with the delivery strategy.
- Request only the GitHub permissions required by each workflow or job.
- Never embed credentials or secrets in workflow files.
- Use GitHub environments and secrets for environment-specific deployment configuration when applicable.
- Do not introduce a new deployment mechanism or environment without approved scope.
- Avoid premature reusable workflows or composite actions.
- If substantial logic starts repeating across CI/CD workflows, flag it as a reuse opportunity and ask before extracting it.
- Do not weaken or bypass CI checks to make a pipeline pass.

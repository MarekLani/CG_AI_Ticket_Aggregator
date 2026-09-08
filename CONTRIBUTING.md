# Contributing

## Work starts from a GitHub Issue

Do not start non-trivial work from an untracked chat instruction. Convert the requirement into a reviewed GitHub Issue first.

## Git strategy

Repository policy requires `main` to be the protected integration branch. Work happens on short-lived branches created from the current `main`; no long-lived `develop` or release branches are planned.

Preferred patterns:
- `feature/<issue>-short-description`
- `fix/<issue>-short-description`
- `docs/<issue>-short-description`

Open a pull request back to `main` and keep the branch scoped to one issue or one coherent part of a larger issue. CI/CD trigger and environment rules are defined in `docs/architecture/deployment.md`.

## Pull requests

Open a draft PR for standard/high-risk work. When an implementation agent creates the PR, it does so only after implementation and relevant validation have completed successfully and only when the task-specific launch prompt explicitly permits commit, push, and draft-PR creation. The PR must reference the issue, identify the approved implementation plan when required, list validation performed and call out remaining risks.

An implementation agent must not mark the PR ready for review, approve it, or merge it. Human review and human merge approval are required.

## Commits

Use concise imperative messages. Keep commits reviewable and avoid mixing unrelated refactors with feature work.

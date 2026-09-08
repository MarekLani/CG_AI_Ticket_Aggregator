# Prompting Guidance for Development Agents

Task-specific launch prompts should be short. They should supply only information that is not already available reliably from the repository or GitHub.

## Include when relevant

- issue or PR number;
- work mode;
- task level already confirmed by a human;
- branch mode, working branch, and base branch;
- approved implementation-plan or remediation-plan version;
- constraints or decisions that have not yet been recorded elsewhere;
- explicitly allowed Git operations, such as commit or push;
- explicitly allowed GitHub write operations, such as creating a draft pull request;
- the exact expected output of the current run.

## Git and GitHub permissions are explicit

Do not infer write permission from available credentials, repository access, a checked-out branch, or the presence of GitHub CLI.

For implementation runs, permissions are deny-by-default unless the launch prompt explicitly grants them. If commit, push, or draft-PR creation is not explicitly allowed, the implementation agent must not perform that operation.

An implementation agent may create a pull request only as a draft, only after implementation and relevant validation have completed successfully, and only when the launch prompt explicitly permits commit, push, and draft-PR creation. Otherwise it prepares the proposed pull-request body without writing it to GitHub.

## Do not duplicate durable context

Do not paste entire engineering standards, architecture documents, or product rules into ad-hoc prompts.

Store durable rules in the appropriate authoritative source:

- `AGENTS.md` for agent working rules and navigation;
- `docs/product/` for durable product context;
- `docs/standards/` for engineering rules;
- `docs/architecture/` for the current architecture;
- `docs/adr/` for durable architectural decisions and approved exceptions.

A launch prompt must never silently override an engineering standard, an ADR, or an approved plan.

## Prefer explicit operational wording

Good:

> Implement issue #42 using the latest approved `Implementation Plan`. Branch mode: create and use `feature/42-rm-list` from `main`. Commit and push are allowed. Create a draft pull request after successful validation. Do not mark the PR ready for review and do not merge it.

Avoid vague instructions such as:

> Fix the issue and improve anything else you see.

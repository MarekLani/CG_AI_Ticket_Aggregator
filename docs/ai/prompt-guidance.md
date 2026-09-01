# Prompting Guidance for Development Agents

Task-specific launch prompts should be short. They should supply only information that is not already available reliably from the repository or GitHub.

## Include when relevant

- issue or PR number;
- work mode;
- task level already confirmed by a human;
- working branch and base branch;
- approved implementation-plan or remediation-plan version;
- constraints or decisions that have not yet been recorded elsewhere;
- whether the agent may write to GitHub or should only prepare output;
- the exact expected output of the current run.

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

> Implement issue #42 using the latest approved `Implementation Plan`. Work on branch `feature/42-rm-list`. Do not modify infrastructure. Return an implementation report but do not merge the PR.

Avoid vague instructions such as:

> Fix the issue and improve anything else you see.

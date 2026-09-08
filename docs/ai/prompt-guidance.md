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

For implementation runs, permissions are deny-by-default unless the launch prompt explicitly grants them. For initial implementation, commit, push, and draft-PR creation form one publication permission set: unless all three are explicitly allowed, the implementation agent performs none of those operations.

An implementation agent may create a pull request only as a draft, only after implementation and relevant validation have completed successfully, and only when the launch prompt explicitly permits the complete publication permission set. Otherwise it prepares the proposed pull-request body without writing it to GitHub.

For work on an existing pull request, such as simple accepted review fixes or approved remediation, the launch prompt should identify the PR and existing branch explicitly. Commit and push remain deny-by-default, and the agent must not create a second pull request.

## Do not duplicate durable context

Do not paste entire engineering standards, architecture documents, issue bodies, approved plans, or product rules into ad-hoc prompts when the agent can read them from their authoritative source.

Store durable rules in the appropriate authoritative source:

- `AGENTS.md` for agent working rules and navigation;
- `docs/product/` for durable product context;
- `docs/standards/` for engineering rules;
- `docs/architecture/` for the current architecture;
- `docs/adr/` for durable architectural decisions and approved exceptions.

A launch prompt must never silently override an engineering standard, an ADR, or an approved plan.

## Human-only launch-prompt examples

Copy-ready launch-prompt examples are maintained in `docs/ai/examples/launch-prompt-cookbook.md` for human developers.

That directory is deliberately excluded from normal agent context by `AGENTS.md`. Agents must not read or search the cookbook during normal issue authoring, planning, implementation, review, or remediation work unless the current task explicitly asks them to create, review, update, or use those examples.

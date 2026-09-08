# Planning Agent Prompt

You are preparing a technical implementation plan for an approved GitHub issue. Do not implement code.

The plan must be detailed enough for a developer or implementation agent to execute, but no broader than necessary to satisfy the approved issue.

## Before planning

Read:

- `AGENTS.md`;
- `docs/product/solution-overview.md`;
- the complete issue body, acceptance criteria, labels, and relevant comments;
- relevant standards, architecture documentation, and ADRs;
- existing code, tests, patterns, and dependencies in the affected areas;
- `docs/ai/implementation-plan-template.md`.

## Readiness check

Do not pretend an issue is ready when it is not.

If the issue lacks a clear scope or testable acceptance criteria, or if the implementation requires an unapproved business or architectural decision, record the gap as an open question. Do not invent the missing decision.

## Planning rules

- Keep the scope as small as reasonably possible.
- Identify the modules, components, or files that are likely to change.
- Describe the implementation steps in a practical order.
- Identify API, data, configuration, integration, container, and infrastructure impact where relevant.
- Identify the relevant engineering standards and ADRs explicitly.
- Specify the tests and repeatable validation commands that should be run.
- For infrastructure, data, security, or migration changes, include meaningful risks and rollback or recovery considerations.
- Recommend an ADR when the change introduces a durable architectural decision.
- Call out assumptions rather than treating them as facts.

## Required output

Use `docs/ai/implementation-plan-template.md`.

Set the plan status to `Draft` and return the plan for review by the responsible developer. Do not present it as approved.

At the end, provide one short task-specific launch prompt that can be used with `docs/ai/implementation-agent-prompt.md` after the plan has been approved. Include the issue, work mode, approved plan version, branch mode, working branch, base branch, and any Git or GitHub write permissions explicitly supplied by the responsible developer. Do not grant commit, push, or GitHub write permissions unless the responsible developer explicitly provided them.

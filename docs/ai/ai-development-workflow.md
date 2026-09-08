# AI-Assisted Development Workflow

## 1. Purpose

This document defines the repository's default strategy for using AI agents during software development.

The objective is to improve development speed and quality without weakening human accountability. AI may assist with issue authoring, planning, implementation, testing, review, and documentation. A named human developer remains responsible for every change.

## 2. Core principles

1. Every GitHub issue has a human owner.
2. GitHub Issues are the authoritative place where the requested outcome of development work is defined.
3. Use the simplest workflow that provides enough confidence for the risk and complexity of the task.
4. Small, low-risk tasks do not require a separate formal implementation plan by default.
5. Standard and high-risk tasks require a human-approved implementation plan before implementation begins.
6. When a plan is required, the latest approved canonical `Implementation Plan` issue comment is the authoritative implementation approach.
7. Temporary files and chat history are working context, not durable sources of truth.
8. Agents work from explicit instructions and authoritative repository/GitHub context, not from vague intent.
9. AI review complements human review; it does not replace it.
10. AI-generated code must pass the same tests, validation, review, and security controls as human-written code.
11. Agents must not receive secrets, production credentials, private keys, or production/customer data.
12. Agents must not invent missing business rules.
13. When scope or authoritative sources are ambiguous or conflicting, the agent stops and requests a human decision.
14. Review findings are assessed by a human before remediation work is assigned.
15. A separate remediation plan is used only for accepted findings that require non-trivial work.
16. Humans approve product scope, implementation plans, architectural exceptions, security-sensitive behavior, accepted risk, pull requests, and merges.

## 3. Workflow by task level

See `docs/ai/task-levels.md` for the detailed classification.

### Small / low-risk

Typical flow:

```text
Approved GitHub issue
  -> implementation
  -> tests / validation
  -> draft pull request
  -> human review
  -> merge
```

A separate implementation plan and AI review are optional unless a human decides otherwise.

### Standard

Typical flow:

```text
Approved GitHub issue
  -> planning agent prepares a draft plan
  -> responsible developer reviews and approves the plan
  -> implementation
  -> tests / validation
  -> draft pull request
  -> CI
  -> AI review when it provides useful additional confidence
  -> human assessment of findings
  -> accepted fixes
  -> human review
  -> merge
```

### High-risk / architectural

Typical flow:

```text
Approved GitHub issue
  -> planning agent prepares a full plan
  -> responsible developer approves the plan
  -> ADR when the change introduces a durable architectural decision
  -> implementation
  -> tests / validation
  -> draft pull request
  -> CI
  -> mandatory AI review
  -> human assessment of review findings
  -> remediation plan for accepted non-trivial findings, when needed
  -> implementation of approved remediation
  -> human review
  -> merge
```

Infrastructure and Terraform changes are high-risk by default unless a human explicitly classifies a narrowly scoped change otherwise.

## 4. Human responsibility and automation boundaries

Automate mechanical work, not accountability.

AI and automation may assist with:

- turning rough notes into an issue draft;
- drafting implementation plans;
- creating branches;
- implementing approved scope;
- generating or updating tests;
- preparing pull-request descriptions;
- creating draft pull requests when explicitly permitted;
- running build, test, lint, and validation commands;
- reviewing pull requests;
- drafting remediation plans;
- implementing approved remediation;
- summarizing implementation and validation evidence.

Humans retain responsibility for:

- approving product and business scope;
- confirming task level and risk;
- approving implementation plans;
- accepting, rejecting, deferring, or risk-accepting review findings;
- approving security-sensitive behavior;
- accepting risk;
- approving pull requests and merges.

## 5. Authoritative sources and repository context

Different sources answer different questions:

- `docs/product/solution-overview.md` — why the solution exists, who it serves, and its durable boundaries;
- GitHub issue and acceptance criteria — what a specific change must achieve;
- canonical `Implementation Plan` issue comment — how an approved standard/high-risk change will be implemented;
- `docs/standards/` — durable engineering rules;
- `docs/architecture/` — current architecture and data flows;
- `docs/adr/` — durable architectural decisions and approved exceptions;
- `AGENTS.md` — how agents must work in this repository and where to find relevant context;
- code and configuration — actual implemented behavior;
- tests, scripts, and CI — executable validation;
- pull request — what actually changed and how it was validated.

If authoritative sources conflict, an agent must not resolve the conflict silently.

## 6. Standard AI resources

The repository keeps stable prompts separate from task-specific launch prompts and human-only examples:

```text
docs/ai/
├─ ai-development-workflow.md
├─ task-levels.md
├─ prompt-guidance.md
├─ issue-authoring-prompt.md
├─ implementation-plan-template.md
├─ implementation-plan-lifecycle.md
├─ planning-agent-prompt.md
├─ implementation-agent-prompt.md
├─ review-agent-prompt.md
├─ review-checklist.md
├─ remediation-plan-template.md
├─ remediation-plan-prompt.md
├─ accepted-risk-log.md
└─ examples/
   └─ launch-prompt-cookbook.md   # human-only; excluded from normal agent context
```

Stable prompts define reusable agent behavior. A task-specific launch prompt identifies the issue or PR, approved plan/version, work mode, branch mode, working branch, base branch, and any explicit Git or GitHub write permissions for that run.

The examples directory exists only to help human developers compose those launch prompts. `AGENTS.md` explicitly excludes it from normal agent read/search context so examples do not consume tokens during normal execution.

## 7. Issue authoring

Use `.github/ISSUE_TEMPLATE/ai-assisted-task.yml` as the canonical structure for AI-assisted development tasks.

Recommended flow:

```text
Rough requirement
  -> Issue Authoring Agent prepares a draft
  -> human reviews goal, acceptance criteria, out-of-scope boundaries, and risks
  -> developer confirms task level and planning requirement
  -> issue is created or updated in GitHub
  -> task is ready for planning or direct implementation
```

Use `docs/ai/issue-authoring-prompt.md` for the agent's stable instructions.

The issue authoring agent must make uncertainty visible and must not invent business behavior.

## 8. Implementation planning

Standard and high-risk tasks use a canonical issue comment named `Implementation Plan`.

The plan lifecycle is defined in `docs/ai/implementation-plan-lifecycle.md` and the reusable format is in `docs/ai/implementation-plan-template.md`.

The planning agent uses `docs/ai/planning-agent-prompt.md`.

A plan starts as `Draft`. Implementation may begin only after the responsible developer changes it to `Approved`.

When a plan changes materially, update the canonical comment, increment the version, and record the change. Do not rely on an old chat message or local draft.

## 9. Implementation

The implementation agent uses `docs/ai/implementation-agent-prompt.md` and is invoked by the responsible developer with a task-specific launch prompt after the issue or reviewed PR findings are ready for implementation.

The launch prompt selects exactly one supported mode:

- direct implementation of a small issue;
- implementation of an approved `Implementation Plan`;
- implementation of simple human-approved review fixes that do not require a separate remediation plan;
- implementation of an approved `Remediation Plan`.

For standard and high-risk work, the launch prompt must identify the approved canonical `Implementation Plan` version. For simple review fixes, it must identify the existing PR and canonical `Review Findings Assessment`. For remediation, it must identify the existing PR and approved canonical `Remediation Plan`.

The launch prompt also defines the operational context for the run:

- branch mode;
- working branch;
- base branch;
- explicitly allowed Git write operations, such as commit or push;
- explicitly allowed GitHub write operations, such as creating a draft pull request.

Git and GitHub write permissions are deny-by-default. The agent must not infer permission from available credentials, repository access, a checked-out branch, or installed tooling.

The implementation agent must run relevant validation and return factual evidence of what was executed. For initial implementation, it may create a pull request only after implementation and relevant validation have completed successfully and only when the launch prompt explicitly permits commit, push, and creation of a draft pull request.

If those initial-publication permissions are not granted, the agent must not commit, push, or write to GitHub. It performs the permitted local work and returns an implementation report together with a proposed pull-request body based on `.github/PULL_REQUEST_TEMPLATE.md`.

When the agent is authorized to create a pull request, it creates a **draft** pull request only. It must never mark the PR ready for review, approve it, or merge it.

For simple accepted review fixes and approved remediation, the agent works on the existing PR branch and never creates a second pull request. Commit and push are performed only when explicitly permitted by the launch prompt.

## 10. Pull requests

Every pull request should:

- link the GitHub issue;
- identify the task level;
- reference the approved plan/version when one was required;
- summarize what changed;
- list validation that was actually performed;
- identify AI assistance used;
- record remaining findings, deferred work, and accepted risks;
- state whether documentation or ADRs changed.

Use `.github/PULL_REQUEST_TEMPLATE.md`.

When an implementation agent creates the PR, it does so only after successful implementation and relevant validation, only with explicit commit, push, and draft-PR permissions, and always as a draft. For standard and high-risk work, the PR must reference the approved canonical `Implementation Plan` and its version.

The implementation agent must not mark a PR ready for review, approve it, or merge it. Human review and human merge approval remain mandatory.

## 11. AI review

Use `docs/ai/review-agent-prompt.md` and `docs/ai/review-checklist.md`.

AI review is:

- optional for small low-risk work;
- recommended for standard work when the additional review is useful;
- mandatory for high-risk or architectural work.

Review findings are suggestions until a human assesses them.

The review agent must distinguish Blocking, Recommended, and Optional findings and should cite the relevant rule or ADR when identifying a violation.

## 12. Human assessment of review findings

The responsible developer records decisions in one canonical PR comment named `Review Findings Assessment`.

Each finding should be classified as one of:

- **Accepted** — valid and will be addressed;
- **Rejected** — not valid, relevant, or proportionate;
- **Deferred** — valid, but will be handled outside the current PR;
- **Risk accepted** — valid, but intentionally not fixed; the reason must be documented;
- **Needs clarification** — a product or technical decision is still required.

Only human-assessed findings may become remediation work.

## 13. Remediation planning

Simple accepted findings can be fixed directly in the current PR using the implementation agent's simple-review-fix mode when a human has explicitly accepted them.

Use a separate remediation plan only when accepted findings require non-trivial, bounded work in the same PR.

The canonical PR comment is named `Remediation Plan`.

Use:

- `docs/ai/remediation-plan-prompt.md`;
- `docs/ai/remediation-plan-template.md`.

The remediation plan starts as `Draft` and must be approved by the responsible developer before implementation begins.

If a finding expands the original product scope, changes a public contract, requires a new architectural decision, or is independently sizeable, create a separate issue instead of hiding it inside remediation.

## 14. Prompting strategy

Use `docs/ai/prompt-guidance.md`.

Task-specific launch prompts should not duplicate repository documentation. They should identify only the concrete run context that the agent cannot reliably infer from authoritative sources.

Human developers can use the copy-ready examples in `docs/ai/examples/launch-prompt-cookbook.md`. The cookbook is intentionally excluded from normal agent context; the human should copy the appropriate example and send the resulting task-specific launch prompt rather than asking the agent to load the cookbook.

## 15. Git and GitHub working conventions

GitHub CLI is a useful standard tool for developers and agents that are explicitly allowed to access GitHub.

Examples:

```bash
gh issue view 42 --comments

gh issue develop 42 \
  --name feature/42-rm-list \
  --base main \
  --checkout

gh pr create \
  --draft \
  --base main \
  --head feature/42-rm-list \
  --title "Issue #42: Add RM work-item list"

gh pr diff 57 --patch
```

The availability of GitHub CLI, repository credentials, or write access does not grant an agent permission to perform Git or GitHub writes. Commit, push, and draft-PR creation must be explicitly allowed by the task-specific launch prompt.

When an implementation agent is allowed to create a pull request, it must use `--draft` or the equivalent API behavior. Agents must not mark pull requests ready for review, approve them, or merge them. This repository assumes those decisions remain human.

## 16. Security and data handling

Agents must never be given:

- production secrets or credentials;
- private keys;
- production/customer data;
- unrestricted access to protected production environments.

Use synthetic or anonymized data for development and testing.

Changes involving authentication, authorization, customer data, infrastructure, public contracts, migrations, or other security-sensitive areas should normally use the high-risk workflow.

## 17. Durable decisions vs. temporary working context

Do not treat chat history, local scratch files, or generated agent output as durable project truth.

When a decision has lasting value, move it to the appropriate authoritative source:

- product behavior -> product documentation or issue acceptance criteria;
- implementation approach for one task -> canonical `Implementation Plan`;
- reusable technical rule -> engineering standard;
- current architecture -> architecture documentation;
- durable architectural decision or approved exception -> ADR;
- accepted long-lived engineering risk -> `docs/ai/accepted-risk-log.md` when appropriate.

## 18. Cost-effective use of AI

Do not use an AI agent simply because one is available.

Use AI where it meaningfully reduces effort, improves coverage, or reduces risk. Small tasks should remain lightweight. High-risk tasks should receive more planning and review because the cost of an undetected mistake is greater.

The objective is not maximum agent usage. The objective is a development process that is faster, reviewable, testable, and appropriately controlled.

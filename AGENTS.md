# Agent Instructions

## Repository purpose

This repository contains **Unified Work Items**, an internal read-oriented web application that aggregates work items from RM/helpdesk, Microsoft Planner, and GitHub Issues.

Read `docs/product/solution-overview.md` before planning, implementing, or reviewing changes.

## Human responsibility

Every issue has a human owner. Agents may support issue authoring, planning, implementation, testing, review, and documentation, but humans retain responsibility for product scope, business decisions, risk acceptance, plan approval, pull-request approval, and merge decisions.

## Required context

Before starting work, read:

1. this file;
2. `docs/product/solution-overview.md`;
3. the relevant GitHub issue and its acceptance criteria;
4. the latest human-approved canonical `Implementation Plan` issue comment when a plan is required;
5. standards relevant to the affected area;
6. relevant files under `docs/architecture/` and `docs/adr/`.

When working in a directory that contains a more specific `AGENTS.md`, read and follow it in addition to this root file.

Area-specific standards:

- all code: `docs/standards/coding/general.md`
- backend core: `docs/standards/coding/dotnet.md`, `docs/standards/coding/azure-functions.md`, `docs/standards/architecture/layering.md`
- HTTP/API changes: `docs/standards/api/http-api.md`
- frontend core: `docs/standards/coding/frontend.md`
- user-facing layout, interaction, or visual behavior: `docs/standards/ui/design-system.md`
- accessibility-sensitive UI changes: `docs/standards/ui/accessibility.md`
- integrations: `docs/standards/architecture/integration.md`
- persistence/EF Core changes: `docs/adr/0002-staged-application-persistence.md`
- application changes affecting hosting, networking, identity, configuration, or other platform needs: `docs/architecture/infrastructure-requirements.md`
- tests: `docs/standards/testing/general.md` plus the relevant area-specific test standard
- containers: `docs/standards/infrastructure/containers.md`
- security-sensitive changes: `docs/standards/security.md`
- logging, telemetry, and metrics: `docs/standards/observability.md`

Load only the standards relevant to the task. Do not preload unrelated standards merely because they exist in the repository.

## General rules

- Make minimal, targeted changes.
- Implement only the approved scope.
- Do not invent business rules, status mappings, priorities, defaults, or connector semantics.
- Prefer existing patterns and dependencies.
- Do not perform unrelated refactoring.
- Do not change public API contracts, persistence models, deployment topology, or infrastructure requirements without explicit approved scope.
- This repository does not own Terraform or Azure resource implementation. Do not add or invent VNets, subnets, CIDR ranges, routes, private endpoints, DNS zones, firewall rules, Terraform state, Azure RBAC topology, or similar infrastructure details here.
- When an application change creates a new platform requirement, update `docs/architecture/infrastructure-requirements.md` when appropriate and coordinate the corresponding change in the dedicated infrastructure repository.
- Add or update tests for changed behavior.
- Do not weaken validation, tests, security checks, or CI merely to make a change pass.
- Never commit secrets, credentials, tokens, private keys, or production/customer data.
- Use synthetic or anonymized test data only.

## RM-specific rules

- `I_POZIAD` is the unique external identifier of an RM requirement.
- The first RM integration reads from `VW_RM_POZIAD`.
- Do not infer the meaning of similarly named RM status fields from column names alone.
- The initial field mapping is documented in `docs/architecture/data-flows.md`.
- Add additional RM fields only when an issue defines a concrete use case and the field semantics are known.

## Stop conditions

Stop and ask the responsible developer when:

- product or business behavior is ambiguous;
- a required mapping or source-system semantic is not explicitly documented;
- the issue or plan conflicts with a standard or ADR;
- implementation requires a new architectural choice that has not been approved;
- a secret or protected environment is required;
- required tests or validation cannot be executed;
- the scope expands materially beyond the approved issue or plan.

## Validation

Use repeatable scripts under `scripts/` where available. Do not report successful validation unless the command was actually run successfully.

## AI-assisted workflow

Use the stable prompts and templates under `docs/ai/`.

Use `docs/ai/task-levels.md` to understand the expected process. A human developer must confirm the task level and planning requirement before implementation.

Canonical GitHub comment names used by the workflow:

- `Implementation Plan` — approved implementation approach for an issue;
- `Review Findings Assessment` — human decisions about review findings in a PR;
- `Remediation Plan` — approved non-trivial remediation work for the current PR.

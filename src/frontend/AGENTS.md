# Frontend Agent Instructions

These instructions apply to work under `src/frontend/` and extend the root `AGENTS.md`.

## Always load

Before planning, implementing, or reviewing frontend changes, read:

- `/AGENTS.md`;
- `/docs/product/solution-overview.md`;
- `/docs/standards/coding/frontend.md`;
- the relevant GitHub issue and approved `Implementation Plan` when one is required.

Also read relevant architecture documents and ADRs for the affected feature.

## Load additional context only when relevant

- layout, interaction, or visual behavior: `/docs/standards/ui/design-system.md`;
- accessibility-sensitive UI behavior: `/docs/standards/ui/accessibility.md`;
- API contract or HTTP integration: `/docs/standards/api/http-api.md`;
- tests: `/docs/standards/testing/general.md` plus the relevant frontend test standard if present;
- security-sensitive behavior: `/docs/standards/security/general.md`;
- identity, authentication, or authorization: `/docs/standards/security/general.md` and `/docs/standards/security/identity-and-access.md`;
- logging, tracing, telemetry, or diagnostics: `/docs/adr/0004-use-application-insights-for-observability.md`, `/docs/standards/observability/general.md`, and `/docs/standards/observability/frontend.md`.

Do not load unrelated standards merely because the change is in the frontend.

## Core frontend constraints

- Use the frontend stack defined in `/docs/standards/coding/frontend.md`.
- Prefer existing Material UI components over custom equivalents.
- Use MUI X Data Grid Community for data-heavy tabular views.
- Use TanStack Query for server state.
- Keep API access outside presentation components.
- Keep TypeScript strict and avoid `any` unless explicitly justified at an external boundary.
- Make minimal, issue-scoped changes and avoid unrelated refactoring.

## Stop conditions

Stop and ask the responsible developer when:

- required API behavior is unclear;
- a new major frontend dependency appears necessary;
- the task requires MUI X Pro or Premium functionality;
- a new global state-management library appears necessary;
- a requirement conflicts with the frontend standards or an ADR;
- authorization or other security-sensitive behavior is ambiguous;
- the implementation requires a significant architectural decision that has not been approved.

## Validation

Run the repository-provided frontend validation commands applicable to the change and report the commands actually executed and their results.

For visual or interaction changes, also verify the affected flow in a browser.

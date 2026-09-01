# ADR 0001: Use one repository for application and infrastructure

- Status: Accepted
- Date: 2026-08-26

## Context

The project is also used as an end-to-end engineering and AI-assisted development training scenario. Backend, frontend, infrastructure, CI/CD and their shared documentation benefit from one reviewable workflow.

## Decision

Use one Git repository containing backend, frontend, infrastructure definitions, engineering standards and AI workflow artifacts.

## Consequences

- cross-cutting changes can be reviewed in one PR when genuinely coupled;
- CODEOWNERS/path-based CI can still assign responsibility by area;
- agents can access one coherent set of standards and architecture context;
- PRs must avoid unrelated cross-area changes merely because all code is in one repository.

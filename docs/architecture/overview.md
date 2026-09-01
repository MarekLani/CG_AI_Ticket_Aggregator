# Architecture overview

## Current bootstrap

Repository currently contains engineering context and AI workflow wiring. Application components are intentionally introduced incrementally through issues.

## Target logical architecture

```text
RM/helpdesk ─────┐
Planner ─────────┼──> Source adapters/connectors ──> Unified application model ──> HTTP API ──> React UI
GitHub Issues ───┘
```

A persistence/cache layer and background synchronization may be added when justified by requirements. They are not assumed as mandatory for the first RM vertical slice.

## Architectural principles

- source-specific logic stays behind connector boundaries;
- source systems remain systems of record;
- UI consumes a source-neutral API model;
- source-specific values are preserved where normalization would lose information;
- no business mapping is inferred from column/field names alone;
- external dependencies are wrapped and testable;
- secrets are supplied by runtime/environment mechanisms, never committed;
- deployment is containerized and targets Azure;
- infrastructure is defined with Terraform once the target Azure topology is explicitly approved.

## Open architectural decisions

The following require explicit issue/ADR decisions before implementation:
- exact Azure compute service;
- whether frontend and backend share one or multiple deployable containers;
- persistence/cache requirement and technology;
- background synchronization topology and cadence;
- authentication/authorization model;
- connectivity from Azure to RM source;
- secret storage/runtime identity design.

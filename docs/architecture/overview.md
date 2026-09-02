# Architecture overview

## Current bootstrap

Repository currently contains engineering context and AI workflow wiring. Application components are intentionally introduced incrementally through issues.

## Target logical architecture

```text
Helpdesk ────────┐
Planner ─────────┼──> Source adapters/connectors ──> Unified application model ──> HTTP API ──> React UI
GitHub Issues ───┘
```

A persistence/cache layer may be added when justified. It is not required for the first helpdesk vertical slice. See ADR 0002.

Infrastructure implementation lives in a separate repository as decided in ADR 0001.

## Architectural principles

- source systems remain systems of record;
- source-specific logic stays behind connector boundaries;
- UI consumes a source-neutral API model;
- external dependencies are wrapped and testable;
- secrets are never committed;
- agents must not invent business mappings or source-system semantics.

## Open decisions

- exact persistence use case and synchronization model when persistence is introduced;
- background synchronization cadence;
- authentication/authorization model;
- application requirements for connectivity to the helpdesk source.

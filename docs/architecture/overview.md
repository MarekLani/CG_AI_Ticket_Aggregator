# Architecture overview

## Current bootstrap

Repository currently contains engineering context and AI workflow wiring. Application components are intentionally introduced incrementally through issues.

## Target logical architecture

```text
RM/helpdesk ─────┐
Planner ─────────┼──> Source adapters/connectors ──> Unified application model ──> HTTP API ──> React UI
GitHub Issues ───┘
```

A persistence/cache layer and background synchronization may be added when justified by requirements. They are not mandatory for the first RM vertical slice. The staged persistence decision and preliminary PostgreSQL/EF Core direction are recorded in `docs/adr/0002-staged-application-persistence.md`.

## Repository boundary

Application and infrastructure responsibilities are split between separate repositories as defined by `docs/adr/0001-separate-application-and-infrastructure-repositories.md`.

This repository defines application behavior and the platform capabilities it requires. The dedicated infrastructure repository owns Azure/Terraform implementation. See `docs/architecture/infrastructure-requirements.md` for the application-side contract.

## Architectural principles

- source-specific logic stays behind connector boundaries;
- source systems remain systems of record;
- UI consumes a source-neutral API model;
- source-specific values are preserved where normalization would lose information;
- no business mapping is inferred from column/field names alone;
- external dependencies are wrapped and testable;
- secrets are supplied by runtime/environment mechanisms, never committed;
- backend runtime follows the approved Azure Functions/.NET baseline;
- application code expresses platform requirements without embedding Azure/Terraform resource topology;
- infrastructure implementation is coordinated through the dedicated infrastructure repository.

## Open architectural decisions

The following require explicit issue/ADR decisions before implementation where they affect application behavior or requirements:

- frontend hosting requirements that constrain the infrastructure choice;
- exact persistence use case, data model and synchronization topology when persistence is introduced;
- background synchronization cadence;
- authentication/authorization model;
- application requirements for connectivity to the RM source;
- application requirements for secret/configuration and runtime identity behavior.

Infrastructure-only choices such as VNet topology, CIDR allocation, private endpoints, DNS, Terraform state, Azure resource naming, and environment topology are owned by the infrastructure repository.
# ADR 0001: Use separate application and infrastructure repositories

- Status: Accepted
- Date: 2026-09-02

## Context

Unified Work Items is developed in an application repository, while Azure infrastructure is managed in a separate, already-established infrastructure repository.

Application and infrastructure changes have different lifecycles, permissions, review risks, and deployment concerns. Infrastructure decisions such as networking, private connectivity, DNS, Azure resource topology, RBAC, Terraform state, and shared platform services should not be mixed with application implementation guidance.

The project is also used for engineering and AI-assisted development training, so the boundary between application requirements and infrastructure implementation should be explicit and reviewable.

## Decision

Use separate repositories for application and infrastructure responsibilities.

The **application repository** owns:

- backend and frontend source code;
- application architecture and API contracts;
- application-owned database schema and EF Core migrations when persistence is introduced;
- container build and application runtime behavior;
- application tests and application CI;
- the infrastructure/runtime requirements that the application needs from its hosting platform.

The **infrastructure repository** owns:

- Terraform and Terraform state configuration;
- Azure resource provisioning and environment topology;
- VNets, subnets, routing, private endpoints, private DNS, firewall and connectivity configuration;
- Azure identity and RBAC infrastructure;
- Key Vault and other platform security resources;
- PostgreSQL server provisioning and platform configuration when persistence is introduced;
- shared monitoring/platform resources;
- infrastructure validation and deployment pipelines.

The application repository documents its platform needs in `docs/architecture/infrastructure-requirements.md`. It must not prescribe or duplicate infrastructure implementation details unless a cross-repository architectural decision explicitly requires them.

Changes that affect both repositories should be coordinated through linked issues or pull requests, while each repository remains independently reviewable and deployable.

## Consequences

- application agents work from application context and do not invent or modify cloud infrastructure implementation in this repository;
- Terraform and Azure infrastructure coding standards live in the infrastructure repository, not here;
- application changes that introduce new platform requirements must update the infrastructure requirements contract;
- infrastructure implementation may evolve without changing application code as long as the documented requirements remain satisfied;
- cross-repository dependencies must be explicit rather than assumed;
- container build/runtime standards may remain in this repository because the container image is an application artifact.
# ADR 0001: Separate application and infrastructure repositories

- Status: Accepted
- Date: 2026-09-02

## Context

Azure infrastructure for this application is managed in a separate infrastructure repository. Keeping infrastructure implementation out of the application repository gives each area a clear scope and review lifecycle.

## Decision

Use separate repositories:

- this repository owns application code, application architecture, application-owned database schema/migrations, build artifacts, and application runtime requirements;
- the infrastructure repository owns Terraform, Azure resources, networking, platform identity/RBAC, environment configuration, and infrastructure deployment.

Application platform requirements are recorded in `docs/architecture/infrastructure-requirements.md`. Infrastructure implementation details are not duplicated here.

## Consequences

- application agents must not implement Azure/Terraform infrastructure in this repository;
- changes affecting both repositories should use linked issues or pull requests;
- application and infrastructure can evolve independently as long as the documented requirements remain satisfied.

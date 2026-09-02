# Module boundaries

## Backend

Recommended logical boundaries once the backend is initialized:
- `Domain/Application`: source-neutral WorkItem model and use cases;
- `Api`: HTTP endpoints and transport DTOs;
- `Integrations.Rm`: RM access and mapping;
- later `Integrations.Planner` and `Integrations.GitHub`;
- optional `Infrastructure.Persistence` only after persistence is explicitly introduced.

The source-neutral application layer must not depend directly on Oracle/RM, Microsoft Graph or GitHub SDK-specific types.

## Frontend

The frontend consumes only the application HTTP API. It must not call RM, Planner or GitHub directly.

## Infrastructure boundary

This repository does not contain the Azure/Terraform infrastructure implementation.

Application code and architecture define required platform capabilities in `docs/architecture/infrastructure-requirements.md`. The dedicated infrastructure repository owns the Azure resources, networking, Terraform, identity/RBAC infrastructure, and environment topology used to satisfy those requirements.

Application code must not provision cloud resources at runtime.
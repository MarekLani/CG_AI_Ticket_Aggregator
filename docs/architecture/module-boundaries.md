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

## Infrastructure

Terraform under `infrastructure/terraform/` owns Azure resources for this application once introduced. Application code must not provision cloud resources at runtime.

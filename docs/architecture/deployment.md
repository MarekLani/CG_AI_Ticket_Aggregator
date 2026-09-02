# Deployment architecture

## Repository boundary

This repository owns application build, validation, packaging, and application deployment behavior.

Azure resource provisioning, networking, environment topology, Terraform, Terraform state, and infrastructure deployment pipelines are owned by the dedicated infrastructure repository. The application-side platform contract is documented in `docs/architecture/infrastructure-requirements.md`.

## Direction

The application targets Azure and is introduced incrementally through the training/implementation flow.

The backend baseline is Azure Functions v4 with .NET 10 isolated worker. The frontend is built as a React/Vite application. Exact Azure hosting-plan and frontend-hosting choices remain infrastructure/deployment decisions unless an application requirement makes a specific capability necessary.

Container build/runtime guidance remains in this repository when it concerns an application artifact. Azure hosting infrastructure for that artifact belongs in the infrastructure repository.

## Delivery progression

1. local developer execution;
2. application build and automated tests in this repository;
3. first intentionally simple deployment path against infrastructure prepared for the application;
4. application CI/CD for repeatable artifact build and deployment;
5. infrastructure changes implemented and reviewed independently in the infrastructure repository;
6. coordinated application/infrastructure releases when a change affects both sides.

Application deployment workflows must not create or mutate Terraform-managed infrastructure unless that ownership model is explicitly changed by an approved architecture decision.

## Cross-repository coordination

When an application change requires new hosting, networking, identity, secret-management, persistence, or observability capabilities:

- update `docs/architecture/infrastructure-requirements.md` when the requirement is durable;
- create or link the corresponding infrastructure issue/PR;
- keep the application PR focused on application behavior;
- do not copy Terraform or Azure resource definitions into this repository.
# Deployment architecture

This repository owns application build, validation, packaging, and application deployment workflows.

Azure resource provisioning, networking, Terraform, and infrastructure deployment are owned by the separate infrastructure repository. See ADR 0001.

## Direction

- Backend: Azure Functions v4 / .NET 10 isolated worker.
- Frontend: React/Vite build served over HTTPS.
- Exact Azure hosting and networking choices remain infrastructure decisions unless the application requires a specific capability.

Application platform needs are recorded in `docs/architecture/infrastructure-requirements.md`.

# ADR 0006: Use a VS Code Dev Container for supported local development

- Status: Accepted
- Date: 2026-09-02

## Context

The application combines .NET/Azure Functions and React/Vite tooling and will later require containerized development dependencies such as PostgreSQL. A repository-owned development environment reduces workstation-specific setup and makes the workshop/training and normal development workflow reproducible.

## Decision

Use a VS Code Dev Container as the repository-supported local development baseline.

- the Dev Container provides the project toolchain baseline: .NET 10, Node.js 22, Azure Functions Core Tools v4, Git, and Docker/Compose access;
- reuse the host Docker engine from inside the Dev Container so local auxiliary containers and Testcontainers can run without a nested Docker daemon;
- reserve local ports `5173` for the Vite frontend and `7071` for the Azure Functions backend;
- application services run as development processes in the Dev Container; auxiliary infrastructure runs in separate containers;
- PostgreSQL is not introduced until ADR 0002 permits application persistence. When required, it runs as a separate local container/service rather than being installed into the development container;
- the Dev Container is distinct from application/runtime container images governed by `docs/standards/infrastructure/containers.md`;
- host-native development may still work, but the Dev Container is the documented and supported reproducible baseline.

Implementation rules are defined in `docs/standards/development/dev-container.md`.

## Not decided here

- exact future PostgreSQL Compose/Testcontainers topology;
- automatic simultaneous startup of frontend and backend;
- debugger/task/launch configuration details;
- Codespaces support.

## Consequences

- developers need VS Code with Dev Containers support and a compatible local Docker engine;
- the repository owns and updates the local toolchain baseline instead of relying on undocumented host installations;
- future local services can be added as containers without changing the developer toolchain model;
- because the Dev Container reuses the host Docker daemon, it is not a security sandbox for untrusted repository code.

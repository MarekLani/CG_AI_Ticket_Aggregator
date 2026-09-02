# ADR 0006: Use a Compose-backed VS Code Dev Container for supported local development

- Status: Accepted
- Date: 2026-09-02

## Context

The application combines .NET/Azure Functions and React/Vite tooling and will later require containerized development dependencies such as PostgreSQL. A repository-owned development environment reduces workstation-specific setup and makes the workshop/training and normal development workflow reproducible.

The local environment also needs a clear separation between the developer workspace, stable infrastructure dependencies used during interactive development, and ephemeral containers created by automated tests.

## Decision

Use a Docker Compose-backed VS Code Dev Container as the repository-supported local development baseline.

- VS Code attaches to a dedicated `workspace` container that provides .NET 10, Node.js 22, Azure Functions Core Tools v4, Git, and Docker/Compose access;
- frontend and backend development processes run inside that workspace container rather than in separate development containers;
- Docker Compose is the declarative orchestration model for the workspace and stable local infrastructure dependencies;
- stable dependencies such as PostgreSQL, and optional source-system development databases when explicitly justified, run as sibling Compose services rather than being installed into the workspace container;
- reuse the host Docker engine from inside the workspace through Docker-outside-of-Docker; do not run a nested Docker daemon inside the workspace;
- Testcontainers uses the same host Docker engine to create ephemeral test-only sibling containers independently of the stable Compose services;
- reserve local ports `5173` for the Vite frontend and `7071` for the Azure Functions backend;
- PostgreSQL is not introduced until ADR 0002 permits application persistence. When required for interactive development, it is added as a separate Compose service;
- optional local source-system databases such as Oracle are not part of the default environment unless an approved integration/testing use case requires them; use a profile or equivalent explicit opt-in when appropriate;
- the Dev Container is distinct from application/runtime container images governed by `docs/standards/infrastructure/containers.md`;
- host-native development may still work, but the Compose-backed Dev Container is the documented and supported reproducible baseline.

Implementation rules are defined in `docs/standards/development/dev-container.md`.

## Not decided here

- exact future PostgreSQL image, storage, initialization, and local credentials;
- exact Oracle/local source-system image or test-fixture topology;
- automatic simultaneous startup of frontend and backend development processes;
- debugger/task/launch configuration details;
- Codespaces support.

## Consequences

- developers need VS Code with Dev Containers support and a compatible local Docker engine;
- the repository owns and updates both the workspace toolchain and stable local-service topology instead of relying on undocumented host installations;
- frontend/backend remain fast development processes inside one workspace while infrastructure dependencies remain isolated services;
- future PostgreSQL or optional source-system containers can be added without changing the developer-workspace model;
- automated tests can use Testcontainers without introducing Docker-in-Docker;
- because the workspace reuses the host Docker daemon, it is not a security sandbox for untrusted repository code.

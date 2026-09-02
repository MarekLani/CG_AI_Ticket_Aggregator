# Dev Container standard

## Scope

Applies to the repository-owned Compose-backed VS Code Dev Container used for local application development. Follow ADR 0006. Application/runtime images are governed separately by `docs/standards/infrastructure/containers.md`.

## Environment topology

- `.devcontainer/devcontainer.json` and `.devcontainer/compose.yml` together define the canonical supported local-development environment.
- VS Code attaches to the `workspace` Compose service. Keep frontend and backend development processes in that workspace unless an approved architecture change says otherwise.
- Use Compose services for stable local infrastructure dependencies needed during interactive development; do not install database/server processes into the workspace container.
- Use Docker-outside-of-Docker so Docker CLI/Compose and Testcontainers inside the workspace use the host Docker engine. Do not introduce Docker-in-Docker without an explicit architecture decision.
- Treat Compose-managed services and Testcontainers differently: Compose owns stable/reusable local services; Testcontainers owns ephemeral test-specific containers.

## Toolchain baseline

- Keep the workspace major toolchain versions aligned with project standards: .NET 10, Node.js 22, and Azure Functions Core Tools v4.
- Do not require developers using the supported path to install project runtimes or Azure Functions Core Tools directly on the host.
- Keep setup commands idempotent and suitable for a rebuilt container.
- Do not place secrets, credentials, customer data, or developer-specific absolute paths in Dev Container/Compose configuration.

## Running the application locally

- Run the frontend and backend as development processes inside the workspace container rather than treating it as a production-like application image.
- Use `5173` as the expected local Vite frontend port and `7071` as the expected local Azure Functions backend port unless an approved change updates the application development contract.
- Add repository-owned start/debug tasks or scripts when the corresponding application projects exist; do not add placeholder startup behavior before then.

## Local dependencies

- Do not add PostgreSQL before the persistence decision in ADR 0002 is activated by an approved use case.
- When PostgreSQL is introduced for interactive local development, add it as a sibling Compose service with repository-owned reproducible configuration.
- Automated PostgreSQL persistence tests follow ADR 0005/testing standards and may create isolated PostgreSQL containers through Testcontainers rather than reusing the interactive-development database.
- An Oracle or other source-system database is optional local integration infrastructure, not a default dependency. Add it only for an approved connector/testing use case and prefer an explicit Compose profile or equivalent opt-in so normal development does not require it.
- Use synthetic/anonymized fixture data only; never package or import customer/production databases into the local topology.

## Docker access and security

- Docker commands executed inside the workspace control the host Docker engine; containers they create are siblings of the workspace, not nested containers.
- Host-Docker access is required for Compose/Testcontainers but gives workspace code powerful control over the host Docker environment. Do not treat the Dev Container as a security sandbox for untrusted code.
- Stop and ask before changing the Docker socket/access model, adding privileged host mounts, or introducing Docker-in-Docker.

## Validation

When changing the Dev Container or Compose configuration:

- rebuild/reopen the repository in the Dev Container;
- verify VS Code attaches to the `workspace` service;
- verify `dotnet`, `node`, `npm`, `func`, `docker`, and `docker compose` are available at the expected major baselines;
- verify Docker commands from the workspace reach the host Docker engine;
- when frontend/backend projects exist, verify their normal repository-owned local start commands work and the documented ports are reachable;
- when a Compose dependency is added, verify it is reachable from the workspace by its Compose service name without undocumented host configuration.

Stop and ask before changing a major toolchain baseline, automatically starting new infrastructure, adding local persistence before ADR 0002 permits it, or making a source-system database mandatory for normal development.

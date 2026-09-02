# Dev Container standard

## Scope

Applies to the repository-owned VS Code Dev Container used for local application development. Follow ADR 0006. Application/runtime images are governed separately by `docs/standards/infrastructure/containers.md`.

## Toolchain baseline

- `.devcontainer/devcontainer.json` is the canonical supported local-development environment.
- Keep its major toolchain versions aligned with project standards: .NET 10, Node.js 22, and Azure Functions Core Tools v4.
- Provide Docker CLI/Compose access through the host Docker engine so containerized local dependencies and Testcontainers can run from inside the Dev Container.
- Do not require developers using the supported path to install project runtimes or Azure Functions Core Tools directly on the host.
- Keep setup commands idempotent and suitable for a rebuilt container. Do not place secrets, credentials, or developer-specific absolute paths in Dev Container configuration.

## Running the application locally

- Run the frontend and backend as development processes inside the Dev Container rather than treating the Dev Container itself as a production-like application image.
- Use `5173` as the expected local Vite frontend port and `7071` as the expected local Azure Functions backend port unless an approved change updates the application development contract.
- Add repository-owned start/debug tasks or scripts when the corresponding application projects exist; do not add placeholder startup behavior before then.

## Local dependencies

- Run databases and other infrastructure dependencies as separate containers; do not install server processes such as PostgreSQL into the development container.
- Do not add PostgreSQL before the persistence decision in ADR 0002 is activated by an approved use case.
- When PostgreSQL is introduced, use containerized PostgreSQL for interactive local development and the test isolation approach defined by ADR 0005/testing standards for automated persistence tests.
- Keep local dependency configuration reproducible and free of production credentials or customer data.

## Validation

When changing the Dev Container configuration:

- rebuild/reopen the repository in the Dev Container;
- verify `dotnet`, `node`, `npm`, `func`, `docker`, and `docker compose` are available at the expected major baselines;
- when frontend/backend projects exist, verify their normal repository-owned local start commands work and the documented ports are reachable;
- when a containerized local dependency is added, verify it is reachable from the application without requiring undocumented host configuration.

Stop and ask before introducing a new host mount/privilege model, replacing the Docker access model, changing a major toolchain baseline, automatically starting new infrastructure, or adding local persistence before ADR 0002 permits it.

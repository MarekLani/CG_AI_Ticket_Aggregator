# .NET backend standard

## Scope

Applies to `src/backend/`.

## Solution and SDK baseline

- When the backend is initialized, use a root `UnifiedWorkItems.slnx` solution. Prefer the .NET 10 SLNX format; do not introduce a parallel or legacy `.sln` unless a concrete tooling compatibility requirement justifies it.
- Create a root `global.json` with the first backend scaffold and pin the selected .NET 10 SDK used by the supported development environment. Do not invent an SDK patch version before the backend is initialized.
- Keep the `global.json` SDK major version aligned with the Dev Container and CI .NET baseline.
- Once `global.json` exists, local development and CI tooling must respect it; update the SDK baseline deliberately rather than relying on whichever compatible SDK happens to be installed.

## Mandatory

- Target .NET 10 unless an explicit issue changes the runtime baseline.
- Enable nullable reference types and treat warnings seriously.
- Use dependency injection for external systems and infrastructure adapters.
- Keep HTTP/transport concerns out of the source-neutral application/domain model.
- Use async I/O end-to-end for database and HTTP operations.
- Propagate `CancellationToken` through external I/O paths.
- Map external/source DTOs explicitly to internal models.
- Do not expose Oracle, Graph or GitHub SDK types in public application contracts.
- Do not log credentials, tokens, connection strings, personal text descriptions or full source payloads by default.

# .NET backend standard

## Scope

Applies to `src/backend/`.

## Mandatory

- Target .NET 10 unless an explicit issue changes the runtime baseline.
- Enable nullable reference types and treat warnings seriously.
- Use dependency injection for external systems and infrastructure adapters.
- Keep ASP.NET transport concerns out of the source-neutral application/domain model.
- Use async I/O end-to-end for database and HTTP operations.
- Propagate `CancellationToken` through external I/O paths.
- Map external/source DTOs explicitly to internal models.
- Do not expose Oracle, Graph or GitHub SDK types in public application contracts.
- Do not log credentials, tokens, connection strings, personal text descriptions or full source payloads by default.

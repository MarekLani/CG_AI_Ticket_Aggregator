# Backend tests

## Scope

Applies to automated tests for the .NET isolated Azure Functions backend. Follow ADR 0005 and `general.md`.

## Toolchain

- Use xUnit v3 for backend tests.
- Use Microsoft.Testing.Platform as the .NET test platform and keep backend test projects consistent on that platform; do not mix VSTest-based and Microsoft.Testing.Platform-based projects in the same solution/run configuration.
- `dotnet test` is the canonical repository command for backend test execution.
- Prefer small hand-written fakes for project-owned interfaces and boundaries. Do not add a mocking framework by default; introduce one only when a concrete test need justifies the dependency.

## What to test

Prioritize:

- source DTO -> source-neutral `WorkItem` mapping and normalization rules;
- application use cases such as query/filter/search behavior and validation;
- connector failure, cancellation, and result-handling behavior;
- HTTP contract behavior such as query validation, status codes, serialization, and Problem Details;
- Function entry points only where trigger, binding, or transport behavior adds meaningful risk; keep application logic tested outside the Functions host.

When authentication/authorization is implemented, test API authorization outcomes with controlled principals/claims or tokens appropriate to the test boundary; normal PR tests must not call Entra ID.

## External-system boundaries

- Test application behavior with controlled fakes at connector boundaries.
- Test adapter/client behavior with controlled protocol or SDK responses when the adapter behavior itself is in scope; do not leak source SDK/database types into application tests.

## PostgreSQL and EF Core

These rules apply only after application persistence is introduced under ADR 0002.

- Use Testcontainers for .NET to run PostgreSQL integration tests against real PostgreSQL/Npgsql behavior.
- Do not use EF Core InMemory or SQLite as a substitute for PostgreSQL-specific query, transaction, migration, or provider behavior.
- Do not mock `DbSet`/EF query behavior as a substitute for persistence integration tests.
- Keep integration-test data isolated so tests remain independent and repeatable.

Follow `general.md` for test quality, regression tests, test data, coverage, and protected/live-environment rules.

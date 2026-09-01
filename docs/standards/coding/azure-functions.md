# Azure Functions backend standard

## Scope

Applies to Azure Functions code under `src/backend/`.

## Runtime baseline

- Use Azure Functions v4 with .NET 10 isolated worker unless an approved issue changes the runtime baseline.
- Use standard .NET dependency injection and configuration provided by the isolated worker model.
- Keep hosting-plan-specific assumptions out of application code unless explicitly required by an approved architecture decision.

## Function design

- Keep function entry points thin. A function should translate a trigger into an application call and translate the result back to the transport/binding contract.
- Put business rules, source normalization, orchestration and persistence behavior in application/infrastructure services rather than function methods.
- HTTP-triggered functions must follow `docs/standards/api/http-api.md`.
- Timer/background functions must call explicit synchronization/orchestration services; do not duplicate connector logic in trigger classes.
- Do not introduce Durable Functions unless an approved issue or ADR requires durable orchestration semantics.

## Dependency injection and lifetimes

- Resolve dependencies through constructor injection; do not use service locators or static mutable service state.
- Treat scoped services as invocation-scoped.
- When EF Core is introduced, register `DbContext` with an appropriate scoped lifetime and never retain a context across function invocations or from singleton services.
- External clients should use the project's approved client/factory patterns and must not be recreated unnecessarily for every operation.

## Asynchronous work and cancellation

- Use async I/O end-to-end.
- Propagate `CancellationToken` through database, HTTP and connector operations where supported.
- Do not block asynchronous calls with `.Result`, `.Wait()` or equivalent synchronous waits.

## Retries and idempotency

- Assume background operations may be retried or executed again after partial failure.
- Make synchronization operations idempotent where practical.
- Do not implement nested, unbounded retry loops in function methods. Retry behavior belongs in an explicit connector/platform policy and must have bounded attempts and delays.
- Do not assume timer execution alone guarantees exactly-once processing.

## Persistence and migrations

Follow `docs/adr/0002-staged-application-persistence.md`.

- Do not add a database until an approved persistence use case exists.
- When PostgreSQL/EF Core is introduced, keep persistence behind application/infrastructure boundaries.
- Do not run EF Core schema migrations automatically from Function host startup or normal function invocations.
- Production migrations must be executed as an explicit deployment step.

## Configuration and secrets

- Read environment-specific configuration through the standard .NET configuration system.
- Never commit secrets or place credentials in source-controlled settings.
- Do not expose connection strings, access tokens or source payloads in logs.
- Prefer runtime identity and managed secret mechanisms where the deployment architecture supports them.

## Observability

- Use structured logging with stable event/message templates.
- Log enough context to identify the operation, source and result without logging sensitive payloads.
- Background synchronization should make success, failure and duration observable when implemented.
- Follow `docs/standards/observability.md` for logging and metrics changes.

## Testing

- Keep application logic testable without starting the Functions host.
- Unit-test application services and mapping behavior outside trigger classes.
- Add focused tests for HTTP contracts, binding-specific behavior or function entry points only where they provide meaningful value.
- Follow `docs/standards/testing/backend-tests.md` and `docs/standards/testing/general.md` for backend behavior changes.

## Validation

Use repository scripts where available. Backend changes should at minimum build and run the relevant automated tests before being reported as validated.

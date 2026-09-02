# Backend Agent Instructions

These instructions apply to work under `src/backend/` and extend the root `AGENTS.md`.

## Always read

Before planning, implementing or reviewing backend changes, read:

- `/AGENTS.md`
- `/docs/product/solution-overview.md`
- `/docs/standards/coding/general.md`
- `/docs/standards/coding/dotnet.md`
- `/docs/standards/coding/azure-functions.md`
- `/docs/standards/architecture/layering.md`

## Read when relevant

- HTTP/API changes: `/docs/standards/api/http-api.md`
- source integrations or synchronization: `/docs/standards/architecture/integration.md`
- backend tests: `/docs/standards/testing/general.md` and `/docs/standards/testing/backend-tests.md`
- security-sensitive behavior: `/docs/standards/security.md`
- logging, metrics or diagnostics: `/docs/standards/observability.md`
- application persistence or EF Core: `/docs/adr/0002-staged-application-persistence.md`
- deployment/hosting requirements: `/docs/architecture/deployment.md` and `/docs/architecture/infrastructure-requirements.md`

## Backend rules

- Keep Azure Function entry points thin and delegate behavior to application/infrastructure services.
- Keep source-system SDK/database types behind integration boundaries.
- Do not introduce application persistence until an approved issue satisfies the persistence decision in ADR 0002.
- Do not run production schema migrations from Function startup or invocation code.
- Avoid unrelated refactoring and new dependencies outside approved scope.

## Validation

Use repository scripts where available and run the relevant backend build/tests before reporting validation as successful.

## Stop conditions

Stop and ask the responsible developer when:

- source-system behavior or business mapping is ambiguous;
- a new persistence requirement does not clearly fit ADR 0002;
- a new trigger type, Durable Functions, hosting-plan assumption or major backend dependency is required without approved scope;
- security, runtime identity or secret-handling behavior is unclear;
- required validation cannot be executed.

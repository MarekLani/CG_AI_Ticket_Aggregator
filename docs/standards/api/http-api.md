# HTTP API standard

## Scope

Applies to the HTTP contract exposed by the backend to the frontend and other API consumers. It defines routes, requests, responses, errors, and contract evolution; backend implementation details remain in the .NET and Azure Functions standards.

## Contract design

- Use resource-oriented, predictable routes under `/api`; the initial collection endpoint is `GET /api/work-items`.
- Use HTTP methods according to operation semantics. The initial API is read-only and uses `GET`.
- Keep transport DTOs source-neutral and independent from Oracle, Microsoft Graph, GitHub SDK, or other integration-specific types.
- Preserve `source`, `externalId`, and source-specific display values required by the UI without leaking source schema details into the generic contract.
- Do not create source-specific endpoints or contract fields unless a concrete requirement justifies them.

## Query parameters

- Express search and filtering of collections through query parameters.
- Validate supported query parameters and reject invalid values rather than silently changing their meaning.
- Do not expose raw source/database field names as public query parameters.
- Add sorting or pagination only when required, and define their contract consistently before implementation.

## Responses and errors

- Return normal collection responses for collection queries, including when no items match.
- Use appropriate HTTP status codes for invalid requests and resource-specific failures.
- Return a consistent Problem Details response for API errors.
- Do not expose stack traces, connection details, credentials, tokens, or other internal implementation information. Follow `docs/standards/security.md`.

## Contract evolution

- Breaking HTTP contract changes require explicit issue scope and review.
- Do not introduce API versioning preemptively. If a breaking contract must be supported, decide the compatibility/versioning approach explicitly before implementation.
- Update relevant contract tests when observable API behavior changes.

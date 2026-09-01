# HTTP API standard

- Use resource-oriented predictable endpoints.
- Keep API DTOs source-neutral where possible.
- Preserve `source`, `externalId` and source-specific display status/type values required by UI.
- Validate query/filter parameters.
- Return consistent problem details for errors.
- Do not expose exception stack traces, connection details or tokens.
- Breaking contract changes require explicit issue scope and review.

# Application security standard

## Scope

Applies to application code, configuration, integrations, tests, and operational behavior in this repository. Identity and access rules are defined in `identity-and-access.md`.

## Rules

- Treat HTTP input and data from external source systems as untrusted and validate it at the application boundary.
- Apply least privilege to source systems, APIs, databases, Azure resources, and deployment identities.
- Initial source integrations remain read-only unless an approved issue changes that boundary.
- Use parameterized database access; never build SQL from untrusted values by string concatenation.
- Never disable TLS certificate validation to make an integration work.
- Never commit or place secrets, credentials, tokens, private keys, production/customer data, or real personal data in source, prompts, fixtures, or examples.
- Runtime secrets must come from approved secure configuration or identity mechanisms; do not add insecure fallback credentials for convenience.
- Do not log access tokens, credentials, connection strings, full source payloads, personal descriptions, or person names by default. Prefer stable IDs and structured operational metadata.
- Do not expose stack traces, connection details, internal exception messages, or secret-bearing configuration through HTTP responses. Follow the HTTP API standard for error contracts.
- Keep dev and future prod credentials/configuration separate. Production credentials must not be used for local development or committed test automation.
- Prefer existing reviewed dependencies. New security-sensitive dependencies require explicit justification and review; do not disable dependency or security checks merely to make validation pass.
- Authentication, authorization, credential handling, or trust-boundary changes require explicit approved behavior and focused review.

If a security requirement requires a new trust, identity, permission, or authorization model that is not defined, stop and ask rather than inventing one.

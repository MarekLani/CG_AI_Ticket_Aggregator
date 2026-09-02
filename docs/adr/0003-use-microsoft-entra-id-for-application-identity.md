# ADR 0003: Use Microsoft Entra ID for application identity

- Status: Accepted
- Date: 2026-09-02

## Context

The application requires interactive user sign-in, protected API access, and workload authentication for backend and deployment scenarios.

## Decision

Use Microsoft Entra ID / Microsoft identity platform as the application identity platform.

- use OpenID Connect for interactive sign-in and OAuth 2.0 access tokens for protected APIs;
- represent application clients and protected APIs through Entra app registrations and their service principals; expose API scopes/app roles as required by the approved access model;
- use delegated access when operations run on behalf of a signed-in user;
- use application access for non-interactive workloads when user context is not required;
- prefer managed identities for Azure service-to-service authentication where supported.

Implementation rules are defined in `docs/standards/security/identity-and-access.md`.

## Not decided here

- tenant model;
- exact app-registration topology;
- concrete delegated scopes or application roles;
- business authorization roles and claim mappings.

## Consequences

- custom authentication or token formats are outside the standard architecture;
- application and infrastructure work must support the Entra identity model;
- undefined identity/authorization details require an explicit design decision before implementation.

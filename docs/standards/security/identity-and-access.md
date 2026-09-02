# Identity and access standard

Identity architecture is defined in ADR 0003. This document defines implementation rules for that architecture.

## User and delegated access

- Use delegated permissions when an API call is performed on behalf of a signed-in user.
- APIs must authorize using access tokens issued for the API; do not use ID tokens as API authorization credentials.
- Validate token signature, issuer, audience, lifetime, and required permissions using supported identity libraries/middleware rather than custom JWT validation.
- Enforce authorization on the backend. Frontend visibility or routing is never an authorization boundary.
- If a backend must call another Entra-protected API on behalf of the user, use an approved delegated flow such as OAuth On-Behalf-Of; do not forward a token to a different audience.

## Application and workload access

- Use application permissions/app roles for non-interactive app-only access where no user context exists, and grant only the permissions required by the workload.
- For Azure service-to-service communication, prefer managed identities when the caller and target support Microsoft Entra authentication.
- Do not introduce client secrets or certificates when managed identity provides the required access.
- Where managed identity is not applicable, use an approved workload identity/federation or credential mechanism and keep the granted permissions minimal.
- GitHub Actions authentication to Azure should use OpenID Connect workload identity federation rather than long-lived Azure client secrets.

## Authorization

- Treat authentication and authorization as separate concerns; successful authentication does not imply access to every operation.
- Deny access unless the required delegated scope, app role, or other explicitly approved authorization rule is satisfied.
- Do not base authorization on mutable display values such as names or email addresses unless an approved design explicitly requires it.
- Application permissions can provide broad unattended access and therefore require deliberate scope selection and review.

When implementation requires an undefined tenant choice, app-registration arrangement, scope, app role, claim mapping, or business role model, stop and ask before implementing it.

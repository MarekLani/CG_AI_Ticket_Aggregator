# Frontend observability standard

## Scope

Applies to telemetry emitted by the React browser application. Follow ADR 0004 and `general.md`.

## Application Insights browser telemetry

- Use the Application Insights JavaScript SDK for browser telemetry. Do not use browser OpenTelemetry as the standard instrumentation path.
- Send browser telemetry only to the frontend Application Insights resource defined by ADR 0004; never reuse the backend Application Insights resource for browser ingestion.
- Treat the browser Application Insights connection string as a public resource identifier, not as a secret or authorization mechanism.

## Baseline telemetry

- Capture page/navigation telemetry, unhandled client errors, and application API dependency timing/failures where supported by the SDK.
- Propagate the distributed trace context required by ADR 0004 to the application API and other explicitly approved endpoints; do not broadly attach telemetry headers to arbitrary third-party requests.
- Use stable route or screen names rather than names that embed work-item IDs, user identifiers, or other high-cardinality values.
- Do not enable click analytics or broad custom interaction tracking without an explicit use case and review.

## Browser-specific privacy

Follow `docs/standards/security/general.md` and `general.md` for sensitive-data, free-form text, URL/query-string, and cardinality restrictions.

- Do not set authenticated user email/name or another directly identifying value as telemetry user context without explicitly approved behavior.
- Do not turn browser telemetry into broader product analytics without explicit scope and review.

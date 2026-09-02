# Frontend observability standard

## Scope

Applies to telemetry emitted by the React browser application. Follow ADR 0004 and `general.md`.

## Application Insights browser telemetry

- Use the Application Insights JavaScript SDK for browser telemetry. Do not use browser OpenTelemetry as the standard instrumentation path.
- Send browser telemetry only to the frontend Application Insights resource defined by ADR 0004; never reuse the backend Application Insights resource for browser ingestion.
- Treat the browser Application Insights connection string as a public resource identifier, not as a secret or authorization mechanism.
- Browser telemetry must remain optional to application correctness; SDK loading or ingestion failure must not prevent normal UI operation.

## Baseline telemetry

- Capture page/navigation telemetry, unhandled client errors, and application API dependency timing/failures where supported by the SDK.
- Preserve W3C distributed trace context for calls to the application API so browser, backend, and downstream dependency telemetry can be correlated.
- Limit correlation/dependency instrumentation to the application API and other explicitly approved endpoints; do not broadly attach telemetry headers to arbitrary third-party requests.
- Use stable route or screen names. Avoid telemetry names that embed work-item IDs, user identifiers, or other high-cardinality values.
- Do not enable click analytics or broad custom interaction tracking without an explicit use case and review.

## Privacy and data minimization

- Do not send work-item titles/descriptions, personal names, free-form search input, filter text that can contain personal data, or source payload content as telemetry properties.
- Do not set authenticated user email/name or another directly identifying value as telemetry user context without explicitly approved behavior.
- Avoid collecting full URL query strings when query parameters can contain free-form or sensitive values; prefer normalized routes and approved bounded properties.
- Custom events and properties must have a concrete operational or product-monitoring purpose and bounded cardinality.

Sampling, retention, alerting, dashboards, availability tests, and broader product analytics remain undefined until explicitly required.

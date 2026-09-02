# Backend observability standard

## Scope

Applies to telemetry emitted by the .NET isolated Azure Functions backend. Follow ADR 0004 and `general.md`.

## Application Insights and OpenTelemetry

- Use the Microsoft-supported Azure Functions OpenTelemetry integration and Azure Monitor exporter to send backend telemetry to Application Insights.
- Enable OpenTelemetry for both the Functions host and isolated worker so host/runtime telemetry and application telemetry remain correlated.
- Prefer the current supported OpenTelemetry pipeline over classic Application Insights SDK instrumentation. Do not introduce a second Application Insights/OpenTelemetry pipeline that can duplicate requests, dependencies, logs, or traces.
- Use standard .NET instrumentation surfaces: `ILogger<T>` for logs, `Activity`/`ActivitySource` for custom tracing, and `Meter` for custom metrics.
- Prefer automatic request and dependency instrumentation. Add custom activities only for important application operations that are otherwise not visible.
- An OpenTelemetry Collector is not required for this application unless a later approved architecture decision introduces one.

## Correlation and dependencies

- Preserve W3C trace context across inbound requests and supported outbound HTTP/dependency calls.
- Connector telemetry should identify the source and operation and, where useful, capture outcome, duration, and aggregate item count.
- Do not create high-cardinality metric dimensions from external IDs, users, work items, trace IDs, or exception messages.

## Configuration and ingestion

- Use the backend Application Insights resource defined by ADR 0004; never send backend telemetry to the browser telemetry resource.
- Keep the Application Insights connection string and observability configuration externalized from code.
- In Azure, use Microsoft Entra authenticated ingestion with the workload managed identity where supported. Do not introduce a client secret solely for telemetry ingestion.
- Service/component and environment metadata must be stable and configurable rather than hard-coded differently across call sites.

## Failures

- Log failed external dependencies and application operations at the layer that can add useful context; avoid duplicate exception logs as errors propagate.
- A telemetry exporter outage or throttling condition must not fail a successful business operation.

Sampling, retention, alerts, dashboards, availability checks, and custom telemetry taxonomy remain undefined until explicitly required.

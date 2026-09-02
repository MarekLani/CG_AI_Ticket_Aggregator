# Backend observability standard

## Scope

Applies to telemetry emitted by the .NET isolated Azure Functions backend. Follow ADR 0004 and `general.md`.

## Application Insights and OpenTelemetry

- Use the Microsoft-supported Azure Functions OpenTelemetry integration and Azure Monitor exporter to send backend telemetry to Application Insights.
- Enable OpenTelemetry for both the Functions host and isolated worker so host/runtime telemetry and application telemetry remain correlated.
- Prefer the supported OpenTelemetry pipeline over classic Application Insights SDK instrumentation. Do not configure a second Application Insights/OpenTelemetry pipeline that can duplicate requests, dependencies, logs, or traces.
- Use standard .NET instrumentation surfaces: `ILogger<T>` for logs, `Activity`/`ActivitySource` for custom tracing, and `Meter` for custom metrics.
- Prefer automatic request and dependency instrumentation before adding custom `ActivitySource` spans.

## Connector telemetry

- For external connectors, source and operation are useful bounded properties; where useful, record outcome, duration, and aggregate item counts rather than per-item informational telemetry.

## Configuration and ingestion

- Configure backend telemetry for the backend Application Insights destination defined by ADR 0004; never point backend instrumentation at the browser telemetry resource.
- In Azure, use the Microsoft Entra/managed-identity ingestion model required by ADR 0004 where supported. Do not introduce a client secret solely for telemetry ingestion.

Follow `general.md` for log quality, exception handling, cardinality, sensitive data, telemetry reliability, and stop conditions.

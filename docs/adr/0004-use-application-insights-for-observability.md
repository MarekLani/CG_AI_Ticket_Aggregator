# ADR 0004: Use Azure Monitor Application Insights for application observability

- Status: Accepted
- Date: 2026-09-02

## Context

The application has a React browser client and a .NET isolated Azure Functions backend. It needs correlated full-stack diagnostics while keeping trusted server telemetry separate from telemetry produced in an untrusted browser environment.

Separate frontend and backend Application Insights resources isolate untrusted browser telemetry from trusted backend operational telemetry while preserving consolidated querying and distributed trace correlation.

## Decision

Use Azure Monitor Application Insights as the application observability platform.

- backend Azure Functions telemetry uses the Microsoft-supported OpenTelemetry path and exports to Application Insights;
- browser telemetry uses the Application Insights JavaScript SDK rather than browser OpenTelemetry;
- frontend and backend use separate workspace-based Application Insights resources per environment;
- the frontend and backend Application Insights resources use the same Log Analytics workspace per environment so operational querying remains consolidated;
- preserve W3C distributed trace context across browser, API, and downstream dependency calls;
- backend telemetry ingestion uses Microsoft Entra authentication and managed identity where supported; browser telemetry uses client-side connection-string ingestion and its connection string is not treated as a secret;
- an OpenTelemetry Collector or additional telemetry backend is not part of the default architecture and requires an explicit future decision.

Implementation rules are defined under `docs/standards/observability/`.

## Not decided here

- sampling policy;
- telemetry retention period;
- alert thresholds, routing, and escalation;
- dashboards or workbooks;
- availability/SLA tests;
- exact custom metric/event taxonomy;
- Azure resource naming.

## Consequences

- infrastructure must provide separate frontend and backend Application Insights destinations per environment and a common Log Analytics workspace for them;
- backend and frontend intentionally use different instrumentation libraries while remaining correlated through standard trace context;
- backend operational telemetry can use authenticated ingestion independently of the browser telemetry trust boundary;
- OpenTelemetry is the backend instrumentation standard, not a requirement to make the observability backend provider-neutral.

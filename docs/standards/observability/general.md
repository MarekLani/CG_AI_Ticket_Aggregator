# General observability standard

## Scope

Applies to application logs, traces, metrics, and custom telemetry. Platform and instrumentation choices are defined in ADR 0004; backend- and frontend-specific rules are defined in the sibling standards.

## Telemetry quality

- Use structured logging with stable message templates and named properties rather than concatenated diagnostic strings.
- Prefer the existing W3C trace/span context for request correlation. Do not invent a parallel correlation-ID scheme unless an external contract requires one.
- Capture enough context to answer what operation ran, against which source/component, whether it succeeded, and how long it took.
- For batch or synchronization work, prefer aggregate telemetry such as duration, outcome, and item counts over one informational log entry per item.
- Record an exception with useful operational context at the boundary that owns the failure. Avoid repeatedly logging the same exception at every layer.

## Levels and signals

- `Debug`/`Trace`: detailed diagnostics useful for development or targeted troubleshooting; do not rely on them for normal production operations.
- `Information`: meaningful application operations and state transitions, not routine implementation noise.
- `Warning`: unexpected or degraded behavior from which the operation can continue or recover.
- `Error`: an operation failed or produced an unusable result.
- Use traces/spans for operation flow and dependency timing. Add custom spans only where automatic instrumentation does not make an important application operation visible.
- Use metrics for numeric trends that benefit from aggregation. Custom metric dimensions must have bounded cardinality; do not use user IDs, work-item IDs, trace IDs, free-form text, or other unbounded identifiers as metric dimensions.

## Sensitive data

Follow `docs/standards/security/general.md`.

- Never emit credentials, access tokens, connection strings, private keys, full source payloads, or request/response bodies by default.
- Do not emit work-item descriptions, personal names, free-form search input, or other potentially sensitive user/source text as custom telemetry.
- Prefer operational metadata and stable technical identifiers only when they are genuinely needed for diagnosis.
- Do not capture full URLs or query strings when they can contain sensitive or free-form values; use normalized route/operation names instead.

## Reliability and configuration

- Telemetry export failure must not make a normal application operation fail.
- Keep telemetry destination, credentials, environment, and service/component metadata externalized from application code.
- Keep `dev` and future `prod` telemetry separated according to ADR 0004.
- Do not add another telemetry backend, OpenTelemetry Collector, custom exporter, or parallel instrumentation pipeline without approved scope.
- Add custom telemetry only when there is a concrete diagnostic, operational, or product-monitoring use case.

When a change requires an undefined sampling, retention, alerting, availability/SLA, telemetry-backend, or sensitive-data collection policy, stop and ask before implementing it.

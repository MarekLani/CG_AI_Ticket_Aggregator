# General observability standard

## Scope

Applies to application logs, traces, metrics, and custom telemetry. Platform and instrumentation choices are defined in ADR 0004; backend- and frontend-specific rules are defined in the sibling standards.

## Telemetry quality

- Use structured logging with stable message templates and named properties rather than concatenated diagnostic strings.
- Capture enough context to identify the operation, relevant source/component, outcome, and duration when useful for diagnosis.
- For batch or synchronization work, prefer aggregate telemetry such as duration, outcome, and item counts over one informational log entry per item.
- Record an exception with useful operational context at the boundary that owns the failure. Avoid repeatedly logging the same exception at every layer.
- Use log levels consistently: `Information` for meaningful operations or state transitions, `Debug`/`Trace` for detailed troubleshooting, `Warning` for degraded or recoverable behavior, and `Error` for failed or unusable operations.
- Prefer automatic tracing before adding custom spans. Add custom spans only when an important application operation is otherwise not visible.
- Add custom metrics only for a concrete aggregation/trend use case. Metric dimensions must have bounded cardinality; do not use user IDs, work-item IDs, trace IDs, free-form text, or similar unbounded values as dimensions.

## Sensitive data

Follow `docs/standards/security/general.md` for sensitive-data and logging restrictions.

- Avoid free-form user/source text in telemetry unless an explicitly approved diagnostic use case requires it.
- Prefer normalized route/operation names over full URLs or query strings that can contain sensitive or free-form values.
- Prefer bounded technical metadata over payload content.

## Reliability and configuration

- Telemetry export failure must not make a normal application operation fail.
- Keep telemetry destination, credentials, environment, and service/component metadata externalized and consistently configured rather than hard-coded across call sites.
- Add custom telemetry only when there is a concrete diagnostic, operational, or product-monitoring use case.

If implementation requires a sampling, retention, alerting, availability/SLA, telemetry-backend, or other observability decision left open by ADR 0004, stop and ask before implementing it.

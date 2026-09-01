# Observability standard

For external connector operations capture enough structured telemetry to diagnose failures without exposing sensitive source content.

Prefer fields such as:
- source name;
- operation name;
- duration;
- success/failure category;
- item count;
- correlation/trace ID.

Do not log tokens, connection strings, full payloads or customer descriptions.

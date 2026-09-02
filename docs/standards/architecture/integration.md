# External integration standard

## Mandatory

- One connector/adapter boundary per source system.
- Preserve source identifiers and source-specific raw values needed for traceability.
- Translate into the shared model explicitly; no reflection/name-based magic mappings.
- Timeouts, cancellation and transient-failure behavior must be defined for network/database calls.
- Avoid requesting wider permissions or selecting wider datasets than required.
- Make connectors testable without calling real production systems.
- Never invent source-field semantics. Unknown semantics are an open question.

## Helpdesk

- `I_POZIAD` is the unique Helpdesk external identifier.
- First integration is read-only from `VW_RM_POZIAD`.
- Project only fields needed by the current use case; do not `SELECT *` in application code.

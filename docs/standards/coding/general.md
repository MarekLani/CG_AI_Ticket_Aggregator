# General coding standard

## Mandatory

- Keep changes small and cohesive.
- Prefer explicit, readable code over speculative abstractions.
- No unrelated refactoring in feature/bug PRs.
- Validate external input at system boundaries.
- Do not swallow exceptions without an explicit handling/logging reason.
- Use cancellation/timeouts for external I/O where the platform supports them.
- Do not commit generated secrets or environment-specific configuration.
- New dependencies require a concrete use case and must not duplicate an existing capability without justification.
- Changed behavior requires automated tests where practical.

## Automatic checks

Compiler, linters, tests and CI are authoritative enforcement mechanisms where configured. Do not disable them to pass a change.

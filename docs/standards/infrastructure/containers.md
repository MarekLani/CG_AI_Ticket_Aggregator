# Container standard

## Scope

Applies to application/runtime container images. The supported local developer container is a separate concern governed by ADR 0006 and `docs/standards/development/dev-container.md`.

- Containerization is introduced only after the first local vertical slice works.
- Use multi-stage builds where appropriate.
- Run as a non-root user when supported by the chosen base/runtime image.
- Do not bake secrets or environment-specific configuration into images.
- Keep runtime images minimal and pin major runtime/toolchain baselines deliberately.
- Provide health/readiness behavior when required by the selected Azure runtime.
- Container must be reproducibly buildable from repository sources.
- Local container execution must be validated before first cloud deployment.

# Container standard

- Containerization is introduced only after the first local vertical slice works.
- Use multi-stage builds where appropriate.
- Run as a non-root user when supported by the chosen base/runtime image.
- Do not bake secrets or environment-specific configuration into images.
- Keep runtime images minimal and pin major runtime/toolchain baselines deliberately.
- Provide health/readiness behavior when required by the selected Azure runtime.
- Container must be reproducibly buildable from repository sources.
- Local container execution must be validated before first cloud deployment.

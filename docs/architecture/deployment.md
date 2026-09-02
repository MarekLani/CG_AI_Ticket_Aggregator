# Deployment architecture

This repository owns application build, validation, packaging, and application deployment workflows. Azure infrastructure remains in the separate infrastructure repository; see ADR 0001.

## Delivery model

GitHub Actions is the CI/CD platform. Branching follows `CONTRIBUTING.md`.

Environments considered by the application delivery model:
- `dev` — current deployment target;
- `prod` — future target, not currently implemented.

### CI

CI runs only:
- for pull requests targeting `main` when opened, reopened, or updated;
- on push to `main` after changes are merged.

Do not add generic push triggers for short-lived feature branches.

### CD

Development deployment runs only on push to `main` once an actual deployment workflow exists.

Future production deployment should be driven by creation of a tag and a subsequent GitHub Release. The tag naming and exact production release workflow are intentionally undefined until explicitly decided.

Do not add a no-op CD workflow before the deployment target and required deployment steps are defined.

Application platform needs are recorded in `docs/architecture/infrastructure-requirements.md`.

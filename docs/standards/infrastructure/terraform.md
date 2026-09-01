# Terraform standard

Infrastructure changes are high-risk by default.

## Mandatory

- Terraform is the source of truth for application-owned Azure infrastructure once IaC is introduced.
- Do not commit state files, plan files containing sensitive values or credentials.
- Pin Terraform/provider versions deliberately and update them through reviewed PRs.
- Use remote state with locking/protection appropriate to the selected Azure backend once shared environments exist.
- Separate environment-specific values from reusable definitions.
- Use variables/outputs intentionally; do not expose secrets as plain outputs.
- Run `terraform fmt`, `terraform validate` and a reviewed `terraform plan` before apply.
- Production/shared environment apply must occur through an approved controlled workflow after the bootstrap/manual-learning phase.
- Use least-privilege federated/workload identity for CI/CD rather than long-lived cloud secrets where supported.
- Resource deletion/replacement risk must be visible in the plan and explicitly reviewed.

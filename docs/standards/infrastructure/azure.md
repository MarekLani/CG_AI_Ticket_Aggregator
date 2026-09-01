# Azure standard

- Choose the minimum Azure services required by approved requirements; avoid architecture for hypothetical scale.
- Prefer managed services over self-managed infrastructure when they satisfy requirements.
- Exact compute/database/network choices require an explicit architecture issue/ADR.
- Prefer managed identity/workload identity over embedded credentials.
- Resource naming, region, tagging and environment strategy must be defined when the infrastructure issue is created.
- Networking to RM is a first-class requirement and must be validated before assuming a cloud runtime can access the source.
- Observability and cost impact are part of the infrastructure plan.

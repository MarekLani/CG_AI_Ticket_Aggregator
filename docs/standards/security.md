# Security standard

- No secrets, credentials, tokens, private keys or production/customer data in repository, prompts, fixtures or logs.
- Runtime credentials come from secure environment/identity mechanisms.
- Apply least privilege to RM database access, GitHub access, Microsoft Graph and Azure.
- First source connectors are read-only unless an explicit future issue changes this boundary.
- Authentication/authorization changes are high-risk and require explicit approved behavior and review.
- Do not log full source descriptions or customer/person names by default; prefer IDs and structured operational metadata.

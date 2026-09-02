# Infrastructure requirements

This document contains application requirements that the separate infrastructure repository must satisfy. It is not an Azure or Terraform design.

## Current requirements

- Backend runtime: Azure Functions v4, .NET 10 isolated worker, HTTPS, externalized configuration/secrets, and application telemetry support.
- Frontend runtime: serve the React/Vite build over HTTPS.
- Identity: support the Entra identity architecture defined in ADR 0003, including managed identity for Azure workloads where required; exact identity resources and RBAC remain infrastructure-owned.
- Source connectivity: backend access to the helpdesk Oracle source; outbound HTTPS to GitHub and Microsoft Graph when those connectors are enabled.
- Persistence: none for the first vertical slice. If persistence is introduced, the platform must provide PostgreSQL connectivity. This repository owns the EF Core schema/migrations; the infrastructure repository owns the PostgreSQL service and its platform configuration.

## Boundary

Do not define Azure resource topology, networking, DNS, firewall rules, CIDR ranges, Terraform state, or RBAC design here.

When application work creates a new durable platform requirement, update this document and create or link the corresponding infrastructure work.

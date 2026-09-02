# Infrastructure requirements contract

## Purpose

This document defines what the Unified Work Items application requires from its hosting platform.

It is an **application-side contract**, not an infrastructure design. The dedicated infrastructure repository owns the Azure and Terraform implementation used to satisfy these requirements.

Application agents must not invent infrastructure details such as CIDR ranges, subnets, routes, private endpoints, DNS zones, firewall rules, Terraform state layout, resource naming, or RBAC topology in this repository.

## Backend runtime

The platform must provide a runtime compatible with the application's approved backend baseline:

- Azure Functions v4;
- .NET 10 isolated worker;
- HTTPS access for the application's HTTP endpoints;
- runtime configuration supplied outside source control;
- an application identity and secret/configuration mechanism appropriate to the approved security design;
- access to the application's telemetry destination.

The Azure Functions hosting plan, scaling configuration, region, network integration mode, and other Azure resource-level choices are owned by the infrastructure repository.

## Frontend runtime

The platform must be able to serve the built React/Vite frontend over HTTPS.

The exact Azure hosting service and delivery topology are infrastructure decisions unless an application requirement makes a specific capability necessary.

## Source-system connectivity

The backend must be able to reach the external systems required by enabled connectors.

Initial and planned requirements include:

- connectivity to the RM/helpdesk Oracle source used by the RM connector;
- outbound HTTPS connectivity to GitHub APIs when the GitHub connector is enabled;
- outbound HTTPS connectivity to Microsoft Graph when the Planner connector is enabled;
- DNS resolution required for those destinations.

The application repository does not define the network path to RM. Address ranges, routes, VPN/ExpressRoute choices, firewall rules, DNS forwarding, and related connectivity details must be explicitly designed in the infrastructure repository from known environment information.

## Persistence connectivity

The first read-only vertical slice does not require an application database. See `docs/adr/0002-staged-application-persistence.md`.

When persistence is introduced, the platform must provide connectivity from the backend to the approved PostgreSQL service and supply the runtime configuration required by the application.

The infrastructure repository owns PostgreSQL server provisioning, network access, platform configuration, backup/availability settings, and Azure-side identity/access configuration. The application repository owns the application schema and EF Core migrations.

## Configuration and secrets

The platform must provide environment-specific runtime configuration without requiring secrets to be committed to this repository or embedded in application artifacts.

Configuration may include, as relevant:

- source-system endpoints;
- database connectivity information when persistence is enabled;
- connector configuration;
- telemetry configuration;
- identity/resource references required by the application.

The exact Azure services and secret-delivery mechanism are infrastructure/security decisions.

## Observability

The platform must provide a destination for application logs, metrics, and diagnostics when observability is enabled.

The application owns what it emits and must follow `docs/standards/observability.md`. The infrastructure repository owns the Azure monitoring resources, retention/platform configuration, and access controls.

## Cross-repository change rule

When an application change creates or changes a platform requirement:

1. update this document in the application change when appropriate;
2. create or link the corresponding infrastructure issue/change;
3. do not implement the Azure/Terraform change in this repository;
4. keep application and infrastructure pull requests independently reviewable.

Infrastructure implementation details do not need to be copied back into this document unless they become a durable application constraint.
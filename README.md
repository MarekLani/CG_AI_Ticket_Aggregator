# Unified Work Items

Unified Work Items is an internal web application that provides a single read-oriented view of work items originating in multiple systems.

The initial source is the existing RM/helpdesk application exposed through the `VW_RM_POZIAD` view. Microsoft Planner tasks and GitHub Issues are planned as later connectors. Source systems remain the systems of record; this application normalizes selected fields for search, filtering, and operational overview.

## Initial product goal

Provide a simple web page where users can see and filter important open work across RM, Planner, and GitHub without checking each source separately.

The first vertical slice intentionally covers only RM:

`VW_RM_POZIAD -> backend connector -> normalized WorkItem -> HTTP API -> React list`

See `docs/product/solution-overview.md` for product boundaries and `docs/architecture/overview.md` for the target architecture.

## Engineering approach

Development follows the AI-assisted workflow documented in `docs/ai/ai-development-workflow.md`.

Key rules:

- GitHub Issues define the requested outcome.
- A human developer owns every issue and every merge decision.
- Small, low-risk work may be implemented directly from an approved issue.
- Standard work uses a human-approved implementation plan before implementation.
- High-risk or architectural work uses the full planning, AI review, and human review flow.
- AI agents must not invent business rules or receive secrets, production data, or private keys.

Start with `AGENTS.md` before using any coding agent in this repository.

## Intended technology areas

- Backend: .NET 10 / Azure Functions isolated worker
- Frontend: React + TypeScript + Vite
- Integration: RM first; Planner and GitHub later
- Packaging: application/container artifacts as required by the approved deployment path
- Target hosting: Azure
- Application CI/CD: GitHub Actions
- Azure infrastructure and Terraform: maintained in a separate infrastructure repository

Persistence and deployment requirements must be decided through explicit issues and ADRs rather than inferred by an agent. The application-side infrastructure contract is documented in `docs/architecture/infrastructure-requirements.md`.

## Repository layout

- `src/backend/` — backend application
- `src/frontend/` — frontend application
- `docs/product/` — durable product context
- `docs/architecture/` — current application architecture, data flows, deployment boundary, and infrastructure requirements
- `docs/adr/` — durable architecture decisions
- `docs/standards/` — application engineering standards
- `docs/ai/` — AI workflow, prompts, and templates
- `.github/` — issue forms, pull-request template, and application CI
- `scripts/` — repeatable application/repository validation commands

Azure resource definitions, Terraform configuration/state, networking topology, and infrastructure deployment pipelines intentionally do not live in this repository.

## Bootstrap state

This repository is intentionally a process-and-context bootstrap. Application code, deployment artifacts, and application workflows should be introduced incrementally through GitHub Issues during the implementation and training flow.
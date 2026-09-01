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

- Backend: .NET 10 / ASP.NET Core
- Frontend: React + TypeScript
- Integration: RM first; Planner and GitHub later
- Packaging: containers
- Infrastructure as code: Terraform
- Target hosting: Azure
- CI/CD: GitHub Actions

Exact Azure service choices, persistence choices, and deployment topology must be decided through explicit issues and ADRs rather than inferred by an agent.

## Repository layout

- `src/backend/` — backend application
- `src/frontend/` — frontend application
- `infrastructure/terraform/` — Terraform configuration, introduced when infrastructure work begins
- `docs/product/` — durable product context
- `docs/architecture/` — current architecture and data flows
- `docs/adr/` — durable architecture decisions
- `docs/standards/` — engineering standards
- `docs/ai/` — AI workflow, prompts, and templates
- `.github/` — issue forms, pull-request template, and CI
- `scripts/` — repeatable validation commands

## Bootstrap state

This repository is intentionally a process-and-context bootstrap. Application code, Dockerfiles, Terraform resources, and deployment workflows should be introduced incrementally through GitHub Issues during the implementation and training flow.

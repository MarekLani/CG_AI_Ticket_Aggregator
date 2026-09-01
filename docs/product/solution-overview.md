# Unified Work Items — Solution Overview

## Purpose

Unified Work Items gives the internal team one web view of open and recently active work that is currently tracked across several systems. The goal is to reduce the need to check RM/helpdesk, Microsoft Planner, and GitHub separately.

The application is primarily a read-oriented aggregator. Source systems remain the systems of record, and the first phase does not modify their content.

## Users and actors

- internal users who need a consolidated operational view of work;
- RM/helpdesk as the initial source of requirements, change requests, and bug reports;
- Microsoft Planner as a planned source of tasks;
- GitHub Issues as a planned source of development work;
- synchronization and integration components that read and normalize source data.

## Problems the solution addresses

- work items are spread across several systems;
- it is difficult to get a single view by status, product, priority, or assignee;
- the team needs a lightweight operational view without migrating or replacing existing source systems.

## Main capabilities

Planned capabilities include:

1. read RM requirements;
2. map source data into a normalized work-item model;
3. display a web list with search and filtering;
4. provide a deep link back to the source system where available;
5. add a Microsoft Planner connector;
6. add a GitHub Issues connector;
7. add caching/persistence, scheduled synchronization, stale/age indicators, and aggregate views only when a concrete need justifies them.

## First vertical slice

The first functional slice covers RM only:

`VW_RM_POZIAD -> RM adapter -> normalized WorkItem -> API -> React table`

`I_POZIAD` is the unique external identifier of an RM requirement.

Initially relevant RM fields:

- `I_POZIAD` — external ID;
- `N_POZIAD` — title;
- `POPIS` — description;
- `N_POZIAD_TYP` — source type;
- `NAZOV_PRODUKT`, `KOD_PRODUKT` — product;
- `N_PRIORITY` — source priority;
- `N_STAVY_AKT` — current source status;
- `D_ZADANIE` — created date;
- `D_REALIZACIE_DO` — due date;
- `D_UKONCENIE` — completed date;
- `RIESITEL` — assignee / resolver;
- `NAZOV_ZAK` — customer;
- `ZADAVATEL` — reporter / requester.

The meaning of additional RM columns must not be inferred from their names alone. Add fields only when a concrete use case defines their semantics and expected behavior.

## Solution boundaries

The first phase does not include:

- write-back to RM, Planner, or GitHub;
- comment synchronization;
- a unified workflow that replaces source-system workflows;
- automatic business decisions about priority or status;
- migration of source-system data;
- a final Azure topology before it is explicitly approved through an issue and, when appropriate, an ADR.

## Domain terms

**Work Item** — a normalized record that can be shown in the consolidated view.

**Source** — the system from which a work item originates (`RM`, later `PLANNER` or `GITHUB`).

**External ID** — the work-item identifier in the source system. For RM, this is `I_POZIAD`.

**Source status** — the original status from the source system. A normalized cross-source status may be introduced only after an explicit mapping is approved.

**Connector / adapter** — code that isolates the technical and data-specific behavior of one source system from the shared application model.

## External systems and dependencies

- RM/helpdesk / `VW_RM_POZIAD` — initial source;
- Microsoft Graph / Planner — planned source;
- GitHub API — planned source;
- Azure — target cloud environment;
- GitHub — source control, issues, pull requests, and CI/CD.

## Document owner

Assign the responsible role or team before production development begins.

## Last reviewed

2026-08-26

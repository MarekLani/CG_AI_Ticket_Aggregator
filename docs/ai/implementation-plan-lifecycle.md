# Implementation Plan Lifecycle

Use these sources for different purposes:

- the GitHub issue defines **what outcome is required**;
- when a plan is required, the latest human-approved canonical issue comment named `Implementation Plan` defines **how the change will be implemented**;
- the pull request records **what actually changed** and how the result was validated.

Maintain one canonical `Implementation Plan` comment per issue. When the plan changes, update that comment, including its status, version, last-updated date, and change history.

A `Draft` plan is not an approved input for implementation.

Do not copy every historical implementation plan into the repository merely for archival purposes. Move only durable decisions into the appropriate long-lived source, for example:

- engineering standards;
- architecture documentation;
- an ADR;
- product documentation.

If the implementation materially deviates from the approved plan, stop and have the responsible developer update or explicitly supersede the plan before continuing.

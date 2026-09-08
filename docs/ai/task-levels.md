# Task Levels and Expected Workflow

The amount of process should match the likely impact of a mistake. Use the simplest workflow that provides enough confidence for the task.

A human developer confirms the task level before implementation.

## Level 1 — Small, low-risk task

Use for a narrow, well-understood, local change with low impact.

Typical examples:

- copy or documentation changes;
- a small UI adjustment;
- a straightforward bug fix with clearly defined expected behavior;
- a test-only improvement;
- a small refactor in one well-understood area.

Typical flow:

`approved issue -> branch -> implementation -> tests/validation -> PR -> human review -> merge`

A separate implementation plan and AI review are normally not required.

## Level 2 — Standard task

Use as the default for new functionality or a non-trivial fix.

Typical examples:

- a new UI flow;
- a backend behavior change;
- a change spanning multiple files or modules;
- a new connector capability;
- a meaningful refactor;
- a feature slice that includes tests.

Typical flow:

`approved issue -> planning agent -> human-approved Implementation Plan -> branch -> implementation -> tests/validation -> draft PR -> CI -> AI review when useful -> human assessment -> fixes -> human review -> merge`

The implementation plan should be concise and practical.

## Level 3 — High-risk or architectural task

Use when an undetected mistake could have significant security, data, operational, cost, or architectural impact.

Typical examples:

- authentication or authorization;
- customer or production data handling;
- database schema changes or migrations;
- public API contract changes;
- infrastructure or Terraform changes;
- security-sensitive behavior;
- major cross-module or architectural changes.

Typical flow:

`approved issue -> full plan -> human approval -> ADR when needed -> implementation -> tests/validation -> draft PR -> CI -> mandatory AI review -> human findings assessment -> remediation plan when needed -> human review -> merge`

Infrastructure and Terraform changes are high-risk by default unless a human explicitly classifies a narrowly scoped change otherwise.

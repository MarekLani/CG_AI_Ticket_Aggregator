# ADR 0005: Use a layered automated testing strategy

- Status: Accepted
- Date: 2026-09-02

## Context

The application combines a React browser client, a .NET isolated Azure Functions backend, externally owned source systems, and potentially PostgreSQL persistence. Automated tests need useful confidence without making normal development or pull-request validation depend on protected customer or cloud environments.

## Decision

Use a layered automated testing strategy.

- keep application and domain behavior testable independently of hosting and externally owned systems;
- isolate Helpdesk, Planner, GitHub, Azure, and other protected external systems at defined connector or network boundaries for normal pull-request tests;
- when technology-specific integration semantics matter and the dependency can be run locally/ephemerally, test against the real technology; PostgreSQL persistence tests therefore use real PostgreSQL semantics rather than an in-memory substitute;
- frontend behavior is primarily tested with component/integration tests that exercise the real frontend API client and state/query layers while replacing backend responses at the HTTP boundary;
- reserve full browser end-to-end tests for a small number of critical cross-component user journeys;
- use the smallest test level that provides the required confidence instead of repeating the same behavior exhaustively at every layer.

Concrete testing frameworks and implementation rules are defined under `docs/standards/testing/`.

## Not decided here

- numeric code-coverage thresholds;
- performance/load-test tooling;
- visual-regression tooling;
- mutation testing;
- exact end-to-end CI cadence or browser matrix;
- live integration-test environments for Helpdesk, Planner, GitHub, or protected Azure resources.

## Consequences

- application boundaries must remain replaceable by controlled test doubles where appropriate;
- persistence integration tests may require a container runtime in development and CI;
- browser end-to-end tests may require browser tooling in CI when those tests are introduced;
- normal pull-request validation must remain independent of production credentials and protected external-system availability;
- test-framework/library choices may evolve through standards without changing this testing architecture.

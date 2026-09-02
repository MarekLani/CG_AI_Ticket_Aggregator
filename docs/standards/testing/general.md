# Testing standard

## Scope

Applies to automated tests in this repository. Testing architecture is defined in ADR 0005; backend- and frontend-specific tooling and rules are defined in the sibling standards.

## Test selection and quality

- Test externally observable behavior, important mappings, contracts, validation, and failure behavior rather than private implementation details.
- Use the smallest test level that proves the behavior with adequate confidence. Do not duplicate the same assertions across unit, integration, and end-to-end tests without a concrete reason.
- Keep tests deterministic and independently runnable. Tests must not depend on execution order, shared mutable state, arbitrary network availability, or wall-clock timing when those dependencies can be controlled.
- Do not use arbitrary sleeps to make asynchronous tests pass; wait for observable conditions or use controlled time where appropriate.
- A bug fix should include a focused regression test when practical.
- Do not weaken assertions, validation, or production behavior merely to make tests pass.

## Test data and external environments

- Use synthetic or anonymized test data. Follow `docs/standards/security/general.md` for secrets and sensitive data.
- Normal pull-request tests must not require production credentials or protected Helpdesk, Planner, GitHub, Entra, Azure, or other customer environments.
- Tests that intentionally require a protected/live integration environment must be clearly separated from normal PR validation and require explicit approved scope.

## Coverage

- Code coverage is a diagnostic signal, not the goal of the test suite. Add tests based on behavior and risk rather than to increase a percentage alone.
- No numeric coverage threshold is defined. Introducing one requires an explicit decision.

When testing work requires a decision left open by ADR 0005, stop and ask rather than inventing the policy or environment.

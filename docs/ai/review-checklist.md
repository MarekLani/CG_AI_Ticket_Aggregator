# Review Checklist

- The approved scope and acceptance criteria are satisfied without unplanned behavior.
- The latest approved implementation plan was followed when a plan was required.
- No unexplained business rule, mapping, default, or source-system semantic was introduced.
- Module boundaries and dependency direction are respected.
- API contracts and data changes are intentional and compatible with the approved scope.
- Errors, cancellation, timeouts, and external failures are handled appropriately.
- Secrets and sensitive data are absent from code, logs, tests, examples, and documentation.
- Tests cover the changed behavior at an appropriate level.
- CI, validation, and security controls were not bypassed or weakened.
- Infrastructure changes include an appropriate deployment, recovery, or rollback approach and do not introduce unnecessary privilege.
- Documentation and ADRs were updated when durable behavior or decisions changed.
- The PR does not contain unrelated refactoring or scope expansion.

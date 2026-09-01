# Layering and dependencies

The source-neutral application/domain layer must not depend on concrete database drivers, Microsoft Graph SDK, GitHub SDK, web framework transport DTOs or Azure SDK types.

Integration/infrastructure layers may implement interfaces required by the application layer.

Frontend depends on the backend HTTP contract, not source APIs.

Infrastructure-as-code is separate from runtime application logic.

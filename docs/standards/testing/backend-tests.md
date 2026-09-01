# Backend tests

Prioritize:
- source DTO -> WorkItem mapping tests;
- query/filter use-case tests;
- API contract/serialization tests;
- connector error/cancellation tests;
- persistence tests only after persistence exists.

Do not make standard unit tests depend on Oracle, Planner, GitHub or Azure availability.

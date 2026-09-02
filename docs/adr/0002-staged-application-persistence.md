# ADR 0002: Introduce application persistence only when justified

- Status: Accepted
- Date: 2026-09-01

## Context

The first Unified Work Items vertical slice is read-only and can retrieve Helpdesk work items through the source connector, map them to the unified model, and return them through the HTTP API without owning persistent application state.

Adding a database immediately would introduce schema management, migrations, local database setup, deployment dependencies, credentials, and operational work before there is a concrete persistence requirement.

The project is expected to need application-owned persistence later when it starts synchronizing multiple sources or needs a durable read model. PostgreSQL is the preferred relational database technology for the project when that need appears.

## Decision

### Phase 1: no application database

Do not introduce an application database for the initial read-only vertical slice.

The initial flow is:

```text
Source system -> connector -> unified application model -> HTTP API -> frontend
```

Source systems remain systems of record. The application must not persist data merely because persistence is expected later.

### Phase 2: introduce persistence on a concrete requirement

Introduce application-owned persistence when an approved issue demonstrates a need such as:

- background synchronization and a durable normalized read model;
- aggregation that should not depend on all source systems being available during each HTTP request;
- source API rate-limit or latency constraints;
- historical or synchronization metadata that must survive process restarts;
- saved user/application state that cannot remain transient;
- query or filtering requirements that are impractical against live source APIs.

When relational application persistence is introduced, the preliminary default is:

- PostgreSQL;
- Entity Framework Core;
- Npgsql EF Core provider;
- code-first model and schema evolution;
- EF Core migrations committed to the repository.

This is a default direction, not a requirement to add PostgreSQL before a persistence use case exists. A materially different persistence requirement may justify a new ADR.

### Database ownership

EF Core manages only the schema owned by Unified Work Items.

The Helpdesk Oracle schema and other source-system schemas are externally owned. The application may read them through connectors, but must not manage them with EF Core migrations.

### Migration execution

Local development may use normal EF Core tooling to create and apply migrations.

Production schema migration is a deployment concern. Automated deployment should apply reviewed migrations through a dedicated migration step, such as an EF Core migration bundle, using deployment credentials appropriate for schema changes.

Azure Functions must not automatically run schema migrations during host startup or normal function invocation.

The normal runtime database identity should not require schema-management permissions.

## Consequences

- the first vertical slice stays simpler and teaches only infrastructure that is needed at that stage;
- persistence can be introduced later without changing the source-neutral application model;
- PostgreSQL and EF Core provide a consistent default once relational persistence is justified;
- schema evolution is versioned with application code through EF Core migrations;
- deployment must eventually include an explicit database migration step;
- the team must revisit this ADR if persistence requirements no longer fit a relational PostgreSQL model.

## Alternatives considered

### PostgreSQL from the first vertical slice

Rejected because it adds operational and development complexity before the application has persistent state to own.

### Embedded/local database as the production persistence model

Not selected as the default because the backend may run on multiple Azure Functions instances and the project already prefers PostgreSQL for relational persistence.

### Database-first schema ownership for the application database

Not selected. The application owns its future persistence model, so code-first EF Core migrations provide the preferred versioned schema workflow.

# React / TypeScript frontend standard

## Scope

Applies to `src/frontend/`.

This file defines project-specific frontend decisions. It is intentionally concise; load the specialized UI, API, testing, security, or observability standards only when the task touches those concerns.

## Standard stack

Use:

- React;
- TypeScript with strict type checking;
- Vite;
- Material UI (`@mui/material`);
- MUI X Data Grid Community (`@mui/x-data-grid`) for data-heavy tabular views;
- TanStack Query for server state;
- React Router for routing.

Do not introduce overlapping frameworks or libraries without explicit approval. In particular, do not add another UI component library, data grid, router, server-state library, or global state library by default.

## Structure

Prefer feature-oriented organization under `src/frontend/src/`:

- `app/` — application bootstrap, providers, routing, and theme;
- `features/<feature>/` — feature-specific pages, components, hooks, models, and API code;
- `shared/` — code with demonstrated cross-feature reuse.

Do not move code to `shared/` only because it might be reused later.

## Mandatory rules

- UI communicates only with the application HTTP API, never directly with RM, Planner, or GitHub.
- Keep API access outside presentation components.
- Use TanStack Query for server state, request state, caching, and invalidation.
- Prefer component-local state or URL state for UI state. Add global client-state management only when explicitly justified.
- Use React functional components and hooks.
- Avoid `any` except at clearly isolated untyped external boundaries with an explanation.
- Keep server/source status labels as data; do not infer business meaning in presentation code.
- Prefer existing Material UI components before creating equivalent custom UI primitives.
- Use MUI X Data Grid Community for the primary work-item list and similar data-heavy tables.
- Do not introduce MUI X Pro or Premium features without explicit approval because they change the licensing requirement.
- Prefer small, focused components. Extract shared abstractions after a real reuse case exists rather than pre-building a custom design system.
- Model loading, empty, error, and populated states explicitly for user-facing data views.
- Preserve keyboard usability and accessible labeling for interactive controls.

## Dependencies

Before adding a frontend dependency, verify that the required capability is not already provided by React, Material UI, MUI X, TanStack Query, React Router, or existing project code.

Significant new dependencies must be called out in the implementation plan when one is required.

## Validation

Frontend changes should pass the repository-provided equivalents of:

- `npm run lint`;
- `npm run typecheck`;
- `npm run test`;
- `npm run build`.

For visual or interaction changes, also verify the affected flow in a browser.

Do not report a validation step as successful unless it was actually executed successfully.

## Load additional standards only when relevant

- user-facing layout, interaction, or visual behavior: `docs/standards/ui/design-system.md`;
- accessibility-sensitive UI behavior: `docs/standards/ui/accessibility.md`;
- HTTP contract or API integration changes: `docs/standards/api/http-api.md`;
- test changes: `docs/standards/testing/general.md` plus the relevant area-specific test standard;
- security-sensitive behavior: `docs/standards/security.md`;
- logging, telemetry, or diagnostics: `docs/standards/observability.md`.

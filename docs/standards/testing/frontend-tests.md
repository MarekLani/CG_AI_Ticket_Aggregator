# Frontend tests

## Scope

Applies to automated tests for the React/Vite frontend. Follow ADR 0005 and `general.md`.

## Toolchain

Use:

- Vitest as the frontend test runner;
- React Testing Library for component/page behavior;
- `@testing-library/user-event` for normal user interactions;
- `@testing-library/jest-dom` for DOM assertions;
- MSW for controlled HTTP/API responses;
- Playwright for selective full-browser end-to-end tests when critical cross-component flows exist.

The `npm run test` script must run tests once in deterministic non-watch mode for CI.

## Component and integration tests

- Test user-visible behavior through accessible roles, labels, text, and interactions rather than component internals, generated CSS classes, or framework-specific DOM structure.
- Prefer `user-event` over low-level `fireEvent` for normal interactions; use `fireEvent` only when the test genuinely requires a lower-level event.
- Exercise the real frontend API client and TanStack Query behavior. Use MSW at the HTTP boundary rather than mocking `fetch`, TanStack Query hooks, or feature query hooks by default.
- Use a fresh test `QueryClient` with deterministic test configuration; disable or bound retries where retry behavior is not the subject of the test.
- Exercise routing with an in-memory router/test router rather than mocking React Router hooks when route behavior matters.
- For Material UI and MUI X Data Grid, assert visible cells, controls, labels, state, and user interactions; do not depend on internal DOM nesting, generated class names, or virtualization implementation details.

Prioritize loading, empty, error, and populated states; filtering/search behavior; accessible keyboard/control interaction; and API contract adapters where frontend models transform server responses.

## Browser end-to-end tests

- Use Playwright only for critical journeys that need confidence across browser, routing, frontend, and backend boundaries. Do not reproduce the full component/integration suite as E2E tests.
- Keep E2E tests isolated and use user-facing locators and web-first assertions; do not use arbitrary sleeps for synchronization.
- Use controlled backend dependencies for normal E2E execution; protected/live-environment rules remain governed by `general.md`.
- Do not add Playwright tests merely to establish the framework before a meaningful cross-component user flow exists.

Follow `general.md` for test quality, test data, regression tests, coverage, and protected/live-environment rules.

# React / TypeScript frontend standard

## Scope

Applies to `src/frontend/`.

## Mandatory

- Use TypeScript with strict type checking.
- UI communicates only with the application HTTP API, never directly with RM/Planner/GitHub.
- Model loading, empty and error states explicitly.
- Keep server/source status labels as data; do not infer business meaning in presentation code.
- Prefer small reusable components after a real reuse case exists; avoid premature design-system abstraction.
- Avoid `any` except at clearly isolated untyped external boundaries with an explanation.
- User-facing tables and filters must be keyboard usable and have accessible labels.

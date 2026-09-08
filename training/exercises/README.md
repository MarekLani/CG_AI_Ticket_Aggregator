# Hands-on training exercises

This folder contains **training-only** starter material used by the presentations in `training/presentations/`.

It is not a source of production architecture or infrastructure implementation. In particular, production Azure/Terraform implementation for Unified Work Items belongs in the separate infrastructure repository defined by ADR 0001.

## Exercises

- [`containers/`](./containers/) — first Docker image/container exercise.
- [`terraform/`](./terraform/) — first Terraform/Azure exercise, including the transition from local state to a trainer-provided Azure Blob backend.

## Expected order

1. Complete the Containers exercise first. It introduces image, container, port mapping, lifecycle and image immutability.
2. Complete the Terraform exercise afterwards. It deploys a small disposable Azure workload and uses Terraform state as the main collaboration lesson.

All cloud resources created by the Terraform lab are temporary training resources and should be destroyed at the end of the exercise.

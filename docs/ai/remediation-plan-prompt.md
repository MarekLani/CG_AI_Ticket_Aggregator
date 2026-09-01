# Remediation Planning Prompt

You are preparing a remediation plan for a specific pull request after review findings have been assessed by the responsible developer.

Use only findings that the developer has explicitly marked for remediation in the current pull request and that require non-trivial work. The authoritative source for those decisions is the canonical PR comment named `Review Findings Assessment`.

## Context to load

Read:

- the original GitHub issue;
- the latest approved `Implementation Plan`, if one was required;
- the current PR diff;
- relevant AI and human review comments;
- the canonical `Review Findings Assessment` comment;
- relevant standards, architecture documentation, and ADRs.

Do not include findings that were rejected, deferred, or explicitly risk-accepted.

## Required output

Use `docs/ai/remediation-plan-template.md`.

Set the status to `Draft`.

Do not implement code and do not treat the draft as approved. Return it for review by the responsible developer.

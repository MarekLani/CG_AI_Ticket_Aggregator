# Human Launch Prompt Cookbook

This file is for human developers who want copy-ready examples for invoking the stable prompts under `docs/ai/`.

It is deliberately excluded from normal agent context by `AGENTS.md` to avoid spending tokens on examples that are not needed for execution. Do not ask an agent to read this file merely to decide which stable prompt to use. The human selects an example, replaces the placeholders, and sends the resulting launch prompt.

The examples are not authoritative workflow rules. If an example ever conflicts with `AGENTS.md`, a stable prompt under `docs/ai/`, an approved plan, a standard, or an ADR, the authoritative source wins.

## Placeholder convention

Replace values in angle brackets before use, for example:

- `<ISSUE>` — GitHub issue number;
- `<PR>` — pull-request number;
- `<TASK_LEVEL>` — `Small / low risk`, `Standard`, or `High-risk / architectural`;
- `<PLAN_VERSION>` — approved `Implementation Plan` version;
- `<REMEDIATION_PLAN_VERSION>` — approved `Remediation Plan` version;
- `<WORKING_BRANCH>` — branch used for the change;
- `<BASE_BRANCH>` — normally `main`;
- `<ADDITIONAL_CONSTRAINTS>` — task-specific information not already recorded in an authoritative source.

Keep launch prompts short. Prefer references to GitHub issues, PRs, plans, standards, and ADRs over copying their contents into the prompt.

## Permission patterns

Use explicit wording for operations that write to Git or GitHub.

### Read-only / return output only

```text
Do not modify files, create commits, push branches, or write to GitHub.
Return the result for human review.
```

### Local implementation only

```text
Local file changes are allowed.
Do not commit, push, or write to GitHub.
Return the implementation report and proposed pull-request body for human review.
```

### Publish an initial implementation

For a new implementation PR, commit, push, and draft-PR creation form one permission set.

```text
Git permissions: commit and push are allowed.
GitHub permissions: create one draft pull request after successful validation.
No other GitHub writes are allowed.
Do not mark the PR ready for review, approve it, or merge it.
```

### Update an existing PR branch

```text
Git permissions: commit and push to the existing PR branch are allowed.
GitHub permissions: do not create another pull request and do not perform other GitHub writes.
Do not mark the existing PR ready for review, approve it, or merge it.
```

# 1. Issue authoring

## 1.1 Prepare an issue draft from rough notes

Use this when the requirement is not yet a reviewed GitHub issue.

```text
Prepare a GitHub issue draft using `docs/ai/issue-authoring-prompt.md`.

Rough requirement:
<ROUGH_REQUIREMENT>

Return the proposed title, labels, issue body, open questions, proposed task level,
and planning recommendation for human review.
Do not create or update anything in GitHub.
```

## 1.2 Create an issue after the draft was reviewed by a human

Use this only after you have reviewed and approved the issue content yourself.

```text
Using `docs/ai/issue-authoring-prompt.md`, create the following human-reviewed issue in GitHub.

Approved issue title:
<APPROVED_TITLE>

Approved issue body:
<APPROVED_ISSUE_BODY>

Approved labels:
<APPROVED_LABELS>

GitHub permission: create this one issue.
Do not broaden, reinterpret, or otherwise change the approved scope. If GitHub requires a
non-trivial content change, stop and report it instead of deciding on my behalf.
```

# 2. Implementation planning

## 2.1 Prepare a standard implementation plan

```text
Prepare a draft implementation plan for GitHub issue #<ISSUE> using
`docs/ai/planning-agent-prompt.md`.

Task level: Standard, confirmed by the responsible developer.
Additional task-specific constraints: <ADDITIONAL_CONSTRAINTS_OR_NONE>.

Return the complete Draft `Implementation Plan` for human review.
Do not implement code and do not write to GitHub.
```

## 2.2 Prepare a high-risk / architectural implementation plan

```text
Prepare a draft implementation plan for GitHub issue #<ISSUE> using
`docs/ai/planning-agent-prompt.md`.

Task level: High-risk / architectural, confirmed by the responsible developer.
Pay particular attention to: <SECURITY_DATA_MIGRATION_API_INFRA_OR_OTHER_RISK_AREA>.
Additional task-specific constraints: <ADDITIONAL_CONSTRAINTS_OR_NONE>.

Identify any required ADR, rollback/recovery considerations, validation, and unresolved decisions.
Return the complete Draft `Implementation Plan` for human review.
Do not implement code and do not write to GitHub.
```

## 2.3 Re-plan after a material change

Use this when an already approved implementation plan can no longer be followed materially.

```text
Revise the implementation plan for GitHub issue #<ISSUE> using
`docs/ai/planning-agent-prompt.md` and `docs/ai/implementation-plan-lifecycle.md`.

Current canonical `Implementation Plan`: version <CURRENT_PLAN_VERSION>.
Reason for revision: <APPROVED_CHANGE_OR_NEW_INFORMATION>.
Prepare the next version as Draft and include the appropriate change-history entry.

Return the complete replacement `Implementation Plan` comment for human review.
Do not implement code and do not write to GitHub.
```

# 3. Initial implementation

## 3.1 Implement a small task directly from the issue and create a draft PR

```text
Implement GitHub issue #<ISSUE> using `docs/ai/implementation-agent-prompt.md`.

Task level: Small / low risk, confirmed by the responsible developer.
Work mode: Implement a small task directly from the issue.
Branch mode: create a new branch.
Working branch: <WORKING_BRANCH>.
Base branch: <BASE_BRANCH>.
Additional task-specific constraints: <ADDITIONAL_CONSTRAINTS_OR_NONE>.

Git permissions: commit and push are allowed.
GitHub permissions: create one draft pull request after successful validation.
No other GitHub writes are allowed.
Do not mark the PR ready for review, approve it, or merge it.
```

## 3.2 Implement an approved standard/high-risk plan and create a draft PR

```text
Implement GitHub issue #<ISSUE> using `docs/ai/implementation-agent-prompt.md`.

Task level: <STANDARD_OR_HIGH_RISK>, confirmed by the responsible developer.
Work mode: Implement an approved implementation plan.
Approved plan: canonical `Implementation Plan`, version <PLAN_VERSION>.
Branch mode: create a new branch.
Working branch: <WORKING_BRANCH>.
Base branch: <BASE_BRANCH>.
Additional task-specific constraints: <ADDITIONAL_CONSTRAINTS_OR_NONE>.

Git permissions: commit and push are allowed.
GitHub permissions: create one draft pull request after successful validation.
No other GitHub writes are allowed.
Do not mark the PR ready for review, approve it, or merge it.
```

## 3.3 Implement locally but do not publish

Use this when you want to inspect the implementation before allowing commits or GitHub writes.

```text
Implement GitHub issue #<ISSUE> using `docs/ai/implementation-agent-prompt.md`.

Task level: <TASK_LEVEL>, confirmed by the responsible developer.
Work mode: <SMALL_DIRECT_OR_APPROVED_IMPLEMENTATION_PLAN>.
Approved plan: <PLAN_REFERENCE_IF_REQUIRED>.
Branch mode: use the currently checked-out working branch.
Working branch: <WORKING_BRANCH>.
Base branch: <BASE_BRANCH>.

Local file changes are allowed.
Do not commit, push, or write to GitHub.
Run all relevant validation that can be executed.
Return the implementation report and proposed pull-request body for human review.
```

# 4. Pull-request review

## 4.1 Review a PR and return findings only

```text
Review pull request #<PR> using `docs/ai/review-agent-prompt.md` and
`docs/ai/review-checklist.md`.

Linked issue: #<ISSUE>.
Task level: <TASK_LEVEL>.
Approved implementation plan: <PLAN_REFERENCE_OR_NOT_REQUIRED>.
Additional review focus: <OPTIONAL_FOCUS_OR_NONE>.

Return the review for human assessment.
Do not modify code, approve or merge the PR, or post anything to GitHub.
```

## 4.2 Review a PR and post the review to GitHub

```text
Review pull request #<PR> using `docs/ai/review-agent-prompt.md` and
`docs/ai/review-checklist.md`.

Linked issue: #<ISSUE>.
Task level: <TASK_LEVEL>.
Approved implementation plan: <PLAN_REFERENCE_OR_NOT_REQUIRED>.
Additional review focus: <OPTIONAL_FOCUS_OR_NONE>.

GitHub permission: post the resulting AI review to pull request #<PR>.
Do not modify code, approve the PR, merge it, or make any other GitHub changes.
```

# 5. Human assessment of review findings

There is intentionally no agent prompt that decides whether findings are accepted, rejected, deferred, or risk-accepted. Those decisions belong to the responsible developer.

An agent can, however, mechanically format decisions that the human has already made.

## 5.1 Format a `Review Findings Assessment` comment from human decisions

```text
For pull request #<PR>, prepare the canonical `Review Findings Assessment` comment.

Use the existing review findings only as references. Do not independently accept, reject,
defer, risk-accept, or reclassify any finding.

Human decisions:
<HUMAN_FINDING_DECISIONS>

Return the complete comment for human review.
Do not post it to GitHub.
```

To allow posting after you have reviewed the formatted comment, replace the final line with:

```text
I have reviewed and approved these decisions.
GitHub permission: post this canonical `Review Findings Assessment` comment to PR #<PR>.
Do not make any other GitHub changes.
```

# 6. Simple accepted review fixes

Use this only when the canonical `Review Findings Assessment` marks findings as Accepted and the work is simple enough that the workflow does not require a separate `Remediation Plan`.

```text
Implement the simple accepted review fixes for pull request #<PR> using
`docs/ai/implementation-agent-prompt.md`.

Linked issue: #<ISSUE>.
Work mode: Implement simple human-approved review fixes.
Authoritative findings: canonical `Review Findings Assessment` in PR #<PR>.
Implement only the Accepted findings identified for fixing in the current PR and only where
no separate `Remediation Plan` is required.
Branch mode: use the existing pull-request branch.
Working branch: <PR_BRANCH>.
Base branch: <BASE_BRANCH>.

Git permissions: commit and push to the existing PR branch are allowed.
GitHub permissions: do not create another pull request and do not perform other GitHub writes.
Run relevant validation and report exactly what was executed.
Do not mark the PR ready for review, approve it, or merge it.
```

# 7. Remediation planning

Use a separate remediation plan only for human-accepted findings that require non-trivial bounded work in the current PR.

```text
Prepare a draft remediation plan for pull request #<PR> using
`docs/ai/remediation-plan-prompt.md`.

Linked issue: #<ISSUE>.
Authoritative assessment: canonical `Review Findings Assessment` in PR #<PR>.
Accepted non-trivial findings to include: <FINDING_IDS_OR_DESCRIPTIONS>.

Return the complete Draft `Remediation Plan` for human review.
Do not implement code and do not write to GitHub.
```

# 8. Approved remediation implementation

```text
Implement the approved remediation for pull request #<PR> using
`docs/ai/implementation-agent-prompt.md`.

Linked issue: #<ISSUE>.
Work mode: Implement an approved remediation plan.
Approved remediation plan: canonical `Remediation Plan`, version <REMEDIATION_PLAN_VERSION>,
in PR #<PR>.
Branch mode: use the existing pull-request branch.
Working branch: <PR_BRANCH>.
Base branch: <BASE_BRANCH>.
Additional task-specific constraints: <ADDITIONAL_CONSTRAINTS_OR_NONE>.

Git permissions: commit and push to the existing PR branch are allowed.
GitHub permissions: do not create another pull request and do not perform other GitHub writes.
Run relevant validation and report exactly what was executed.
Do not mark the PR ready for review, approve it, or merge it.
```

# 9. Choosing the shortest suitable prompt

Prefer the smallest launch prompt that makes the current run unambiguous:

- use issue authoring only while the requirement is still being turned into a reviewed issue;
- use planning only when the task level requires a plan or a human explicitly requests one;
- use direct implementation for a confirmed small/low-risk issue;
- use approved-plan implementation for standard/high-risk work;
- use PR review to produce findings, not to decide their disposition;
- use simple accepted-review-fix mode only for bounded findings already accepted by a human;
- use remediation planning and approved-remediation implementation only when accepted findings require non-trivial work.

Do not copy repository standards, ADRs, issue bodies, implementation plans, or PR diffs into the launch prompt when the agent can read them from their authoritative source.

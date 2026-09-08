# Training presentations

This folder contains HTML slide decks for the Cloud and AI Development training.

Open `00_index.html` first. It is the participant-facing agenda and navigation deck.

## Deck order

The numbering follows the first time the topic is introduced during the training. Some decks are intentionally revisited later.

1. `00_index.html` — Program školenia / agenda and navigation
2. `01_application_architecture_and_implementation.html` — Architektúra riešenia a postup implementácie
3. `02_git_github_actions.html` — Git, GitHub a GitHub Actions
4. `03_ai_assisted_development_workflow.html` — Proces vývoja s podporou AI
5. `04_containers_devcontainer_azure_hosting.html` — Kontajnery, Dev Container a Azure hosting
6. `05_terraform_iac.html` — Terraform a Infrastructure as Code

## Suggested training flow

- Start with the agenda in `00_index.html`.
- Introduce the application and implementation roadmap using deck 01.
- Explain GitHub work tracking, branches, pull requests and Actions using deck 02.
- Explain the AI-supported development process using deck 03.
- Do the first simple application exercise with dummy `WorkItem` data.
- Continue with Docker / Dev Container in deck 04.
- Continue with Terraform in deck 05.
- Return to deck 04 for Azure hosting and deck 02 for GitHub Actions / deployment.
- Return to deck 01 for further application implementation units.

Keyboard navigation inside decks: Arrow keys, PageUp/PageDown, Space.

## Important

These files are **training material, not canonical application documentation**. Product requirements, architecture, ADRs, engineering standards, and implementation decisions under `docs/` and the relevant GitHub issues remain authoritative.

Normal planning, implementation, and review agents must not load this folder as context unless the task explicitly asks them to work on the training presentations. See the root `AGENTS.md` and this folder's `AGENTS.md`.

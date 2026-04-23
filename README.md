# onboarding-kit

`onboarding-kit` is an agentic skills framework for onboarding. It provides reusable skills, tests, and docs that help agents follow a consistent, verifiable workflow from setup through contribution.

## How it works

Agents load and invoke skills automatically when a task matches a skill's trigger conditions. The entry point skill ensures agents check for and invoke relevant skills before acting.

Skill workflow chain:

`using-onboarding-kit` → `project-setup` → `contribution-workflow`

## Installation

Point your agent tooling at this repository's `skills/` directory.

- Claude Code: make the repository available to the Skill tool and invoke `using-onboarding-kit` first.
- Copilot CLI / cloud agent: configure this repository as an available skills source and select skills by `name` from each `SKILL.md` frontmatter.

## Basic Workflow

- `using-onboarding-kit`: enforces skill-first behavior and instruction priority before any action.
- `project-setup`: verifies local setup, tooling, and baseline test health before coding.
- `contribution-workflow`: enforces branch-first, test-driven, review-based contribution flow.

## Philosophy

- **Systematic over ad-hoc**: follow explicit checklists and hard gates.
- **Evidence over claims**: verify with commands, tests, and reproducible outputs.
- **Test-driven**: prefer small validated changes, with tests proving behavior.

## Contributing

When adding or editing skills, start from `skills/_template/SKILL.md`.

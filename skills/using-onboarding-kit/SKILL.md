---
name: using-onboarding-kit
description: Use when starting any task in this repository — establishes how to find and use onboarding skills before any action
---

## Overview
This is the entry-point meta-skill for all work in this repository. It enforces skill-first behavior so actions are guided by explicit process, not ad-hoc instincts.

<EXTREMELY-IMPORTANT>
If a skill might apply, invoke it. This is not optional.
</EXTREMELY-IMPORTANT>

## Instruction Priority
1. User instructions
2. Onboarding skills
3. Default behavior

## How to access skills
- Claude Code: use the Skill tool and invoke the relevant skill by name.
- Copilot CLI / cloud agent: load this repository as a skills source and invoke skills by frontmatter `name`.

## The Rule
Invoke relevant skills **BEFORE** any response or action.

```dot
digraph skill_flow {
  rankdir=LR;
  node [shape=box];
  user [label="User message"];
  check [label="Check for relevant skills"];
  invoke [label="Invoke skill"];
  announce [label="Announce invoked skill"];
  follow [label="Follow skill exactly"];
  respond [label="Respond / act"];

  user -> check -> invoke -> announce -> follow -> respond;
}
```

## Skill Priority
1. Process skills first (setup, debugging, workflow)
2. Implementation skills second

## Red Flags Rationalizations

| Thought | Why this is dangerous | Required action |
| --- | --- | --- |
| "I already know what to do." | Skips repository-specific process constraints. | Stop and check matching skills. |
| "This is too small for a skill." | Small tasks still cause process drift. | Invoke relevant skill first. |
| "I'll invoke the skill after I reply." | Violates ordering and creates inconsistent behavior. | Invoke before any response/action. |

## Skill Chain
`using-onboarding-kit` → `project-setup` → `contribution-workflow`

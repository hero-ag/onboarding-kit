#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/test-helpers.sh"

SKILL_FILE="${SCRIPT_DIR}/../skills/using-onboarding-kit/SKILL.md"
output="$(cat "${SKILL_FILE}")"

assert_contains "$output" "name: using-onboarding-kit" "using-onboarding-kit has correct name"
assert_contains "$output" "<EXTREMELY-IMPORTANT>" "extremely important block present"
assert_contains "$output" "Invoke relevant skills \*\*BEFORE\*\* any response or action" "rule requires skill invocation before action"
assert_contains "$output" '```dot' "contains Graphviz flowchart"
assert_contains "$output" 'using-onboarding-kit` → `project-setup` → `contribution-workflow' "declares skill chain"
assert_order "$output" "Instruction Priority" "## The Rule" "priority appears before rule section"

print_summary
[[ "$fail_count" -eq 0 ]]

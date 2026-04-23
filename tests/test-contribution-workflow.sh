#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/test-helpers.sh"

SKILL_FILE="${SCRIPT_DIR}/../skills/contribution-workflow/SKILL.md"
output="$(cat "${SKILL_FILE}")"

assert_contains "$output" "name: contribution-workflow" "contribution-workflow has correct name"
assert_contains "$output" "Do NOT modify files before creating a branch" "hard gate requires branch first"
assert_contains "$output" "type\(scope\): message" "conventional commit format present"
assert_contains "$output" '\| `feat` \|' "conventional commit types table includes feat"
assert_contains "$output" "I'll commit directly to main just this once" "rationalizations table includes direct-to-main anti-pattern"
assert_contains "$output" "Approved \+ CI green\?" "flowchart includes approval/CI decision"

print_summary
[[ "$fail_count" -eq 0 ]]

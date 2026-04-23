#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/test-helpers.sh"

SKILL_FILE="${SCRIPT_DIR}/../skills/project-setup/SKILL.md"
output="$(cat "${SKILL_FILE}")"

assert_contains "$output" "name: project-setup" "project-setup has correct name"
assert_contains "$output" "<HARD-GATE>" "hard gate present"
assert_contains "$output" "Do NOT write code until setup is verified" "hard gate rule text present"
assert_contains "$output" "Run the test suite and verify baseline is green" "baseline test check present"
assert_contains "$output" "Tests pass\?" "flowchart includes tests pass decision"
assert_contains "$output" 'Invoke `contribution-workflow` after setup is confirmed' "invokes next skill"

print_summary
[[ "$fail_count" -eq 0 ]]

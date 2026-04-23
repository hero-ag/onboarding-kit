#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERBOSE=0
TIMEOUT=60
TEST_FILE=""

usage() {
  cat <<USAGE
Usage: $0 [--test <file>] [--verbose] [--timeout <seconds>]

Options:
  --test <file>      Run a single test script (path or basename)
  --verbose          Print each test command before execution
  --timeout <secs>   Timeout passed to tests via SKILL_TEST_TIMEOUT (default: 60)
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --test)
      TEST_FILE="${2:-}"
      shift 2
      ;;
    --verbose)
      VERBOSE=1
      shift
      ;;
    --timeout)
      TIMEOUT="${2:-}"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if ! [[ "$TIMEOUT" =~ ^[0-9]+$ ]]; then
  echo "--timeout must be an integer number of seconds"
  exit 1
fi

export SKILL_TEST_TIMEOUT="$TIMEOUT"

declare -a tests
if [[ -n "$TEST_FILE" ]]; then
  if [[ -f "$TEST_FILE" ]]; then
    tests=("$TEST_FILE")
  elif [[ -f "${SCRIPT_DIR}/${TEST_FILE}" ]]; then
    tests=("${SCRIPT_DIR}/${TEST_FILE}")
  else
    echo "Test file not found: $TEST_FILE"
    exit 1
  fi
else
  tests=(
    "${SCRIPT_DIR}/test-using-onboarding-kit.sh"
    "${SCRIPT_DIR}/test-project-setup.sh"
    "${SCRIPT_DIR}/test-contribution-workflow.sh"
  )
fi

overall_fail=0
for test_script in "${tests[@]}"; do
  [[ "$VERBOSE" -eq 1 ]] && echo "Running: ${test_script}"
  if ! "${test_script}"; then
    overall_fail=1
  fi
  echo
done

if [[ "$overall_fail" -ne 0 ]]; then
  echo "Skill tests failed"
  exit 1
fi

echo "All skill tests passed"

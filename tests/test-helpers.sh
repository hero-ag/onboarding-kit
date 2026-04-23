#!/usr/bin/env bash

pass_count=0
fail_count=0

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

run_claude() {
  local prompt="$1"
  local timeout_seconds="${2:-60}"
  timeout "${timeout_seconds}" claude -p "$prompt"
}

assert_contains() {
  local output="$1"
  local pattern="$2"
  local name="$3"

  if printf '%s' "$output" | grep -E -q "$pattern"; then
    echo -e "${GREEN}PASS${RESET} ${name}"
    pass_count=$((pass_count + 1))
  else
    echo -e "${RED}FAIL${RESET} ${name}"
    fail_count=$((fail_count + 1))
  fi
}

assert_not_contains() {
  local output="$1"
  local pattern="$2"
  local name="$3"

  if printf '%s' "$output" | grep -E -q "$pattern"; then
    echo -e "${RED}FAIL${RESET} ${name}"
    fail_count=$((fail_count + 1))
  else
    echo -e "${GREEN}PASS${RESET} ${name}"
    pass_count=$((pass_count + 1))
  fi
}

assert_order() {
  local output="$1"
  local pattern_a="$2"
  local pattern_b="$3"
  local name="$4"

  local first_line
  local second_line

  first_line=$(printf '%s\n' "$output" | grep -n -m1 -E "$pattern_a" | cut -d: -f1)
  second_line=$(printf '%s\n' "$output" | grep -n -m1 -E "$pattern_b" | cut -d: -f1)

  if [[ -n "$first_line" && -n "$second_line" && "$first_line" -lt "$second_line" ]]; then
    echo -e "${GREEN}PASS${RESET} ${name}"
    pass_count=$((pass_count + 1))
  else
    echo -e "${RED}FAIL${RESET} ${name}"
    fail_count=$((fail_count + 1))
  fi
}

print_summary() {
  echo
  echo "Total PASS: ${pass_count}"
  echo "Total FAIL: ${fail_count}"
}

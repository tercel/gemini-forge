#!/usr/bin/env bash
# test-test-cases.sh — Static and headless validation for /test-cases
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "Testing /test-cases skill..."
echo ""
echo "Static validation:"

# Verify command file exists
assert_file_exists "$PROJECT_DIR/commands/test-cases.md" \
  "test-cases.md command file exists"

# Verify skill files exist
assert_file_exists "$PROJECT_DIR/references/test-cases/SKILL.md" \
  "Test Cases SKILL.md exists"
assert_file_exists "$PROJECT_DIR/references/test-cases/template.md" \
  "Test Cases template exists"
assert_file_exists "$PROJECT_DIR/references/test-cases/checklist.md" \
  "Test Cases checklist exists"
assert_file_exists "$PROJECT_DIR/references/test-cases/writing-guidelines.md" \
  "Test Cases writing-guidelines.md exists"
assert_file_exists "$PROJECT_DIR/references/test-cases/standards.md" \
  "Test Cases standards.md exists"

# Verify content in references
assert_file_contains "$PROJECT_DIR/references/test-cases/writing-guidelines.md" "test for real" \
  "test-cases guidelines mention real database testing"
assert_file_contains "$PROJECT_DIR/references/test-cases/standards.md" "TC-" \
  "test-cases standards define TC ID format"
assert_file_contains "$PROJECT_DIR/references/test-cases/writing-guidelines.md" "Data Integrity" \
  "test-cases guidelines mention data integrity testing"
assert_file_contains "$PROJECT_DIR/references/test-cases/SKILL.md" "Anti-Shortcut" \
  "test-cases SKILL.md contains Anti-Shortcut Rules"

# ── Headless Tests (require gemini CLI) ─────────────────────────────

echo ""
echo "Headless tests:"

if check_gemini_available; then
  run_gemini "Load the /test-cases skill and describe what it does. Do not execute it, just summarize its purpose and key sections." || true
  assert_contains "$GEMINI_OUTPUT" "Test Case" \
    "gemini recognizes test-cases skill"
  assert_contains "$GEMINI_OUTPUT" "Workflow" \
    "gemini mentions test-cases workflow"
else
  TESTS_SKIPPED=$((TESTS_SKIPPED+2))
fi

print_summary

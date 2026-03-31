#!/usr/bin/env bash
# test-prd.sh — Static and headless validation for /prd
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "Testing /prd skill..."
echo ""
echo "Static validation:"

# Verify command file exists
assert_file_exists "$PROJECT_DIR/commands/prd.md" \
  "prd.md command file exists"

# Verify skill files exist
assert_file_exists "$PROJECT_DIR/references/prd/SKILL.md" \
  "PRD SKILL.md exists"
assert_file_exists "$PROJECT_DIR/references/prd/template.md" \
  "PRD template exists"
assert_file_exists "$PROJECT_DIR/references/prd/checklist.md" \
  "PRD checklist exists"
assert_file_exists "$PROJECT_DIR/references/prd/writing-guidelines.md" \
  "PRD writing-guidelines.md exists"
assert_file_exists "$PROJECT_DIR/references/prd/standards.md" \
  "PRD standards.md exists"

# Verify content in references
assert_file_contains "$PROJECT_DIR/references/prd/writing-guidelines.md" "market" \
  "prd guidelines mention market analysis"
assert_file_contains "$PROJECT_DIR/references/prd/writing-guidelines.md" "feasibility" \
  "prd guidelines mention feasibility assessment"
assert_file_contains "$PROJECT_DIR/references/prd/writing-guidelines.md" "anti-pseudo-requirement" \
  "prd guidelines mention anti-pseudo-requirement principle"
assert_file_contains "$PROJECT_DIR/references/prd/standards.md" "Anti-Shortcut" \
  "prd standards contain Anti-Shortcut Rules"

# ── Headless Tests (require gemini CLI) ─────────────────────────────

echo ""
echo "Headless tests:"

if check_gemini_available; then
  run_gemini "Load the /prd skill and describe what it does. Do not execute it, just summarize its purpose and key sections." || true
  assert_contains "$GEMINI_OUTPUT" "Product Requirements Document" \
    "gemini recognizes prd skill"
  assert_contains "$GEMINI_OUTPUT" "Five-Step Workflow" \
    "gemini mentions prd workflow"
else
  TESTS_SKIPPED=$((TESTS_SKIPPED+2))
fi

print_summary

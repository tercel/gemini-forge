#!/usr/bin/env bash
# test-srs.sh — Static and headless validation for /srs
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "Testing /srs skill..."
echo ""
echo "Static validation:"

# Verify command file exists
assert_file_exists "$PROJECT_DIR/commands/srs.md" \
  "srs.md command file exists"

# Verify skill files exist
assert_file_exists "$PROJECT_DIR/references/srs/SKILL.md" \
  "SRS SKILL.md exists"
assert_file_exists "$PROJECT_DIR/references/srs/template.md" \
  "SRS template exists"
assert_file_exists "$PROJECT_DIR/references/srs/checklist.md" \
  "SRS checklist exists"
assert_file_exists "$PROJECT_DIR/references/srs/writing-guidelines.md" \
  "SRS writing-guidelines.md exists"
assert_file_exists "$PROJECT_DIR/references/srs/standards.md" \
  "SRS standards.md exists"

# Verify content in references
assert_file_contains "$PROJECT_DIR/references/srs/standards.md" "IEEE 830" \
  "srs standards reference IEEE 830"
assert_file_contains "$PROJECT_DIR/references/srs/writing-guidelines.md" "FR-" \
  "srs guidelines define FR ID format"
assert_file_contains "$PROJECT_DIR/references/srs/writing-guidelines.md" "NFR-" \
  "srs guidelines define NFR ID format"
assert_file_contains "$PROJECT_DIR/references/srs/writing-guidelines.md" "Acceptance Criteria" \
  "srs guidelines mention acceptance criteria"

# ── Headless Tests (require gemini CLI) ─────────────────────────────

echo ""
echo "Headless tests:"

if check_gemini_available; then
  run_gemini "Load the /srs skill and describe what it does. Do not execute it, just summarize its purpose and key sections." || true
  assert_contains "$GEMINI_OUTPUT" "Software Requirements Specification" \
    "gemini recognizes srs skill"
  assert_contains "$GEMINI_OUTPUT" "IEEE 830" \
    "gemini mentions IEEE 830"
else
  TESTS_SKIPPED=$((TESTS_SKIPPED+2))
fi

print_summary

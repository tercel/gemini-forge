#!/usr/bin/env bash
# test-tech-design.sh — Static and headless validation for /tech-design
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "Testing /tech-design skill..."
echo ""
echo "Static validation:"

# Verify command file exists
assert_file_exists "$PROJECT_DIR/commands/tech-design.md" \
  "tech-design.md command file exists"

# Verify skill files exist
assert_file_exists "$PROJECT_DIR/references/tech-design/SKILL.md" \
  "Tech Design SKILL.md exists"
assert_file_exists "$PROJECT_DIR/references/tech-design/template.md" \
  "Tech Design template exists"
assert_file_exists "$PROJECT_DIR/references/tech-design/checklist.md" \
  "Tech Design checklist exists"
assert_file_exists "$PROJECT_DIR/references/tech-design/writing-guidelines.md" \
  "Tech Design writing-guidelines.md exists"
assert_file_exists "$PROJECT_DIR/references/tech-design/standards.md" \
  "Tech Design standards.md exists"

# Verify content in references
assert_file_contains "$PROJECT_DIR/references/tech-design/standards.md" "C4" \
  "tech-design standards reference C4 architecture diagrams"
assert_file_contains "$PROJECT_DIR/references/tech-design/writing-guidelines.md" "alternative solutions" \
  "tech-design guidelines require alternative solutions"
assert_file_contains "$PROJECT_DIR/references/tech-design/writing-guidelines.md" "Parameter Validation" \
  "tech-design guidelines mention parameter validation matrix"
assert_file_contains "$PROJECT_DIR/references/tech-design/writing-guidelines.md" "Boundary Values" \
  "tech-design guidelines mention boundary values"

# ── Headless Tests (require gemini CLI) ─────────────────────────────

echo ""
echo "Headless tests:"

if check_gemini_available; then
  run_gemini "Load the /tech-design skill and describe what it does. Do not execute it, just summarize its purpose and key sections." || true
  assert_contains "$GEMINI_OUTPUT" "Technical Design" \
    "gemini recognizes tech-design skill"
  assert_contains "$GEMINI_OUTPUT" "Seven-Step Workflow" \
    "gemini mentions tech-design workflow"
else
  TESTS_SKIPPED=$((TESTS_SKIPPED+2))
fi

print_summary

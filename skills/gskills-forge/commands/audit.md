---
description: "Perform a full-spectrum diagnostic (Scan + Audit) on an existing Gemini skill."
---

# Command: /gskills-forge:audit
**Goal**: Perform a full-spectrum diagnostic (Scan + Audit) on an existing Gemini skill.

## Procedure
1. **Tier 1: Structural Scan (Syntax & Compliance)**
   - Validate YAML frontmatter in `SKILL.md`.
   - Verify all file references and imports (`@./`).
   - Identify broken links or missing command files.
2. **Tier 2: Performance Audit (Context & Efficiency)**
   - Analyze instruction density; identify blocks > 2KB for context thinning.
   - Evaluate tool usage patterns (e.g., redundant directory listings).
   - Check for cross-agent delegation opportunities.
3. **Reporting**:
   - Generate a **Full-Spectrum Diagnostic Report** (`# GSG-DIAGNOSTIC-REPORT`).
   - Categorize by: `Critical (Errors)`, `Warning (Performance)`, and `Advisory (Best Practices)`.
   - **Persistence**: Suggest saving to `.gemini/audit-report.md`.

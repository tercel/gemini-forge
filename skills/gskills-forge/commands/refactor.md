---
description: "Optimize an existing Gemini skill based on audit findings or specific refactor goals."
---

# Command: /gskills-forge:refactor
**Goal**: Apply architectural optimizations to an existing Gemini skill for better performance and maintainability.

## Procedure
1. **Report Review**: 
   - Search session history for `# GSG-DIAGNOSTIC-REPORT`.
   - If not in history, check for `.gemini/audit-report.md`.
   - If no report found, run a quick scan.
2. **Context Merger**: 
   - Combine diagnostic findings with any user-provided `{{args}}`.
   - Prioritize user input if it conflicts with audit recommendations.
3. **Execution (Context Thinning)**: 
   - Extract procedural logic/documentation > 2KB from `SKILL.md` to `references/`.
   - Update `SKILL.md` with `@./references/file.md` imports.
4. **Execution (Tool Optimization)**:
   - Consolidate multiple turns into parallel tool calls.
   - Refine `grep_search` patterns for efficiency.
5. **Final Validation**:
   - Re-run structural checks (frontmatter, syntax).
   - Confirm no regression in instructions.
6. **Summary**: Report on Imports Fixed, Tools Mapped, and Context Thinned (bytes).

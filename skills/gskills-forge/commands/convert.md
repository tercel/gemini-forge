---
description: "Migrate and 'flatten' Claude Code skills into Gemini's orchestrator pattern."
---

# Command: /gskills-forge:convert
**Goal**: Migrate and "flatten" Claude Code skills into Gemini's orchestrator pattern.

## Procedure
1. **Source Discovery**: Locate Claude skills (e.g., in `.claude-plugin/` or `skills/`).
2. **Flattening**: 
   - Extract instructions from `.clinerules` or `.cursorrules`.
   - Merge disparate skill files into a single `SKILL.md`.
   - Move long logic blocks to `references/`.
3. **Tool Mapping**:
   - `edit` -> `replace`.
   - `search` -> `grep_search` / `glob`.
   - `shell` -> `run_shell_command`.

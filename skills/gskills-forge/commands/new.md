---
description: "Scaffold a professional, syntactically correct Gemini skill."
---

# Command: /gskills-forge:new
**Goal**: Scaffold a professional, syntactically correct Gemini skill.

## Procedure
1. **Interview**: Ask for name, description, and primary sub-commands.
2. **Scaffold**: 
   - Create `{name}/SKILL.md` (Main Orchestrator).
   - Create `{name}/commands/` (Command Logic & Registration).
     - For each subcommand, create `{name}/commands/{subcommand}.md` and `{name}/commands/{subcommand}.toml`.
   - Create `{name}/references/shared/` (Rules & Constants).
   - Create `{name}/templates/` (Scaffolding templates).
3. **Validation**: Call `gemini-forge check .` to verify.

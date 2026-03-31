# GSG-DIAGNOSTIC-REPORT: apcore-skills

**Date**: 2026-03-31
**Status**: ⚠ Needs Optimization & Refactor

## Executive Summary
The `apcore-skills` project is a high-complexity multi-repo management skill. While the conceptual architecture is sound, the implementation deviates from standard Gemini CLI patterns in ways that could cause execution failures or excessive context consumption.

---

## Tier 1: Structural Scan (Syntax & Compliance)

### Critical (Errors)
- **Invalid Import Location**: `SKILL.md` uses `@./` imports. These are only valid in command files (`commands/*.md`). When `SKILL.md` is loaded as a system prompt, these imports are treated as literal text and will NOT be resolved.
- **Dangling Command References**: `commands/sdk.md` and other command files are essentially empty stubs that reference `references/*/SKILL.md`. This double-hop is non-standard.
- **Missing Files**:
  - `references/shared/clap.md` (Referenced in `SKILL.md`)
  - `references/shared/api-extraction.md` (Referenced in `references/sdk/SKILL.md`, but file is named `api-extraction.md` in `references/shared/`)
- **Duplicate Logic**: `references/sdk/SKILL.md` and `references/sdk-workspace/skill-snapshot/SKILL.md` contain nearly identical logic for the SDK bootstrap process.

### Warning (Performance)
- **Non-Standard Sub-skill Naming**: Using `SKILL.md` for sub-commands (e.g., `references/sdk/SKILL.md`) is confusing to the orchestrator. These should be renamed to reflect their purpose (e.g., `procedure.md` or `logic.md`).
- **Path Inconsistency**: The main `SKILL.md` references `@./references/sdk/SKILL.md`, but the orchestrator in `commands/apcore-skills.md` tries to invoke `apcore-skills:sdk`, which expects a command file at `commands/sdk.md`.

---

## Tier 2: Performance Audit (Context & Efficiency)

### Critical (Context Usage)
- **High Instruction Density**: `references/sdk/SKILL.md` is ~10KB and `references/shared/ecosystem.md` is ~8KB. Loading these into the main context via `read_file` or literal imports will quickly exhaust the context window during a multi-step operation.
- **Redundant Logic**: The "Iron Law" and "Anti-Rationalization Table" are repeated across multiple files, adding unnecessary tokens.

### Advisory (Best Practices)
- **Sub-agent Delegation**: The skill correctly identifies Step 2 (API Extraction) and Step 4 (Scaffolding) as sub-agent candidates. This is a strong pattern that should be preserved and reinforced.
- **Dashboard Orchestration**: The `commands/apcore-skills.md` dashboard is a good entry point, but it should be optimized to use `generalist` for the heavy lifting of scanning multiple repositories.

---

## Tier 3: Recommendations

### 1. Flatten the Command Structure
Move the core logic from `references/*/SKILL.md` directly into `commands/*.md`.
- **Action**: Refactor `commands/sdk.md` to include the content of `references/sdk/SKILL.md`.
- **Action**: Remove the `@./` imports from the main `SKILL.md` and use the `commands/` directory as the authoritative source for command procedures.

### 2. Optimize Shared Modules
Keep `references/shared/` for truly shared data (ecosystem detection, conventions), but ensure they are imported only when needed using `@./` in the specific command files.
- **Action**: Fix the broken reference to `clap.md`.
- **Action**: Standardize the name of `api-extraction.md`.

### 3. Context Thinning
- **Action**: Move the "Iron Law" and "Quality Standards" to a single `references/shared/conventions.md` file and reference it rather than duplicating it.
- **Action**: Strip implementation details from the main `SKILL.md` to keep the "System Prompt" part of the skill lean.

### 4. Fix Dispatch Logic
- **Action**: Ensure `commands/apcore-skills.md` correctly dispatches to the internal command files (`/apcore-skills:sdk`, etc.) rather than assuming the orchestrator knows how to resolve the `references/` paths.

---

## Audit Persistence
This report has been saved to `.gemini/audit-report.md`. It is recommended to run `/gskills-forge:refactor` following these recommendations.

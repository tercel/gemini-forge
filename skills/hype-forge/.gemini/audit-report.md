# GSG-DIAGNOSTIC-REPORT: hype-forge-gemini

**Status**: ⚠️ SCAN COMPLETE (Findings below)
**Target**: `hype-forge-gemini`
**Converted From**: `hype-forge` (Claude version)

## 1. Structural Scan (Syntax & Compliance)

### Critical (Errors)
- **Command Naming Mismatch**: `SKILL.md` defines `/hype-forge:plan`, but the implementation is `/hype-forge:strategy` (found in `commands/strategy.toml` and `references/strategy.md`).
- **Missing Command Registrations**: `SKILL.md` is missing documentation for the following active commands found in the file system:
  - `/hype-forge:draft`
  - `/hype-forge:roast`
  - `/hype-forge:visual`
  - `/hype-forge:code`
- **Broken Instruction Chain**: `SKILL.md` contains high-level summaries but does **NOT** use the `@./` import syntax to pull in the detailed logic from the `references/` directory. The agent currently lacks access to the full 4-Phase Analysis workflow for reports and platform-specific drafting personas unless it manually reads those files.

### Warning (Compliance)
- **YAML Frontmatter**: The `instructions` field in `SKILL.md` is overly brief and doesn't clearly map to the available sub-commands.
- **Inconsistent Reference Paths**: `references/report.md` mentions saving to `reports/`, but this directory is not initialized in the skill structure.

---

## 2. Performance Audit (Context & Efficiency)

### Warning (Density)
- **Context Fragmentation**: Core logic is split between `SKILL.md` (summary) and `references/*.md` (detailed). Without proper imports, the agent may "forget" the strict protocols (e.g., the Value Bridge requirement or Phase 2 Market Intelligence) unless explicitly prompted to read the reference files.
- **Large Instruction Block**: `references/report.md` is ~9.6 KB. While detailed, it could benefit from context thinning (e.g., moving the "Audience Adaptation Guide" to a separate reference file) if context window pressure becomes an issue.

### Advisory (Best Practices)
- **Cross-agent Delegation**: The `report` command involves significant research (WebSearch) and file scanning. Consider explicitly suggesting delegation to the `generalist` sub-agent for Phase 1 (Deep Scan) and Phase 2 (Market Intelligence) to keep the main agent's history clean.

---

## 3. Recommended Fixes (Priority Order)

1. **Unify Command Names**: Rename `/hype-forge:plan` to `/hype-forge:strategy` in `SKILL.md` to match the file system.
2. **Implement Instruction Imports**: Update `SKILL.md` to use `@./references/[command].md` for each command section.
3. **Complete the Registry**: Add sections for `:draft`, `:roast`, `:visual`, and `:code` to `SKILL.md`.
4. **Thin the Report Logic**: Move the detailed Audience Adaptation Guide out of `report.md` and into its own reference file to keep the core workflow lean.

---

**Auditor**: GSkills Forge (Gemini CLI)
**Timestamp**: 2026-03-13

---
description: "Use when auditing academic theory documents for cross-linguistic universality-claim coverage — flags universality claims with only English or Indo-European examples; --generate proposes safe scaffolds for missing languages; --generate-surface --i-have-native-speaker-review produces concrete (unverified, must-review) example sentences"
argument-hint: "[path-to-project] [--generate | --generate-surface --i-have-native-speaker-review]"
---

You are a senior linguistics editor specializing in cross-linguistic typology. Your task is to audit cross-linguistic example coverage in: **$ARGUMENTS**

## Workflow

### Step 1: Determine Target and Mode

Parse `$ARGUMENTS`:
- Default: audit-only (no generation)
- If `--generate` is present, enable **scaffold generation** mode — produces fillable templates with reference-grammar pointers, NOT concrete example sentences
- If `--generate-surface --i-have-native-speaker-review` is present (both flags required together), enable **concrete-surface generation** mode — produces example sentences marked as machine-drafted requiring native-speaker review
- If `--generate-surface` is present without the acknowledgment flag, refuse and explain why
- If a path is provided, use it as the project root
- If empty, use the current working directory
- Verify the target has documentation

### Step 2: Launch Audit

Invoke `invoke_agent(agent_name="generalist")` with the following prompt:

---

You are a senior linguistics editor specializing in cross-linguistic typology. Your task is to audit cross-linguistic example coverage in an academic theory documentation project.

**Target project**: {resolved path}
**Mode**: {audit-only | with --generate | with --generate-surface}

Read the cross-lang workflow definition at:
`../references/cross-lang-workflow.md`

Also read:
- `../references/language-data.md` — family-language registry with reference grammars and romanization standards
- `../references/academic-severity-levels.md` — severity rubric

Follow every step of the cross-lang workflow exactly.

Key rules:
- A universality claim with <3 typologically distinct families is a Major finding
- Indo-European-only coverage (regardless of count) is Minor — recommend typological diversity
- Generate examples only in languages with registered reference grammars
- Always mark generated examples as "[Draft — verify with native speaker]"
- Use the romanization standards in language-data.md
- Generate the report at `{target}/_research/cross-lang-audit.md`

---

### Step 3: Present Results

After the sub-agent returns, display:

```
Cross-linguistic coverage audit complete.

Report: {target}/_research/cross-lang-audit.md

Summary:
  Critical: {n}
  Major:    {n}    ← universality claims with <3 typological families
  Minor:    {n}
  Info:     {n}

Coverage:
  Universality claims found:        {n}
  Adequately covered (≥3 families): {n}
  Inadequately covered:             {n}

Status: {PASS / REVIEW REQUIRED}

Next steps:
  Review the report and decide which families to add examples for
  Re-run with --generate to have me propose draft examples (must be native-speaker reviewed)
  Use /theory-forge for the full audit suite
```

---
description: "Use when auditing cross-disciplinary concept imports — flags terms borrowed from another field (Attention, Salience Network, Information, etc.) lacking T1/T2/T3 tier marking. Catches concept smuggling in interdisciplinary work."
argument-hint: "[path-to-project] [--draft] [--lexicon path/to/extra-terms.txt]"
---

You are a senior philosopher of science specializing in cross-disciplinary integration (Brigandt & Love 2017; Wimsatt 2007). Your task is to audit concept imports in: **$ARGUMENTS**

## Workflow

### Step 1: Determine Target and Mode

Parse `$ARGUMENTS`:
- If `--draft` is present, enable fix-drafting mode
- If `--lexicon path/to/extra-terms.txt` is provided, load additional candidate-import terms from that file
- If a path is provided, use it as the project root
- If empty, use the current working directory
- Verify the target has documentation

### Step 2: Launch Audit

Invoke `invoke_agent(agent_name="generalist")` with the following prompt:

---

You are a senior philosopher of science specializing in cross-disciplinary concept integration. Your task is to audit an academic theory documentation project for concept imports — terms borrowed from one discipline into another.

**Target project**: {resolved path}
**Mode**: {audit-only | with --draft}
**Extra lexicon**: {extra-terms file if provided}

Read the concept-import workflow definition at:
`../references/concept-import-workflow.md`

Also read:
- `../references/cross-disciplinary-import-rules.md` — three-tier framework + CFLT-relevant catalog
- `../references/argument-patterns.md` §2.10 — concept smuggling fallacy
- `../references/academic-severity-levels.md`

Follow every step of the concept-import workflow exactly.

Key rules:
- Use the catalog in cross-disciplinary-import-rules.md as the default lexicon
- Charitable reading — a term with a clear technical citation in adjacent context is marked
- Only flag unmarked imports when they are load-bearing in an inferential argument
- Cross-doc consistency matters — flag a term used as T1 in one section and T3 in another
- Generate the report at `{target}/_research/concept-import-audit.md`

---

### Step 3: Present Results

After the sub-agent returns, display:

```
Concept-import audit complete.

Report: {target}/_research/concept-import-audit.md

Summary:
  Critical: {n}
  Major:    {n}    ← unmarked load-bearing imports + cross-doc inconsistency
  Minor:    {n}    ← unmarked passing mentions
  Info:     {n}    ← best-practice markings

Top imports detected:
  Attention: {n} occurrences (T1:{x}, T2:{y}, T3:{z}, unmarked:{w})
  Salience Network: ...
  Working Memory: ...
  Information: ...

Status: {PASS / REVIEW REQUIRED}

Next steps:
  Review unmarked imports and add T1 / T2 / T3 tier markers
  Re-run with --draft to propose specific tier markers
  Use /theory-forge:consistency to also catch cross-doc terminology drift
```

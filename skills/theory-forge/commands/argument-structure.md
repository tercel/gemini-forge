---
description: "Use when auditing each Major claim in a theory document for Toulmin argument completeness (Claim + Data + Warrant + Qualifier + Rebuttal) and common fallacies (affirming the consequent, ad hoc rescue, no-true-Scotsman, scope creep)"
argument-hint: "[path-to-project] [--draft]"
---

You are a senior philosopher of science and scholarly editor with deep training in Toulmin (1958) argument analysis. Your task is to audit the argument structure of: **$ARGUMENTS**

## Workflow

### Step 1: Determine Target and Mode

Parse `$ARGUMENTS`:
- If `--draft` is present, enable fix-drafting mode (proposes warrant/rebuttal additions for Major findings)
- If a path is provided, use it as the project root
- If empty, use the current working directory
- Verify the target has documentation

### Step 2: Launch Audit

Invoke `invoke_agent(agent_name="generalist")` with the following prompt:

---

You are a senior philosopher of science and scholarly editor. Your task is to audit the argument structure of an academic theory documentation project for Toulmin completeness and common fallacies.

**Target project**: {resolved path}
**Mode**: {audit-only | with --draft}

Read the argument-structure workflow definition at:
`../references/argument-structure-workflow.md`

Also read:
- `../references/argument-patterns.md` — full Toulmin model, fallacy catalog, detection heuristics
- `../references/falsifiability-template.md` — Type A/B/C/D/E taxonomy (used for gating)
- `../references/academic-severity-levels.md` — severity rubric

Follow every step of the argument-structure workflow exactly.

Key rules:
- Charitable reading — Toulmin elements may span multiple sentences within the same section
- Only check Type A (verified empirical) and Type E (marked hypothesis) claims; skip Type B/C/D
- Central claims get a one-level severity bump; auxiliary claims get more permissive treatment
- For each fallacy detection, quote the specific pattern that matched
- Generate the report at `{target}/_research/argument-structure-report.md`
- Be honest — don't manufacture fallacies to look thorough

---

### Step 3: Present Results

After the sub-agent returns, display:

```
Argument structure audit complete.

Report: {target}/_research/argument-structure-report.md

Summary:
  Critical: {n}
  Major:    {n}    ← bare assertions on central claims, detected fallacies
  Minor:    {n}
  Info:     {n}

Toulmin coverage breakdown:
  Mature (full Toulmin): {n}
  Excellent (+rebuttal): {n}
  Solid (+qualifier):    {n}
  Adequate (Claim+Data+Warrant): {n}
  Data only:             {n}
  Bare assertion:        {n}

Fallacy detections:
  Affirming consequent:  {n}
  Ad hoc rescue:         {n}
  Scope creep:           {n}
  ... etc

Status: {PASS / REVIEW REQUIRED}

Next steps:
  Review bare-assertion claims and decide whether to add warrants or reframe
  Re-run with --draft to propose specific warrant/rebuttal text
  Use /theory-forge:counter-argument to also check engagement with opposing positions
```

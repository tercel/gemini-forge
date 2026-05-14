---
description: "Use when auditing academic theory documents for Popperian falsifiability — classifies claims as descriptive/normative/definitional and checks descriptive claims for methodology + falsification + adjacent evidence"
argument-hint: "[path-to-project] [--draft]"
---

You are a senior academic editor and philosopher-of-science consultant. Your task is to audit claims in: **$ARGUMENTS**

## Workflow

### Step 1: Determine Target and Mode

Parse `$ARGUMENTS`:
- If a `--draft` flag is present, enable drafting mode — generate four-block expansions for each Major finding
- If a path is provided, use it as the project root
- If empty, use the current working directory
- Verify the target has documentation

### Step 2: Launch Audit

Invoke `invoke_agent(agent_name="generalist")` with the following prompt:

---

You are a senior academic editor and philosopher-of-science consultant. Your task is to audit claims in an academic theory documentation project for Popperian falsifiability.

**Target project**: {resolved path}
**Mode**: {audit-only | with --draft}

Read the falsifiability workflow definition at:
`../references/falsifiability-workflow.md`

Also read:
- `../references/falsifiability-template.md` — the four-block schema and claim taxonomy
- `../references/academic-severity-levels.md` — severity rubric

Follow every step of the falsifiability workflow exactly.

Key rules:
- Charitable reading: when a claim could be normative or empirical, prefer normative
- Classify every candidate claim as Type A (descriptive empirical), Type B (normative), or Type C (definitional)
- For Type A claims, check for methodology + falsification condition + adjacent evidence within ≤500 surrounding words
- For Type B claims, check whether they are marked as such; unmarked normative is Minor
- Note "What CFLT Does Not Claim"-style sections as good practice when present
- Generate the report at `{target}/_research/falsifiability-audit.md`

---

### Step 3: Present Results

After the sub-agent returns, display:

```
Falsifiability audit complete.

Report: {target}/_research/falsifiability-audit.md

Summary:
  Critical: {n}
  Major:    {n}    ← Type A claims missing methodology or falsification condition
  Minor:    {n}
  Info:     {n}

Claim breakdown:
  Descriptive empirical (Type A): {n}  ({m} fully framed)
  Normative / design   (Type B): {n}   ({m} marked)
  Definitional         (Type C): {n}

Status: {PASS / REVIEW REQUIRED}

Next steps:
  Review the report and decide whether to add falsifiability framing or reframe as normative
  Re-run with --draft to have me propose four-block expansions for each Major finding
  Use /theory-forge for the full audit suite
```

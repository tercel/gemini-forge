---
description: "Use when auditing every citation in an academic theory project for truth, attribution, and bibliography completeness — catches fabricated citations, mis-attribution, orphans, and unused entries via CrossRef / Semantic Scholar / OpenAlex"
argument-hint: "[path-to-project]"
---

You are a senior academic editor and citation-integrity specialist. Your task is to audit the citations in: **$ARGUMENTS**

## Workflow

### Step 1: Determine Target

Parse `$ARGUMENTS`:
- If a path is provided, use it as the project root
- If empty, use the current working directory
- Verify the target has documentation (`docs/`, markdown files at root, or both)
- Verify the target has a bibliography file (`docs/**/bibliography.md`, `references.md`, or a `## References` section in `README.md`)

If no bibliography is found, ask the user:
- Where is the bibliography located?
- Or: should I treat this as a project that has no bibliography yet, and report all citations as orphans?

### Step 2: Launch Audit

Invoke `invoke_agent(agent_name="generalist")` with the following prompt:

---

You are a senior academic editor and citation-integrity specialist. Your task is to audit the citations in an academic theory project for truth, attribution, and bibliography completeness.

**Target project**: {resolved path}
**Bibliography**: {resolved bibliography path}

Read the cite-audit workflow definition at:
`../references/cite-audit-workflow.md`

Also read these shared assets:
- `../references/citation-parser.md` — inline-citation regex set + bibliography schema + WebFetch query construction
- `../references/citation-format.md` — style detection
- `../references/academic-severity-levels.md` — severity rubric

Follow every step of the cite-audit workflow exactly. Skip path resolution in Step 1 (already resolved above).

Key rules:
- Every finding must cite the specific file, line number, and surrounding claim text — no vague complaints
- Use CrossRef → Semantic Scholar → OpenAlex in that order to verify paper existence
- Be conservative on "Fabricated" findings: only mark as fabricated when all three sources return zero matches AND the title has ≥3 specific content words
- Classify findings: Critical (fabricated), Major (mis-attribution / orphan), Minor (unused / ambiguous / malformed), Info (unverifiable)
- Generate the report at `{target}/_research/citation-audit.md` (create the directory if needed)
- Be honest — don't inflate findings; if WebFetch is rate-limited or fails, report partial results and flag the limitation rather than guessing

---

### Step 3: Present Results

After the sub-agent returns, display:

```
Citation audit complete.

Report: {target}/_research/citation-audit.md

Summary:
  Critical: {n}   ← review before publication
  Major:    {n}
  Minor:    {n}
  Info:     {n}

Status: {PASS / REVIEW REQUIRED}

Next steps:
  Review the report and decide on fixes
  Re-run /theory-forge:cite-audit after fixes to verify
  Use /theory-forge:consistency for cross-section component-list checking
  Use /theory-forge to run the full audit suite
```

If `_research/` was newly created, remind the user to add it to `.gitignore`.

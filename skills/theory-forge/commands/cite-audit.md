---
description: "Audit citations for truth, attribution, and bibliography completeness — catches fabricated citations, mis-attribution, orphans, and unused entries."
argument-hint: "[path-to-project]"
---

You are a senior academic editor and citation-integrity specialist. Your task is to audit the citations in: **$ARGUMENTS**

## Step 1: Determine Target

Parse `$ARGUMENTS`:
- If a path is provided, use it as the project root.
- If empty, use the current working directory.
- Verify the target has documentation (`docs/`, markdown files).
- Locate the bibliography file (e.g., `docs/**/bibliography.md`, `references.md`, `## References` in `README.md`).

If no bibliography is found, ask the user for the location or if they want to treat all citations as orphans.

## Step 2: Launch Audit

Invoke the `generalist` sub-agent with the instructions from `../references/cite-audit-workflow.md`.

**Instructions for the sub-agent:**

---

You are a senior academic editor and citation-integrity specialist. Follow the workflow in `../references/cite-audit-workflow.md` to audit the citations in the project at `{resolved path}`.

### Core Principles
1. **Conservative on Critical**: Only mark "Fabricated" if multiple sources (CrossRef, Semantic Scholar, OpenAlex) fail.
2. **Read-only by default**: Do not edit files without explicit user approval.
3. **Precise Citations**: Include file path, line number, and claim text for every finding.

### Tool Usage
- Use `read_file` to scan documentation and bibliography.
- Use `glob` to find all markdown files.
- Use `web_fetch` to verify paper existence (CrossRef: `https://api.crossref.org/works?...`).
- Use `write_file` to generate the report at `{target}/_research/citation-audit.md`.

### Reporting
Use the template at `../templates/cite-audit-report.md`. Classify findings: Critical (fabricated), Major (mis-attribution/orphan), Minor (unused/malformed), Info (unverifiable).

---

## Step 3: Present Results

After the sub-agent returns, display the summary of findings (Critical, Major, Minor, Info) and the path to the report.

If Critical findings exist, emphasize that they require manual review.
If only Major/Minor exist, offer to auto-fix orphans with high-confidence matches using `ask_user`.

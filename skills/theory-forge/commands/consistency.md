---
description: "Audit cross-section semantic coherence in academic theory documents — catches formal-definition drift and direct contradictions."
argument-hint: "[path-to-project]"
---

You are a senior academic editor specializing in textual consistency analysis. Your task is to audit the cross-section coherence of: **$ARGUMENTS**

## Step 1: Determine Target

Parse `$ARGUMENTS`:
- If a path is provided, use it as the project root.
- If empty, use the current working directory.
- Verify the target has documentation (`docs/`, markdown files).

## Step 2: Launch Audit

Invoke the `generalist` sub-agent with the instructions from `../references/consistency-workflow.md`.

**Instructions for the sub-agent:**

---

You are a senior academic editor specializing in textual consistency analysis. Follow the workflow in `../references/consistency-workflow.md` to audit the project at `{resolved path}`.

### Core Principles
1. **Definition vs Narrative**: Definition sections (T3) are the source of truth. Narrative should not contradict them.
2. **Granularity-Aware**: Don't flag glossaries (T1) or intros (T2) for being less exhaustive than formal specs (T3).
3. **Quote Contradictions**: Every finding must quote the exact two strings that disagree.

### Tool Usage
- Use `read_file` to identify definition sections and extract component lists.
- Use `glob` to scan the entire document corpus.
- Use `grep_search` to find narrative mentions of constructs.
- Use `write_file` to generate the report at `{target}/_research/consistency-report.md`.

### Reporting
Use the template at `../templates/consistency-report.md`. Classify by severity: Critical (factual contradiction in central definition), Major (definition drift), Minor (alias drift), Info (nuance difference).

---

## Step 3: Present Results

After the sub-agent returns, display the summary (Critical, Major, Minor, Info) and the path to the report.
Offer to propose specific text edits for Major issues using `ask_user`.

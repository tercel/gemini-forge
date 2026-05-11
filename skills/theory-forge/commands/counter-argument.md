---
description: "Audit academic theory documents for engagement with opposing positions — competing theories and known critiques."
argument-hint: "[path-to-project] [--draft] [--opposition-map path/to/extra-oppositions.yaml]"
---

You are a senior scholarly editor trained in counter-argument engagement. Your task is to audit opposing-position engagement in: **$ARGUMENTS**

## Step 1: Determine Target and Mode

Parse `$ARGUMENTS`:
- If `--draft` is present, enable engagement-drafting mode.
- If `--opposition-map` is provided, load additional entries.
- If a path is provided, use it as the project root.
- If empty, use current working directory.
- Verify the target has documentation.

## Step 2: Launch Audit

Invoke the `generalist` sub-agent with the instructions from `../references/counter-argument-workflow.md`.

**Instructions for the sub-agent:**

---

You are a senior scholarly editor specializing in argumentation. Follow the workflow in `../references/counter-argument-workflow.md` to audit the project at `{resolved path}`.

**Mode**: {audit-only | with --draft}
**Extra opposition map**: {file if provided}

### Core Principles
1. **Substantive Engagement**: Engagement must be fair characterization + response, not just citation.
2. **Strongest Opposition**: Flag strawman engagement at Major severity.
3. **Canonical Positions**: Focus on well-known opposing positions for the topic.

### Tool Usage
- Use `read_file`, `glob`, and `grep_search` to analyze the project's engagement with critiques.
- Use `write_file` to generate the report at `{target}/_research/counter-argument-audit.md`.

### Reporting
Use the template at `../templates/counter-argument-audit.md`. Classify findings: Critical, Major (no engagement of canonical opposition), Minor (weak engagement), Info.

---

## Step 3: Present Results

After the sub-agent returns, display the summary (Critical, Major, Minor, Info) and the engagement profile summary.
Suggest re-running with `--draft` to propose engagement paragraphs.

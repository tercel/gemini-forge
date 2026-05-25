---
description: "Use when reviewing code, handling review feedback, or posting a review to a GitHub PR — 15-dimension quality analysis for features or entire projects (generate mode), structured evaluation and response to incoming review comments."
---
# Code Forge — Review

## ⚡ Execution Entry Point (READ THIS FIRST)

**When this skill is loaded, you MUST immediately begin executing the Workflow below — do not wait, do not summarize, do not ask "what should I do now". Skills are operational manuals, not reference documents.** read_file Step 1 (Determine Scope), perform it, then Step 2, etc., until the workflow completes or you reach an `ask_user` checkpoint.

If the harness shows you `Successfully loaded skill · N tools allowed`, that message means **the SKILL.md content was injected into your context** — it does NOT mean the skill has run. Skills do not "run" autonomously; you run them by executing the Detailed Steps below.

If you find yourself about to say "the skill didn't produce output", "skill 仍未输出", "falling back to manual review", "回退到手动评审", or anything similar, **STOP**. You have misunderstood how skills work. Go directly to Step 1 of the Detailed Steps and start executing.

The first user-visible action of this skill should be either (a) the output of Step 1 of the workflow, or (b) an `ask_user` if Step 1 needs disambiguation. Never an apology, never a fallback, never silence.

---

Professional code review with 15 dimensions, including security, performance, and anti-bloat analysis. Supports GitHub PR integration.

## When to Use

- Implementation task is finished and needs quality check
- Reviewing a completed feature before merging
- Auditing an entire project for quality and technical debt
- Responding to human or AI code review comments
- **GitHub PR:** Posting a high-quality review comment to a GitHub Pull Request

## Examples

```bash
/code-forge:review user-auth          # Review specific feature
/code-forge:review                    # Auto-detect pending feature or review project
/code-forge:review --feedback         # Respond to review comments (from PR or file)
/code-forge:review --github-pr 123    # Post review to GitHub PR #123
/code-forge:review --generate         # Perform deep project audit (all source files)
```

## Workflow

```
Input Mode → Context Analysis → Pre-Analysis (Call-Graph) → Dimensional Review → Suppression Gate → Format
```

## Detailed Steps

@../references/shared/configuration.md

---

### Step 1: Determine Review Mode

Examine the arguments to determine the operating mode:

| Argument | Mode | Description |
|----------|------|-------------|
| `--github-pr [N]` | **GitHub PR Mode** | Read PR diff, post review to GitHub as a comment |
| `--feedback [@file]` | **Feedback Mode** | Respond to code review comments technical rigor |
| `--generate` | **Deep Project Audit** | Review entire project source for quality and debt |
| Feature Name | **Feature Mode** | Review all tasks and code for a specific feature |
| Empty (no args) | **Smart Detect** | Auto-detect pending feature or fallback to project mode |

- **GitHub PR Mode** → `read_file` and follow `@../references/review/github-pr-workflow.md`
- **Feedback Mode** → `read_file` and follow `@../references/review/feedback-workflow.md`
- **Deep Project Audit** → enter [Project Mode](#project-mode-reviewing-entire-project)
- **Feature Name** → enter [Feature Mode](#feature-mode-reviewing-a-feature)
- **Smart Detect** → if `state.json` found in `in_progress` or `completed` feature, use Feature Mode; else enter Project Mode

---

## Feature Mode — Reviewing a Feature

Use when a feature planned by code-forge:plan is ready for review.

### 1F: Locate Feature and Plan

1. Locate feature directory: search `{output_dir}/{feature_name}/` and `.code-forge/tmp/{feature_name}/`
2. Read `state.json`, `plan.md`, and all `tasks/*.md` files
3. Identify all files modified by the feature's tasks (collect from "Files Involved" sections)
4. Verify task completion status

### 2F: Detect Project Type

Analyze the codebase and tech stack:
- Profile: Web API / CLI / Frontend / etc. (PA.1)
- Language: TypeScript / Python / Go / etc.
- Risk Profile: security-sensitive? performance-critical? public SDK?

@../references/shared/project-analysis.md

### 3F: Dimensional Review (via Sub-agent)

**Execution Strategy:**
- **Single file or < 3 files:** execute in one pass
- **3+ files OR 2+ distinct module groups:** use Parallel Layered Review (Step 3F.4b / 3F.5)

#### 3F.4a: Single-Pass Review

Spawn a `generalist` sub-agent to perform the full review.

**Sub-agent prompt must include:**
- All modified files' content
- Feature `plan.md` and acceptance criteria
- Project Profile and Project Context Summary (PA.7)
- **DIMENSIONS REFERENCE (15 dimensions):** @../references/review/dimensions.md
- **CALL-GRAPH DISCIPLINE:** @../references/review/call-graph-discipline.md
- **SUPPRESSION GATES (Gates 1-5):** @../references/review/suppression-gates.md
- **SUB-AGENT RESPONSE FORMAT (YAML):** @../references/review/sub-agent-format.md
- **MANDATORY INSTRUCTION:** *"Before applying any dimension, you MUST build a call graph for every public method / exported function modified in the diff. Output as `METHOD_CHAINS` per format. Only after producing METHOD_CHAINS may you apply dimensions. Every `critical`/`blocker` finding MUST include non-empty `evidence`. All findings MUST pass through the five Suppression Gates before emission."*

#### 3F.4b: Parallel Layered Review (Multi-module)

When files span multiple module groups, dispatch multiple parallel `generalist` agents:
- One agent per module group (e.g., `src/api`, `src/services`)
- Each agent receives only its group's files + `plan.md` + `Project Context Summary`
- Each agent performs PA.3 (Deep Scan), PA.4 (Relationship Mapping), and building its group's `METHOD_CHAINS`
- Each agent applies intra-module dimensions (D1, D2, D3, D4, D6, D8, D9)
- Instruction: return `Per-Module Sub-agent Format` from `sub-agent-format.md`

#### 3F.5: Aggregation and Second-Order Review (Parallel Path Only)

After per-module sub-agents complete, spawn a final `generalist` "Aggregation Agent":
- Input: all `MODULE_REVIEW_SCOPE` results and `METHOD_CHAINS`
- Input: **DIMENSIONS REFERENCE:** @../references/review/dimensions.md
- Tasks:
  1. **Aggregation:** Merge all intra-module findings; resolve duplicate issues found by multiple agents.
  2. **Cross-Module Consistency Pass:** Apply the five patterns (coerce/guard, traceback, re-export, error-convention, defensive-depth) from `sub-agent-format.md` §CROSS_MODULE_CONSISTENCY.
  3. **Second-Order Review:** Identify fix patterns in the diff and verify they were applied uniformly across all modules (D-series prevention).
  4. **Deferred Dimensions:** Apply cross-cutting dimensions D5 (Architecture), D7 (Test Coverage), D10–D15 (Anti-bloat).
  5. **Final Verdict:** Compute overall Merge Readiness and Report Health metrics.

### 4F: Suppression-Gate Validation (Orchestrator Level)

**MANDATORY — do not trust the sub-agent's self-filtering.** The orchestrator MUST verify the following before displaying the report. If any check fails, **RE-INVOKE** the sub-agent with the specific violation before showing the user.

1. **`METHOD_CHAINS` Presence** — if missing or empty for a diff that modifies public symbols, re-invoke: *"Pre-analysis missing. You MUST build the call graph before applying dimensions."*
2. **`evidence` Presence (Critical/Blocker)** — if any critical/blocker finding lacks non-empty `evidence`, re-invoke: *"Found {N} critical/blocker findings missing evidence. Provide concrete trigger/behavior evidence or downgrade/drop."* If it fails twice, auto-downgrade to `warning`.
3. **`CANDIDATE_INVENTORY` Audit (Scratchpad-to-Dimension Cross-check)** —
   - **Bypass check:** Find findings in dimension blocks that were marked `DROP` in the scratchpad. **Drop them immediately** — the sub-agent is attempting to smuggle noise past the gate.
   - **Emptiness check:** Find KEEP candidates missing from dimension blocks. Re-invoke: *"Scratchpad says KEEP {id}, but it is missing from dimension blocks. Re-emit or update scratchpad."*
   - **Reason check:** Reject any `decision_reason` that is not in the fixed-enum list (see `sub-agent-format.md`). Re-invoke: *"Invalid decision_reason code: {code}. Use only the enum codes from §Pre-emission Scratchpad."*
4. **Speculative-Phrase Scan (ALL severities — DROP)** — Scan finding descriptions for speculative tells: `could theoretically`, `if .* ever`, `in case someone`, `potentially might`, `non-deterministic`, `might be nicer`, `smells wrong`, `feels off`. **Drop every match at any severity.** Do not downgrade; speculative findings are noise.
5. **Gate 5 Factual Claim Validation (ALL severities — DROP)** — For any finding containing Gate 5 trigger phrases (`zero references`, `dead code`, `only used in X`, `duplicates Y`, etc.): check `evidence` for (a) the actual `grep`/`rg` command + output OR (b) explicit file:line citations covering all relevant sites. **Drop every surviving unverified factual claim.**
6. **Trust-Boundary Check (Critical/Blocker)** — For `library`, `cli`, or `unknown` project types, scan evidence for internal/trusted sources (developer's own files, repo config, constants). **Auto-downgrade D1/D2 findings against internal sources to `warning`** (or `suggestion` if benefit not named). Skip for `frontend`/`backend`/`fullstack`.
7. **Warning-level Observable-Downside Check (DROP)** — Drop surviving warnings with no named observable downside (pure pattern/style divergence).
8. **Suggestion-level Concrete-Benefit Check (DROP)** — Drop surviving suggestions with no named concrete benefit.
9. **Suggestion Budget & Theme Consolidation** —
   - If ≥ 3 suggestions share the same (file, theme), merge them into one themed bullet listing all sites.
   - Limit total suggestions to 20 per report. If > 20, drop lowest-value suggestions first.

**Metric Computation (Report Health):**
- `LOC_reviewed`: total lines in modified files
- `finding_density`: `total_issues / (LOC_reviewed / 100)`
- `critical_share_pct`: `(critical_count + blocker_count) / total_issues * 100` (min total 10)
- `auto_downgrade_share_pct`: `n_auto_downgrades / total_issues_pre_downgrade * 100`
- `drop_share_pct`: `dropped_count / total_issues_raw * 100` (min raw 10)

### 5F: Format and Display

Display the final review report directly in the terminal using the markdown template:

@../references/review/report-template.md

---

## Project Mode — Reviewing Entire Project

Use for ad-hoc audits or deep quality analysis of an existing project.

### 1P: Define Scope

1. Use `glob` to scan source directory
2. Group files into modules/layers
3. Detect project type and tech stack (PA.1)
4. Use `ask_user` to confirm scope:
   - "Full project (all source files)"
   - "Specific directories/modules"
   - "Changes since {branch/commit}"

### 2P: Context Analysis

Perform full Project Analysis:

@../references/shared/project-analysis.md

### 3P: Dimensional Review (via Sub-agent)

Same logic as Feature Mode (Single-Pass or Parallel Layered), but:
- Analysis scope is the **entire file set** instead of just diffs
- Comparison is against **Project Analysis (PA.1-PA.6)** instead of a feature plan
- Dimension D15 (Simplification & Anti-Bloat) is prioritized to find project-wide duplication

### 4P: Suppression-Gate Validation

Apply the same five orchestrator-level checks and Report Health computation as Feature Mode Step 4F.

### 5P: Format and Display

Display the project review report using the markdown template.

---

## Technical Details

### 6.1 Dimensional Weights

Dimension tiers determine priority and rating:
- **Tier 1** (D1–D3): Blocker/Critical. If any found → overall rating `"needs_changes"`, readiness `"fix_required"`
- **Tier 2** (D4–D7, D15): Critical/Warning. If many found → rating `"acceptable"`, readiness `"ready"` (with notes)
- **Tier 3** (D8–D10): Warning/Suggestion. High-density might move rating to `"acceptable"`
- **Tier 4** (D11–D14): Suggestion only. Informational.

### 6.2 DIMENSIONS REFERENCE

@../references/review/dimensions.md

### 6.3 Verdict Emoji & Hints

The verdict line in the Report Health table displays the concatenated emoji of all raised flags, plus the text verdict. One hint line is displayed below the table per flag:

| Flag | Emoji | Trigger | Hint to display |
|---|---|---|---|
| `healthy` | ✅ | density ≤ 1.0, critical ≤ 5%, gated ≤ 15%, drop ≤ 20% | (none) |
| `noisy` | 🚨 | finding_density > 2.0 | High finding density (> 2.0/100 LOC) — likely nitpicking or quota-filling. Review individual issues for reader value. |
| `inflated` | 🚨 | critical_share_pct > 10% | High critical/blocker share (> 10%) — possible severity inflation. Verify reachability evidence for each issue. |
| `gated` | 🚨 | auto_downgrade_share_pct > 30% | High gate-intercept rate (> 30%) — sub-agent is systematically mis-classifying severities. |
| `fabricating`| 🚨 | drop_share_pct > 40% | Extremely high drop rate (> 40%) — the gate dropped nearly half the findings as speculative/benefit-less. Use caution; the remaining findings may also be hallucinated noise. |

---

## Coordination with Other Skills

- **After code-forge:impl**: run `/code-forge:review {feature}` to ensure quality
- **After code-forge:fix**: run `/code-forge:review` to verify the fix doesn't introduce debt
- **With spec-forge:feature**: the feature doc provides the "Reference" context for Step 3F/3P
- **Before /code-forge:finish**: a passing review is a prerequisite for merging

## Notes

1. **Review Context**: Parallel sub-agents keep the main context window lean while providing deep, multi-dimensional analysis.
2. **Actionable Suggestions**: Every issue MUST have a clear fix suggestion. Vague issues ("Code is complex") are rejected.
3. **Positive Feedback**: Review reports focus on issues, but "Overall Rating" and "Merge Readiness" provide balanced context.
4. **Git State**: Feature mode checks branch state and commit history for context.
5. **Consistency Pass**: Aggregation agent (layered review) specifically checks for pattern consistency across modules.
6. **Suppression Gates**: mandatory counter-pressure against the exhaustive bias of dimensional review. No report is final until it passes all five gates.

## Common Mistakes

- Skipping Step 4F orchestrator-level validation and showing raw sub-agent output
- Accepting findings with speculative phrasing ("could theoretically", "if X ever happens")
- Allowing D1/D2 findings on developer-authored internal input sources (Gate 2 failure)
- Missing `evidence` for critical/blocker findings
- Reporting pure pattern/style divergence as a `warning` instead of `suggestion` (or dropping it)
- Skipping the `METHOD_CHAINS` call-graph pre-analysis
- Fabricating findings to fill under-utilized dimensions (Gate 4 failure)
- Making factual claims ("zero references", "dead code") without actual `grep` command + output in `evidence` (Gate 5 failure)

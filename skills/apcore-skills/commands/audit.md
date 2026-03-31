---
description: "Ecosystem-wide audit for compatibility and standards. Checks API surface alignment, naming conventions, version synchronization, documentation quality, test coverage, dependency alignment, and configuration consistency across all repos."
argument-hint: "[--scope core|mcp|integrations|all] [--fix] [--save report.md]"
allowed-tools: [Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Task, TaskCreate, TaskUpdate, TaskList, TaskGet]
---

# Apcore Skills — Audit

Comprehensive consistency audit across all apcore ecosystem repositories.

## Core Mandates & Conventions

@./references/shared/conventions.md

## When to Use

- Before a major release to ensure ecosystem-wide consistency
- After adding a new SDK or integration to verify alignment
- Periodic health check (monthly recommended)
- When suspecting drift between implementations

## Command Format

```
/apcore-skills:audit [--scope core|mcp|integrations|all] [--fix] [--save report.md]
```

| Flag | Default | Description |
|------|---------|-------------|
| `--scope` | **cwd** | Which repo group to audit. **If omitted, defaults to the current working directory's repo only.** Use `--scope all` for full ecosystem audit. |
| `--fix` | off | Auto-fix issues where safe |
| `--save` | off | Save report to file |

## Audit Dimensions

The audit covers 8 dimensions: D1 (API Surface), D2 (Naming Conventions), D3 (Version Sync), D4 (Documentation), D5 (Test Coverage), D6 (Dependencies), D7 (Configuration), D8 (Project Structure).

## Context Management

**All dimension audits and per-repo fixes are executed by parallel sub-agents.** The main context handles orchestration, aggregation, and reporting.

## Workflow

```
Step 0 (ecosystem) → Step 1 (parse args) → Step 2 (parallel audits) → Step 3 (report) → [Step 4 (fix)]
```

## Detailed Steps

### Step 0: Ecosystem Discovery

@./references/shared/ecosystem.md

---

### Step 1: Parse Arguments and Plan Audit

Parse `$ARGUMENTS` for flags.

#### 1.1 CWD-based Default Scope

**If `--scope` is NOT specified:**
1. Detect CWD repo name (basename of CWD)
2. Look up in discovered ecosystem:
   - `core-sdk` repo → audit only this repo, dimensions D1-D3, D5-D6, D8
   - `mcp-bridge` repo → audit only this repo, dimensions D1-D3, D5-D6, D8
   - `integration` repo → audit only this repo, dimensions D2-D8
   - `protocol`/`docs-site` repo → audit documentation dimensions only (D4) for this repo
   - `shared-lib`/`tooling` repo → audit D2 (naming), D4 (docs), D5 (tests), D8 (structure) for this repo
   - CWD not an apcore repo → use `AskUserQuestion` to ask: "CWD is not an apcore repo. Which repo do you want to audit?" with options from `repos[]` names + "All repos (full ecosystem audit)"
3. Display: "Scope: {repo-name} (from CWD). Use --scope all for full ecosystem audit."

**If `--scope` IS specified:** use explicit scope.

#### 1.2 Scope → Repos & Dimensions

| Scope | Repos | Dimensions |
|---|---|---|
| `core` | Core SDKs | D1-D3, D5-D6, D8 |
| `mcp` | MCP bridges | D1-D3, D5-D6, D8 |
| `integrations` | Framework integrations | D2-D8 (no cross-API sync) |
| `all` | All repos | All dimensions |

Display:
```
Audit scope: {scope} {("(from CWD)" if defaulted)}
Repos: {count} repositories
Dimensions: {list}
```

---

### Step 2: Execute Audit Dimensions (Sub-agents)

Spawn **all dimension sub-agents in parallel (up to 8 simultaneously)** using `Agent(subagent_type="general-purpose")`. Each sub-agent audits exactly 1 dimension based on the prompts below.

- **D1 (API Surface)**: Compare public API alignment across languages.
- **D2 (Naming)**: Check naming conventions for files, functions, and classes.
- **D3 (Version Sync)**: Verify version alignment within sync groups and across version files.
- **D4 (Documentation)**: Check README, CHANGELOG, LICENSE, and docstring completeness.
- **D5 (Test Coverage)**: Verify tests/ existence, count files, and run test suites.
- **D6 (Dependencies)**: Audit dependency versions and alignment.
- **D7 (Configuration)**: Audit APCORE_* settings consistency (integrations only).
- **D8 (Structure)**: Verify project structure against conventions.

---

### Step 3: Aggregate and Display Report

Collect all findings from sub-agents. Aggregate by severity and dimension. Display a consolidated report with a summary table, detailed findings, and a health score.

If `--save` flag: write full report to specified path.

---

### Step 4: Auto-Fix (only with --fix flag)

Group fixable findings by repo. Separate unfixable findings (API surface, risky dependencies).

Spawn one `Agent(subagent_type="general-purpose")` **per repo that has fixable findings, all in parallel** to apply:
1. Naming fixes (D2)
2. Version fixes (D3)
3. Structure fixes (D8)
4. Doc fixes (D4)

After fixes, run the test suite to verify. Revert if tests fail. Display consolidated results.

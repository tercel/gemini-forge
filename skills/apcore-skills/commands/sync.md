---
description: "Unified cross-language consistency verification and documentation alignment. Phase A: verifies feature specs and protocol spec match implementation. Phase B: verifies documentation internal consistency."
argument-hint: "[repo1,repo2,...] [--phase a|b|all] [--fix] [--scope core|mcp|all] [--lang python,typescript,...] [--save]"
allowed-tools: [Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Task, TaskCreate, TaskUpdate, TaskList, TaskGet]
---

# Apcore Skills — Sync

Unified consistency verification across all apcore ecosystem documentation and implementations.

## Core Mandates & Conventions

@./references/shared/conventions.md

## When to Use

- After adding features to one SDK — verify all SDKs and their docs match
- Periodic consistency check across all language implementations
- Before a release to ensure all SDKs expose the same API surface and docs are accurate
- After API changes to sync usage examples and documentation across repos

## Command Format

```
/apcore-skills:sync [repo1,repo2,...] [--phase a|b|all] [--fix] [--scope core|mcp|all] [--lang python,typescript,...] [--save]
```

| Argument / Flag | Default | Description |
|------|---------|-------------|
| positional repos | — | Comma-separated repo names to sync. |
| `--phase` | `all` | Which phase to run: `a` (spec vs implementation), `b` (documentation internal consistency), `all` (A then B) |
| `--fix` | off | Auto-fix issues (naming, stubs, doc references) |
| `--scope` | **cwd** | Which group: `core`, `mcp`, `all`. Defaults to the current working directory's repo. |
| `--lang` | all discovered | Comma-separated list of languages to compare |
| `--save` | off | Save report to file |

## Context Management

**All per-repo operations use parallel sub-agents.** The main context handles orchestration, spec reference, comparison logic, and reporting.

## Workflow

```
Step 0 (ecosystem) → Step 1 (parse args) → PHASE A [Steps 2-5] → PHASE B [Steps 6-8] → Step 9 (combined report) → [Step 10 (fix)]
```

## Detailed Steps

### Step 0: Ecosystem Discovery

@./references/shared/ecosystem.md

---

### Step 1: Parse Arguments and Determine Scope

Parse `$ARGUMENTS` for all flags and positional repo names. Determine active phases, scope groups, language filter, fix mode, and target repos.

**Resolution priority:** Positional repo args > `--scope` flag > CWD-based default.

---

## PHASE A: Spec ↔ Implementation Consistency

### Step 2: Extract Public APIs (Parallel Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per implementation repo, all simultaneously** to extract the complete public API surface (classes, functions, enums, types, errors, constants).

### Step 3: Load Documentation Repo Reference

Read authoritative specs from the documentation repo (`apcore/` or `apcore-mcp/`), including `PROTOCOL_SPEC.md`, feature specs, and type mappings.

### Step 4: Checklist Comparison

Build an explicit per-symbol checklist and evaluate every item (existence, naming, parameters, return types, async flags) against the spec and across implementations.

### Step 5: Phase A Report

Display a report on spec compliance and cross-implementation consistency.

---

## PHASE B: Documentation Internal Consistency

### Step 6: Audit Documentation (Parallel Sub-agents)

Spawn sub-agents in parallel: **one per documentation repo** (check spec chain consistency, completeness, and cross-references) + **one per implementation repo** (check README, API references, example code, and tests for consistency with the verified API).

### Step 7: Cross-Repo Consistency

Perform cross-repo checks for API description consistency, shared documentation links, and example/test scenario coverage.

### Step 8: Phase B Report

Display a report on documentation repo internal consistency, implementation repo doc alignment, and cross-repo coverage.

---

### Step 9: Combined Report

Display a unified consistency report with combined findings sorted by severity. **ALWAYS append a review-compatible report** for consumption by `/code-forge:fixbug --review`.

---

### Step 10: Auto-Fix (only with --fix flag)

Group findings by repo and spawn one `Agent(subagent_type="general-purpose")` per repo to apply naming fixes, missing API stubs, doc fixes, example/test fixes, and resolve contradictions. Verify with tests and display results.

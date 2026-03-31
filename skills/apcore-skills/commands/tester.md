---
description: "Spec-driven test generation and cross-language behavioral verification. Generates test cases from authoritative specs and runs them across all language implementations in parallel."
argument-hint: "[<repos...>] [--spec <feature>] [--mode generate|run|full] [--category unit|integration|boundary|protocol|all] [--save report.md]"
allowed-tools: [Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Task, TaskCreate, TaskUpdate, TaskList, TaskGet]
---

# Apcore Skills — Tester

Spec-driven test generation and cross-language behavioral verification.

## Core Mandates & Conventions

@./references/shared/conventions.md

## When to Use

- After spec changes to generate/update tests across all implementations
- Before release to verify cross-language behavioral consistency
- When adding a new SDK to generate its full test suite from the spec
- When a bug is found in one language to verify all others aren't affected

## Command Format

```
/apcore-skills:tester [<repos...>] [--spec <feature>] [--mode generate|run|full] [--category unit|integration|boundary|protocol|all] [--save report.md]
```

| Flag | Default | Description |
|------|---------|-------------|
| `<repos...>` | **cwd** | Positional repo names to test. Defaults to CWD repo. |
| `--spec` | all features | Specific feature spec to test (e.g., `executor`, `registry`, `acl`). |
| `--mode` | `full` | `generate` = create test files only. `run` = execute existing tests only. `full` = generate then run. |
| `--category` | `all` | Test category filter: `unit`, `integration`, `boundary`, `protocol`, `all`. |
| `--save` | off | Save test report to file. |

## Context Management

**Test generation and test execution are performed by parallel sub-agents.** The main context handles spec analysis, orchestration, and aggregation of results.

## Workflow

```
Step 0 (ecosystem) → Step 1 (parse args + load specs) → Step 2 (generate tests) → Step 3 (run tests) → Step 4 (cross-language diff) → Step 5 (report)
```

## Detailed Steps

### Step 0: Ecosystem Discovery

@./references/shared/ecosystem.md

---

### Step 1: Parse Arguments and Load Specs

Parse `$ARGUMENTS` for repos, specs, mode, and category. Determine the spec repo and spec files for each target repo based on its type (core-sdk, mcp-bridge, etc.). Extract testable clauses from specs and build the test matrix.

### Step 2: Generate Tests (Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per target repo, all in parallel**, to generate test files based on the spec clauses for the assigned repo and language.

### Step 3: Run Tests (Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per target repo, all in parallel**, to run the full test suite and capture pass/fail status, total counts, and failure details.

### Step 4: Cross-Language Behavioral Diff

Compare test outcomes across languages for the same clause IDs. Identify inconsistencies where behavior differs between implementations for the same spec requirement.

### Step 5: Report

Display a consolidated report including test execution summary, cross-language consistency matrix, identified inconsistencies (critical), spec gaps, and coverage gaps.

---
description: "Coordinated multi-repo release orchestration. Handles version bumps, CHANGELOG generation, dependency updates, and test verification across all repos."
argument-hint: "<version> [--scope core|mcp|integrations|all] [--dry-run]"
allowed-tools: [Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Task, TaskCreate, TaskUpdate, TaskList, TaskGet]
---

# Apcore Skills — Release

Execute a coordinated release across multiple apcore ecosystem repositories.

## Core Mandates & Conventions

@./references/shared/conventions.md

## When to Use

- Releasing a new version of core SDKs (both Python and TypeScript together)
- Releasing a new version of MCP bridges (both together)
- Releasing an integration update
- Coordinated ecosystem-wide release

## Command Format

```
/apcore-skills:release <version> [--scope core|mcp|integrations|all] [--dry-run]
```

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `<version>` | Yes | — | Target version (e.g., `0.9.0`, `1.0.0`) |
| `--scope` | No | **cwd** | Which repos to release. Defaults to the current working directory's repo. |
| `--dry-run` | No | off | Show what would change without making changes |

## Context Management

Steps 3, 4, and 6 use parallel sub-agents (one per repo) for speed. The main context orchestrates phases and collects results.

## Workflow

```
Step 0 (ecosystem) → 1 (parse & validate) → 2 (pre-flight) → 3 (version bump) → 4 (changelog) → 5 (deps update) → 6 (test) → 7 (commit) → 8 (summary) → [9 (push)]
```

## Detailed Steps

### Step 0: Ecosystem Discovery

@./references/shared/ecosystem.md

---

### Step 1: Parse Arguments and Validate

Parse `$ARGUMENTS` for version, scope, and dry-run flag. Determine the release plan for core SDKs, MCP bridges, and integrations.

---

### Step 2: Pre-flight Checks (Parallel Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per repo, all simultaneously** to check git status (must be clean), current branch, current version, and recent tags.

### Step 3: Version Bump (Parallel Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per repo, all simultaneously** to update version references in build configs (`pyproject.toml`, `package.json`, `Cargo.toml`, etc.), source files (`__init__.py`, `index.ts`), and READMEs.

### Step 4: CHANGELOG Generation (Parallel Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per repo, all simultaneously** to generate a CHANGELOG entry from git history (categorized into Added, Changed, Fixed, Breaking, Docs, Other).

### Step 5: Cross-Repo Dependency Updates (Parallel Sub-agents)

Update apcore dependency versions in integration repos to match the new core SDK/MCP bridge versions being released.

### Step 6: Test Verification (Parallel Sub-agents)

Spawn one `Agent(subagent_type="general-purpose")` **per repo, all simultaneously** to run the full test suite and report results.

### Step 7: Commit Changes

Stage ONLY the modified files and commit with a `release: v{version}` message. **NEVER use git add -A or git add .**

### Step 8: Release Summary and Approval

Display a consolidated summary of the release plan and results. Request explicit user approval before pushing.

### Step 9: Push and Tag (only with explicit approval)

For each approved repo, push the current branch and the new version tag to origin.

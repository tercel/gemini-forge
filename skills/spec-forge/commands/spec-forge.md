---
allowed-tools: read_file, glob, grep_search, write_file, replace, ask_user, run_shell_command, web_search, codebase_investigator, generalist
description: "Use when generating software specifications — full chain (Idea→Decompose→Tech Design + Feature Specs → Review)"
argument-hint: "[idea|decompose|prd|srs|tech-design|test-cases|audit|analyze] <name or path>"
---

You are the spec-forge orchestrator. Your job is to route subcommands or run the full specification chain.

The user invoked: `/spec-forge $ARGUMENTS`

## Step 1: Parse Arguments

Parse `$ARGUMENTS` into `subcommand` and `argument`:

| Input Pattern | subcommand | argument |
|---|---|---|
| `idea cool-feature` | `idea` | `cool-feature` |
| `prd cool-feature` | `prd` | `cool-feature` |
| `srs cool-feature` | `srs` | `cool-feature` |
| `tech-design cool-feature` | `tech-design` | `cool-feature` |
| `test-cases cool-feature` | `test-cases` | `cool-feature` |
| `test-cases --formal cool-feature` | `test-cases` | `--formal cool-feature` |
| `decompose cool-feature` | `decompose` | `cool-feature` |
| `review cool-feature` | `review` | `cool-feature` |
| `audit ../../project` | `audit` | `../../project` |
| `analyze ../../docs-repo` | `analyze` | `../../docs-repo` |
| `cool-feature` (no known subcommand) | `chain` | `cool-feature` |
| (empty) | `dashboard` | — |

For routes B-E (idea, prd, srs, tech-design, test-cases, decompose, review, chain), `argument` is a feature name. For routes F-G (audit, analyze), `argument` is a file path.

## Step 2: Route

### Route A: `dashboard` (no arguments)

Display spec-forge dashboard:

1. Scan `docs/` for existing spec documents (`docs/*/prd.md`, `docs/*/srs.md`, `docs/*/tech-design.md`, `docs/*/test-cases.md`)
2. Scan `docs/` for decomposed projects (`docs/project-*.md`)
3. Scan `docs/features/` for lightweight feature specs (`docs/features/*.md`)
4. Scan `ideas/` for active ideas
5. Display summary of active ideas, projects, and specifications.
6. Use `ask_user` to ask what to do next.

### Route B: `idea`

Invoke the `/spec-forge:idea` skill with `argument`.

### Route C: `prd` / `srs` / `tech-design` / `test-cases` / `review` (single document)

Invoke the corresponding skill:
- `prd` → invoke `/spec-forge:prd` with `argument`
- `srs` → invoke `/spec-forge:srs` with `argument`
- `tech-design` → invoke `/spec-forge:tech-design` with `argument`
- `test-cases` → invoke `/spec-forge:test-cases` with `argument`
- `review` → invoke `/spec-forge:review` with `argument`

### Route D: `chain` (full chain auto mode)

Run the full specification chain automatically for `argument`:
1. **Idea** — Validate requirements (interactive)
2. **Decompose** — Determine if the project needs splitting
3. **Tech Design** — Generate architecture + auto-generate feature specs
4. **Review** — Audit generated documents for quality

Refer to `@./references/chain.md` for detailed chain logic.

### Route E: `decompose`

Invoke the `/spec-forge:decompose` skill with `argument`.

### Route F: `audit`

Invoke the `/spec-forge:audit` skill with `argument` as path.

### Route G: `analyze`

Invoke the `/spec-forge:analyze` skill with `argument` as path.

---
description: "MAIN ENTRY POINT for /theory-forge (no colon). Orchestrates: dashboard (no args), full-suite audit across all 8 sub-audits in parallel waves (path arg), help view (/theory-forge help), and routing to any individual sub-audit (/theory-forge cite-audit, scope, etc.)."
argument-hint: "[subcommand] [path-or-doc] | (empty for dashboard)"
---

You are the theory-forge orchestrator. Your job is to route subcommands or run the full audit suite on an academic theory documentation project.

The user invoked: `/theory-forge $ARGUMENTS`

## Step 1: Parse Arguments

Parse `$ARGUMENTS` into `subcommand` and `argument`:

| Input Pattern | subcommand | argument |
|---|---|---|
| `cite-audit ../some-project` | `cite-audit` | `../some-project` |
| `consistency` | `consistency` | (cwd) |
| `falsifiability ../some-project` | `falsifiability` | `../some-project` |
| `cross-lang` | `cross-lang` | (cwd) |
| `argument-structure` | `argument-structure` | (cwd) |
| `scope` | `scope` | (cwd) |
| `concept-import` | `concept-import` | (cwd) |
| `counter-argument` | `counter-argument` | (cwd) |
| `propagate docs/foundations/core-concept.md` | `propagate` | `docs/foundations/core-concept.md` |
| `help` | `help` | — |
| `help cite-audit` | `help` | `cite-audit` |
| (empty) | `dashboard` | — |
| `../some-project` (path-shaped) | `full-suite` | `../some-project` |
| any other single token | `full-suite` | (cwd, with the token as a tag) |

## Step 2: Route

Routing table summary:

| Subcommand value | Route handler |
|---|---|
| `dashboard` (no args) | Route A — full dashboard with project status + command usage |
| `help` (no command argument) | Route A-help — command usage only (no project status) |
| `help <command>` | Route A-help-detail — detailed help for one command |
| `cite-audit`, `consistency`, `falsifiability`, `argument-structure`, `scope`, `concept-import`, `counter-argument`, `cross-lang`, `propagate` | Route B — hand off to that command file |
| `full-suite` | Route C — run all 8 audits and aggregate |

### Route A: `dashboard` (no arguments)

Display theory-forge dashboard:

1. Detect whether the cwd is a theory project (has `docs/` with foundation or theory markdown files, plus a bibliography).
2. Scan `_research/` for prior audit reports and their dates (top 5).
3. Read the dashboard template: `../templates/dashboard-output.md` §"Full dashboard"
4. Fill in the `{placeholder}` values with project state.
5. Print the rendered dashboard.

Then stop.

> **Note on token economy:** the dashboard template is NOT inlined here. It lives in `../templates/dashboard-output.md` and is read only when actually rendering. This keeps `commands/theory-forge.md` lean for the common case of routing to a sub-command.

### Route A-help: `help` or `help <command>`

If the user types `/theory-forge help` (no command argument):
1. Read `../templates/dashboard-output.md` §"Help view"
2. Render the COMMANDS / ALIASES / GETTING HELP sections (omit the project-status header).

If the user types `/theory-forge help <command>` (e.g. `/theory-forge help cite-audit`):
1. Verify `<command>` is one of: cite-audit, consistency, falsifiability, argument-structure, scope, concept-import, counter-argument, cross-lang, propagate.
2. If unknown: print the "Unknown command" template (in `../templates/dashboard-output.md` §"Unknown command").
3. If known: read `./{command}.md` (for description, argument-hint, Usage Examples) and `../references/{command}-workflow.md` (for Anti-patterns + severity rules).
4. Render the "Detailed help" template (in `../templates/dashboard-output.md` §"Detailed help"), filling in the per-command values.

### Route B: subcommand routing

For `cite-audit`, `consistency`, `falsifiability`, `cross-lang`, `argument-structure`, `scope`, `concept-import`, `counter-argument`, `propagate`:

Invoke the corresponding command. For example, for `cite-audit`:

```
Hand off to /theory-forge:cite-audit {argument}
```

This is a hand-off — load and execute that command's workflow (read the file at `./{subcommand}.md` and follow it with `$ARGUMENTS` replaced by `argument`).

### Route C: `full-suite` — Run all audits (parallel-wave execution)

This is the orchestrator's core value-add. **Execution model: two parallel waves of 4 audits each.** All 8 audits are mutually independent (no inter-audit data dependency). The parallel-wave model exploits this independence for ~4× wall-clock speedup while maintaining safety.

**Wave 1** (launch all 4 in a single message via parallel `invoke_agent` calls):

| Audit | Why this wave | WebFetch |
|---|---|---|
| `cite-audit` | Largest single audit (WebFetch-bound) — start it earliest | **yes** |
| `consistency` | Local-only, fast | no |
| `falsifiability` | Local-only, fast | no |
| `cross-lang` | Local-only, independent | no |

**Wave 2** (after Wave 1 completes, launch all 4 in a single message):

| Audit | Why this wave |
|---|---|
| `argument-structure` | Falls in Wave 2 because some readers find it most useful after seeing falsifiability output |
| `scope` | Similar UX rationale |
| `concept-import` | Independent |
| `counter-argument` | Independent |

**`propagate`** is skipped in full-suite mode — it requires a specific upstream-edited doc as input.

#### Wave execution mechanic

For each wave, in a **single tool-call message**, dispatch all sub-agents:

```
Wave 1 dispatch (one message, four invoke_agent tool calls in parallel):
  invoke_agent(agent_name="generalist", prompt=<cite-audit launch prompt>)
  invoke_agent(agent_name="generalist", prompt=<consistency launch prompt>)
  invoke_agent(agent_name="generalist", prompt=<falsifiability launch prompt>)
  invoke_agent(agent_name="generalist", prompt=<cross-lang launch prompt>)

Wait for all four results.

Wave 2 dispatch (one message, four invoke_agent tool calls in parallel):
  invoke_agent(agent_name="generalist", prompt=<argument-structure launch prompt>)
  invoke_agent(agent_name="generalist", prompt=<scope launch prompt>)
  invoke_agent(agent_name="generalist", prompt=<concept-import launch prompt>)
  invoke_agent(agent_name="generalist", prompt=<counter-argument launch prompt>)

Wait for all four results.

Aggregate.
```

Each launch prompt is identical to what the individual command file (e.g., `./cite-audit.md`) uses — the orchestrator reuses those prompts verbatim.

**Failure handling**: if any Wave 1 sub-agent fails (timeout, network error, etc.), capture the failure and proceed to Wave 2 — do not block Wave 2 on Wave 1 failures. The master report flags any failed audit clearly.

#### Sequential fallback (`--sequential` flag)

For users who prefer sequential execution, the `--sequential` flag falls back to the previous behavior:

```
/theory-forge . --sequential
```

In sequential mode, the orchestrator runs each audit in turn (cite-audit → consistency → falsifiability → argument-structure → scope → concept-import → counter-argument → cross-lang).

After both waves complete, write the master report at `_research/theory-forge-master-report.md`.

**Report structure**: read the template at `../templates/master-report.md` and fill in the `{placeholder}` values across the Aggregate Summary, Cross-Audit Patterns, and Recommended Fix Order sections. The template is loaded only at this step.

### Step 3: Present Results

After all sub-audits complete, display the aggregate summary and recommend the top 3 fixes by severity × cross-audit overlap.

## Notes

- The orchestrator does not run `propagate` in full-suite mode because `propagate` requires a specific changed-document argument.
- If WebFetch is unavailable, only `cite-audit` is affected — it produces a partial report flagged as such.
- The orchestrator never auto-applies fixes. Each sub-audit's fix offer runs independently if invoked directly; in full-suite mode all fix offers are deferred until the master report is presented.
- **Critical findings escalate.** If any sub-audit produces a Critical finding, the master report's status is `REVIEW REQUIRED — CRITICAL` and the fix-offer is suppressed until the user acknowledges.

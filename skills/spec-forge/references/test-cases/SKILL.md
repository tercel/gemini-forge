---
name: test-cases-generation
description: >
  Generates structured test case sets with multi-dimensional coverage from project
  code analysis or specification documents. This skill activates when the user asks
  to write test cases, generate tests, supplement tests, create test coverage, or
  improve test completeness. It auto-scans the project to extract testable units
  (APIs, functions, components, CLI commands, tool definitions), identifies coverage
  gaps, designs test cases across multiple dimensions (coverage depth, input types,
  interaction patterns), and produces a structured test case document with coverage
  matrix. Includes test strategy and methodology by default. Use --formal flag to
  add management sections (environment, roles, schedule, defect management).
instructions: >
  Generate structured test case sets by scanning the project to extract testable
  units, identifying coverage gaps, designing multi-dimensional test cases, and
  producing a coverage matrix. Follow the seven-step workflow defined in this skill,
  reference the template at references/template.md, and validate output against
  the checklist at references/checklist.md.
---

# Test Cases Generation Skill

## What Are Test Cases?

Test cases are structured specifications that define what to test, how to test it, and what the expected outcome should be. Unlike a test plan (which focuses on strategy, schedule, roles, and process), test cases are the actionable core — each one is detailed enough for an engineer to translate directly into test code.

This skill treats test case design as a distinct discipline from test planning and test implementation:

- **Test Planning** (strategy, process, roles) → optional, available via `--formal` flag
- **Test Design** (what cases, which dimensions, what coverage) → this skill's core output
- **Test Implementation** (writing code) → downstream, handled by `code-forge:tdd`

## Core Capabilities

### Auto-Scan and Extract

The skill can automatically scan a project to extract testable units without requiring the user to provide a specification document. It identifies:

- **REST API routes** — endpoints, methods, parameters, response codes
- **Functions and methods** — signatures, parameter types, return values, branch logic
- **React/Vue/Svelte components** — props, events, state transitions
- **CLI commands** — commands, subcommands, flags, arguments
- **AI tool definitions** — tool names, trigger conditions, parameters, combination patterns
- **Database models** — schemas, relationships, constraints
- **Event handlers** — event types, payloads, side effects
- **Middleware/interceptors** — conditions, transformations, error handling

### Multi-Dimensional Coverage

Every test case set is organized across dimensions. The skill provides built-in dimensions and can auto-detect project-specific dimensions.

#### Built-in Dimensions

**Coverage Depth** (always applied):

| Level | Name | Description | Minimum per testable unit |
|-------|------|-------------|--------------------------|
| L1 | Happy Path | Basic correct behavior with valid inputs | 1 case |
| L2 | Boundary & Error | Edge cases, invalid inputs, error handling | 2 cases |
| L3 | Negative | Scenarios that should NOT trigger behavior | 1 case |

**Test Category** (apply categories relevant to the project):

| Category | When to Include | Description |
|----------|----------------|-------------|
| Functional | Always | Correct behavior verification |
| Data Integrity | Project has database / persistent store | Constraints, transactions, cascades |
| Security | Project handles auth, user input, or sensitive data | Auth, injection, access control |
| Performance | Project has latency/throughput requirements | Response time, throughput, resource usage |

#### Auto-Detected Dimensions

The skill analyzes the project to discover additional dimensions. Examples:

| Project Type | Auto-Detected Dimension | Values |
|-------------|------------------------|--------|
| AI Tool Calling | Trigger Mode | Single tool / Combo tools |
| AI Tool Calling | Conversation Turns | Single turn / Multi-turn |
| REST API | Auth Context | Unauthenticated / User / Admin |
| Frontend Component | Device Context | Desktop / Mobile / Tablet |
| CLI Tool | Input Source | Args / Stdin / Config file |
| CLI Tool | Output Format | JSON / Table / Plain text |
| Event System | Delivery Mode | Sync / Async / Batch |
| Function Library | Input Type | Primitive / Object / Array / Null / Undefined |
| Data Pipeline | Data Volume | Empty / Small / Large / Malformed |
| SDK / Client | Connection State | Connected / Disconnected / Reconnecting |

Auto-detected dimensions are presented to the user for confirmation before generating cases.

### Combination Testing

When testable units interact with each other, the skill generates combination test cases:

1. **Identify interaction pairs** — which units call, depend on, or affect each other
2. **Generate combination matrix** — pairwise combinations of interacting units
3. **Design combination cases** — test the interaction, not just individual units
4. **Prioritize combinations** — rank by risk (high coupling = high priority)

## Seven-Step Workflow

Every test case set generated by this skill follows a disciplined seven-step process. Each step must be completed before moving to the next.

- **Workflow Details**: @./writing-guidelines.md
- **Standards**: @./standards.md

### Step 1 — Determine Input Mode and Project Profile

This step answers two questions: **how** to find testable units (input mode) and **what kind** of project this is (project profile).

## Anti-Shortcut Rules

These shortcuts are strictly prohibited:

1. **No placeholders** — use concrete values, not `[valid email]`
2. **No mocking own dependencies** — test your own DB/file system/cache/queue for real; only mock external services you don't control
3. **No happy-path-only** — every unit needs L1 + L2 + L3 coverage (minimum 1+2+1 = 4 cases per unit)
4. **No vague expected results** — specify exact output (return value / status code / exit code / rendered content) AND state changes
5. **No missing L3 cases** — every testable unit needs at least one "should NOT happen" case
6. **No blind combination explosion** — prioritize combinations by risk, don't generate all permutations
7. **No forcing irrelevant sections** — if project has no DB, skip Data Integrity; if no auth, skip auth tests. Adapt to actual project profile
8. **No omitting coverage matrix** — the matrix is a required output, it proves completeness
9. **No HTTP-specific language for non-HTTP projects** — use exit codes for CLI, return values for libraries, rendered output for frontend. Match the project's interface

## Reference Files

- **`references/template.md`** — output template with default and formal sections
- **`references/checklist.md`** — quality validation checklist

Always read both files before generating test cases.

## Output Location

The finished test cases document is written to:

```
docs/<feature-name>/test-cases.md
```

where `<feature-name>` is a lowercase, hyphen-separated slug. If the directory does not exist, create it. If a file already exists, confirm before overwriting.

## Downstream Integration

The output is designed to be consumed by `code-forge:tdd` in driven mode:

```
/code-forge:tdd @docs/<feature-name>/test-cases.md
```

This will iterate through the test cases and implement each one following the Red-Green-Refactor cycle.

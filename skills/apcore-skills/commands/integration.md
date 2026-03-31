---
description: "Framework integration scaffolding (Express, FastAPI, Gin, Axum, etc.). Scaffolds the project with endpoint scanners, configuration system, context mapping, CLI commands, demo project, and Docker setup."
argument-hint: "<framework> [--lang python|typescript|go] [--ref django-apcore]"
allowed-tools: [Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion, Task, TaskCreate, TaskUpdate, TaskList, TaskGet]
---

# Apcore Skills — Integration

Bootstrap a new framework integration that connects a web framework to the apcore ecosystem.

## Core Mandates & Conventions

@./references/shared/conventions.md

## When to Use

- Creating a new framework integration (e.g., `fastapi-apcore`, `express-apcore`, `gin-apcore`)
- Re-scaffolding an existing integration that needs restructuring
- Evaluating what's needed for a new framework integration

## Command Format

```
/apcore-skills:integration <framework> [--lang python|typescript|go] [--ref django-apcore]
```

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `<framework>` | Yes | — | Target framework: `fastapi`, `express`, `gin`, `spring`, `actix`, etc. |
| `--lang` | No | auto-detect | Language of the framework |
| `--ref` | No | auto-detect | Reference integration to learn patterns from |

## 5 Core Capabilities

Every apcore framework integration must provide: Endpoint Scanner, Module Registry, Context Mapping, MCP Server, and OpenAI Export.

## Context Management

Steps 2 and 4 use sub-agents. Step 2 analyzes the reference integration. Step 4 generates the project skeleton. Main context retains only structured summaries.

## Workflow

```
Step 0 (ecosystem) → 1 (parse args) → 2 (analyze reference) → 3 (framework research) → 4 (scaffold) → 5 (demo project) → 6 (plan) → 7 (summary)
```

## Detailed Steps

### Step 0: Ecosystem Discovery

@./references/shared/ecosystem.md

---

### Step 1: Parse Arguments

Parse `$ARGUMENTS` for framework, language, and reference integration. Derive target repo name and path.

---

### Step 2: Analyze Reference Integration (Sub-agent)

Spawn `Agent(subagent_type="general-purpose")` to analyze the reference integration (extension, config, scanners, context, registry, CLI, output, README, demo) and understand the patterns.

### Step 3: Framework-Specific Research

Use `AskUserQuestion` to gather framework-specific information on routing, authentication, and API styles.

### Step 4: Scaffold Project (Sub-agent)

Spawn `Agent(subagent_type="general-purpose")` to create the project skeleton at the target path, including build config, README, main modules, scanners, context mapping, CLI, and tests. All files should have proper stubs with TODO markers.

### Step 5: Generate Demo Project

Create a minimal demo app with sample endpoints, apcore integration, and Docker setup.

### Step 6: Generate Code-Forge Config and Feature Specs

Write `.code-forge.json` and generate feature specs (scanner, config, context, registry, cli, observability) for `code-forge` planning.

### Step 7: Display Summary and Next Steps

Display a summary of scaffolded files and core capabilities, and provide next steps for implementation using `code-forge`.

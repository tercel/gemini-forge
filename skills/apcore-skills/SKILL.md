---
name: apcore-skills
description: "Apcore ecosystem orchestrator — manage cross-language SDKs, integrations, and consistency sync. Use when user invokes /apcore-skills or any subcommand (sync, audit, sdk, integration, release)."
instructions: >
  You are the apcore-skills orchestrator. You possess the full knowledge of sync, audit, sdk,
  integration, and release workflows. Follow the specific "Mode" instructions below based
  on the user's subcommand. Do NOT research your own instructions; they are all contained here.

  CRITICAL: For Sync mode, follow the Iron Law and use Parallel Sub-agents exactly as defined.
  For all modes, always start with Ecosystem Discovery (Shared Protocol below).
---

# Apcore Skills — Orchestrator

Route to the correct mode based on the user's subcommand, then follow that mode's detailed workflow.

| Subcommand | Mode |
|---|---|
| (none) | Dashboard |
| `sync` | Sync |
| `audit` | Audit |
| `sdk` | SDK |
| `integration` | Integration |
| `release` | Release |

---

# SHARED PROTOCOL: Ecosystem Discovery

**Every mode starts here.** Detect the ecosystem layout before any operation.

## Step 0.1: Detect Ecosystem Root

Search for the ecosystem root by looking for the `apcore` protocol specification repo:

1. Check current directory for `.apcore-skills.json` — if found, read `ecosystem_root` from it
2. Search upward from the current directory, checking each ancestor directory for an `apcore/` subdirectory containing `PROTOCOL_SPEC.md`. Continue until the filesystem root is reached or a match is found.
3. If not found: ask the user for ecosystem root path

Store `ecosystem_root` — the parent directory containing all apcore repos.

## Step 0.2: Discover Repositories

Scan `ecosystem_root` for known repository patterns:

**Core Protocol:**
| Directory Pattern | Repo Type | Role |
|---|---|---|
| `apcore/` | `protocol` | Protocol specification and docs (reference authority) |

**Core SDKs:**
| Directory Pattern | Repo Type | Language | Package Name |
|---|---|---|---|
| `apcore-python/` | `core-sdk` | Python | `apcore` |
| `apcore-typescript/` | `core-sdk` | TypeScript | `apcore-js` |
| `apcore-{lang}/` | `core-sdk` | `{lang}` | varies |

**MCP Bridges:**
| Directory Pattern | Repo Type | Language | Package Name |
|---|---|---|---|
| `apcore-mcp-python/` | `mcp-bridge` | Python | `apcore-mcp` |
| `apcore-mcp-typescript/` | `mcp-bridge` | TypeScript | `apcore-mcp` |
| `apcore-mcp-{lang}/` | `mcp-bridge` | `{lang}` | varies |

**Framework Integrations:**
| Directory Pattern | Repo Type | Language | Framework |
|---|---|---|---|
| `django-apcore/` | `integration` | Python | Django |
| `flask-apcore/` | `integration` | Python | Flask |
| `nestjs-apcore/` | `integration` | TypeScript | NestJS |
| `tiptap-apcore/` | `integration` | TypeScript | TipTap |
| `{framework}-apcore/` | `integration` | varies | `{framework}` |

**Shared Libraries:**
| Directory Pattern | Repo Type | Language |
|---|---|---|
| `apcore-discovery-python/` | `shared-lib` | Python |
| `apcore-toolkit-python/` | `shared-lib` | Python |

**Documentation Sites:**
| Directory Pattern | Repo Type | Description |
|---|---|---|
| `apcore-mcp/` (with `mkdocs.yml`, no `src/`) | `docs-site` | MCP documentation site |
| `apcore-zh/` | `docs-site` | Chinese localization |
| `aipartnerup-docs/` | `docs-site` | Organization-level documentation |

**A2A Protocol:**
| Directory Pattern | Repo Type | Language |
|---|---|---|
| `apcore-a2a/` | `protocol` | A2A protocol specification |
| `apcore-a2a-python/` | `core-sdk` | Python |
| `apcore-a2a-typescript/` | `core-sdk` | TypeScript |

**Exclude from ecosystem scans** (not apcore SDK/integration repos):
- `aphub*`, `apflow*`, `apdev*`, `aipartnerup-website/` — separate product lines

For each discovered directory:
1. Check if it contains a valid project (has `pyproject.toml`, `package.json`, `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`, `build.gradle.kts`, `composer.json`, `mix.exs`, `Package.swift`, or `*.csproj`)
2. Skip `docs-site` type repos (no build config, only `mkdocs.yml` or markdown files)
3. Flag `placeholder` repos (directory exists but no source files — report as "empty/placeholder")
4. Extract version from the build config file
5. Detect language from build config
6. Check git status (clean / dirty / uncommitted changes)

Store `repos[]` — list of discovered repository objects with: `name`, `path`, `type`, `language`, `version`, `package_name`, `git_status`.

## Step 0.3: Detect CWD Repo

Determine `cwd_repo` — the repo the user is currently working in:
1. Get CWD basename (e.g., `apcore-python`)
2. Match against `repos[]` by name
3. If matched, store `cwd_repo = { name, type, language, scope_group }`:
   - `core-sdk` -> `scope_group = "core"`
   - `mcp-bridge` -> `scope_group = "mcp"`
   - `integration` -> `scope_group = "integrations"`
   - `protocol` / `docs-site` -> `scope_group = "docs"`
   - `shared-lib` -> `scope_group = "shared"`
   - `tooling` -> `scope_group = "tooling"`
4. If not matched, `cwd_repo = null`

## Step 0.4: Load Configuration

Load configuration by priority (deep-merge):

1. **System defaults:**
   - `ecosystem_root` = detected root
   - `protocol_repo` = `"apcore"`
   - `reference_sdk.python` = `"apcore-python"`
   - `reference_sdk.typescript` = `"apcore-typescript"`
   - `reference_mcp.python` = `"apcore-mcp-python"`
   - `reference_mcp.typescript` = `"apcore-mcp-typescript"`
   - `version_groups.core` = `["apcore-python", "apcore-typescript"]`
   - `version_groups.mcp` = `["apcore-mcp-python", "apcore-mcp-typescript"]`

2. **User global config** (`~/.apcore-skills.json`, if exists) -> deep-merge
3. **Project config** (`<ecosystem_root>/.apcore-skills.json`, if exists) -> deep-merge

## Step 0.5: Version Extraction Rules

| File | Version Location |
|---|---|
| `pyproject.toml` | `[project] version = "X.Y.Z"` |
| `package.json` | `"version": "X.Y.Z"` |
| `Cargo.toml` | `[package] version = "X.Y.Z"` |
| `go.mod` | Tag-based (check `git tag -l 'v*'` for latest) |
| `pom.xml` | `<version>X.Y.Z</version>` |
| `build.gradle` | `version = 'X.Y.Z'` or `version 'X.Y.Z'` |
| `build.gradle.kts` | `version = "X.Y.Z"` |
| `mix.exs` | `version: "X.Y.Z"` in `project/0` |
| `Package.swift` | Version constant or git tag-based |
| `*.csproj` | `<Version>X.Y.Z</Version>` |
| `composer.json` | `"version": "X.Y.Z"` |
| `__init__.py` / `_version.py` | `__version__ = "X.Y.Z"` |
| `src/*/index.ts` | `export const VERSION = "X.Y.Z"` |

## Step 0.6: Display Discovery Summary

```
apcore-skills — Ecosystem Dashboard

Ecosystem root: /path/to/aipartnerup/
Repos discovered: {count}

  Type          | Repo                    | Lang       | Version | Status
  protocol      | apcore                  | —          | —       | clean
  core-sdk      | apcore-python           | Python     | 0.7.0   | clean
  core-sdk      | apcore-typescript       | TypeScript | 0.7.1   | dirty
  mcp-bridge    | apcore-mcp-python       | Python     | 0.8.1   | clean
  ...
```

## Step 0.7: Store Ecosystem Context

Track resolved values for subsequent steps:
- `config` — final merged configuration object
- `ecosystem_root` — absolute path
- `repos[]` — discovered repositories with metadata
- `protocol_path` — path to apcore protocol repo
- `core_sdks[]` — core SDK repos
- `mcp_bridges[]` — MCP bridge repos
- `integrations[]` — framework integration repos

---

# SHARED PROTOCOL: API Extraction

Standard method for extracting and comparing public APIs across language implementations.

## What Constitutes the Public API

Public API surface includes:
1. **Exported classes** — listed in `__init__.py` (Python) or `index.ts` (TypeScript)
2. **Exported functions** — top-level functions in `__init__.py` / `index.ts`
3. **Exported types/interfaces** — type definitions, enums, error codes
4. **Constructor signatures** — parameter names, types, defaults
5. **Method signatures** — parameter names, types, return types
6. **Error classes** — names, codes, hierarchy
7. **Configuration options** — setting names, types, defaults
8. **Module definition API** — decorators, binding formats

## Extraction Steps

For each SDK repository:

**Step E.1: Read public exports**
- Python: Read `src/<package>/__init__.py`, extract `__all__` or all non-underscore imports
- TypeScript: Read `src/index.ts`, extract all `export` statements
- Go: Read all `*.go` files in root package, extract capitalized identifiers
- Rust: Read `src/lib.rs`, extract `pub` items
- Java: Read package-level exports or module-info.java

**Step E.2: Extract signatures**

For each exported symbol, extract:
- `name` — actual name in this language
- `kind` — class | function | type | enum | constant | interface
- `canonical_name` — protocol-defined name
- For classes: `constructor` params (name, type, required, default) and all public `methods` with full signatures
- For functions: params, return_type, async flag
- For enums: all member names and values
- For types/interfaces: all fields (name, type, required)

**Step E.3: Normalize for comparison**

Apply naming convention translation for comparison:

| Concept | Python | TypeScript | Go | Rust | Java |
|---|---|---|---|---|---|
| Class name | `PascalCase` | `PascalCase` | `PascalCase` | `PascalCase` | `PascalCase` |
| Method name | `snake_case` | `camelCase` | `PascalCase` | `snake_case` | `camelCase` |
| Function name | `snake_case` | `camelCase` | `PascalCase` | `snake_case` | `camelCase` |
| Constant | `UPPER_SNAKE` | `UPPER_SNAKE` | `PascalCase` | `UPPER_SNAKE` | `UPPER_SNAKE` |
| Parameter | `snake_case` | `camelCase` | `camelCase` | `snake_case` | `camelCase` |
| Package | `snake_case` | `kebab-case` | `lowercase` | `snake_case` | `dot.separated` |
| File | `snake_case.py` | `kebab-case.ts` | `snake_case.go` | `snake_case.rs` | `PascalCase.java` |

To compare across languages, convert all names to a canonical form (`snake_case`) for matching.

**Step E.4: Type mapping**

Check if `apcore/docs/spec/type-mapping.md` exists. If so, use it for cross-language type equivalence. Default type mappings:

| Concept | Python | TypeScript | Go | Rust | Java | PHP |
|---|---|---|---|---|---|---|
| String | `str` | `string` | `string` | `String` / `&str` | `String` | `string` |
| Integer | `int` | `number` | `int` / `int64` | `i64` | `long` | `int` |
| Float | `float` | `number` | `float64` | `f64` | `double` | `float` |
| Boolean | `bool` | `boolean` | `bool` | `bool` | `boolean` | `bool` |
| List | `list[T]` | `T[]` | `[]T` | `Vec<T>` | `List<T>` | `array` |
| Dict/Map | `dict[K,V]` | `Record<K,V>` | `map[K]V` | `HashMap<K,V>` | `Map<K,V>` | `array` |
| Optional | `T \| None` | `T \| undefined` | `*T` | `Option<T>` | `Optional<T>` | `?T` |
| Any/Dynamic | `Any` | `unknown` | `any` / `interface{}` | `Box<dyn Any>` | `Object` | `mixed` |
| Result/Error | raise Exception | throw Error | `error` | `Result<T,E>` | throw Exception | throw Exception |
| Async | `async def` | `async function` | goroutine | `async fn` | `CompletableFuture` | `Fiber` / `Promise` |
| Callback | `Callable` | `(...) => T` | `func(...)` | `Fn(...)` | `Function<T,R>` | `callable` |

> **Note:** This table covers common single-level generics. For nested generics (e.g., `Result<Option<List<T>>, E>`), rely on language-specific type system knowledge rather than mechanical mapping. Flag ambiguous type translations for manual review.

## Comparison Output Format

```
API Comparison: {sdk-a} vs {sdk-b}

MISSING in {sdk-b}:
  - Registry.scan_directory() — present in {sdk-a} but not {sdk-b}
  - ErrorCode.BINDING_NOT_FOUND — enum value missing

SIGNATURE MISMATCH:
  - Executor.execute()
    {sdk-a}: (module_id: str, input: dict, context: Context | None = None) -> ExecutionResult
    {sdk-b}: (moduleId: string, input: Record<string, unknown>) -> ExecutionResult
    Issues: missing `context` parameter in {sdk-b}

NAMING INCONSISTENCY:
  - {sdk-a}: Registry.get_module() vs {sdk-b}: Registry.findModule()
    Expected: get_module / getModule (same canonical name)

TYPE MISMATCH:
  - Config.timeout: {sdk-a} uses float, {sdk-b} uses number (OK — equivalent)
  - Config.max_retries: {sdk-a} uses int, {sdk-b} uses string (MISMATCH)

EXTRA in {sdk-b} (not in {sdk-a}):
  - Registry.clearCache() — language-specific addition (OK if documented)

Summary: {N} missing, {N} mismatched, {N} naming issues, {N} type issues
```

## Conventions Reference

For naming, testing, dependency, and project structure conventions, read `references/shared/conventions.md`. This file defines version sync groups, naming rules per language, project layouts, git conventions, testing frameworks/coverage targets, and dependency expectations.

---

# MODE: Dashboard (/apcore-skills with no subcommand)

Run Ecosystem Discovery (Step 0 above), then display:

```
apcore-skills — Ecosystem Dashboard

Ecosystem root: /path/to/aipartnerup/
Repos discovered: {count}

  Type          | Repo                    | Lang       | Version | Status
  (table from Step 0.6)

Version Sync Check:
  core group:  apcore-python=0.7.0, apcore-typescript=0.7.1  WARNING MISMATCH
  mcp group:   apcore-mcp-python=0.8.1, apcore-mcp-typescript=0.8.1  OK

Commands:
  /apcore-skills:sync                  Cross-language API + documentation consistency check & fix
  /apcore-skills:sdk <lang>            Bootstrap new language SDK
  /apcore-skills:integration <name>    Bootstrap new framework integration
  /apcore-skills:audit                 Deep cross-repo consistency audit
  /apcore-skills:release <version>     Coordinated multi-repo release
```

Ask the user what to do next.

---

# MODE: Sync (/apcore-skills:sync)

**Goal**: Unified cross-language consistency verification and documentation alignment.

## Iron Law

**DOCUMENTATION REPOS ARE THE SINGLE SOURCE OF TRUTH. Phase A verifies code matches specs. Phase B verifies docs are internally consistent. Never skip a phase. Never skip a checklist item.**

## Anti-Rationalization Table

| Thought | Reality |
|---------|---------|
| "Python is the reference, just copy it" | The documentation repo is the authority. Python may have diverged too. |
| "This naming difference is just language convention" | Convention differences (snake_case vs camelCase) are expected. Semantic differences (get_module vs findModule) are bugs. |
| "Extra methods in one SDK are fine" | Language-specific additions are OK only if documented. Undocumented extras indicate drift. |
| "I'll just compare export counts" | Count matching is necessary but not sufficient. Signature-level comparison is required. |
| "Docs look close enough" | If the code says `get_module()` but the README says `find_module()`, that is a bug. Every symbol must match exactly. |
| "I can check docs without verifying code first" | Phase B depends on Phase A. If Phase A has not established ground truth, docs verification is comparing against potentially wrong code. |
| "Checking a few symbols is representative" | Build the complete checklist. Compare every item. Partial checks create false confidence. |
| "CHANGELOG has the wrong API name" | CHANGELOG is a release artifact, not documentation. Leave it to the release skill. |
| "PRD is product-level, no need to check against code" | If the PRD says a feature exists but no implementation matches, that is a gap. Every layer must agree. |

## Command Format

```
/apcore-skills:sync [--phase a|b|all] [--fix] [--scope core|mcp|all] [--lang python,typescript,...] [--save]
```

| Flag | Default | Description |
|------|---------|-------------|
| `--phase` | `all` | Which phase to run: `a` (spec vs implementation), `b` (documentation internal consistency), `all` (A then B) |
| `--fix` | off | Auto-fix issues (naming, stubs, doc references) |
| `--scope` | **cwd** | Which group: `core`, `mcp`, `all`. **If omitted, defaults to the current working directory's repo only.** Use `--scope all` to scan all repos. |
| `--lang` | all discovered | Comma-separated list of languages to compare |
| `--save` | off | Save report to file |

## Documentation and Implementation Repo Mapping

Each `--scope` group has one **documentation repo** (single source of truth) and one or more **implementation repos** (language-specific code):

| Scope | Documentation Repo | Contents | Implementation Repos |
|-------|-------------------|----------|---------------------|
| `core` | `apcore/` | PROTOCOL_SPEC.md, PRD, SRS, Tech Design, Test Plan, Feature Specs | `apcore-python/`, `apcore-typescript/`, ... |
| `mcp` | `apcore-mcp/` | PRD, SRS, Tech Design, Test Plan, Feature Specs | `apcore-mcp-python/`, `apcore-mcp-typescript/`, ... |

Implementation repos contain only code and a README. They do NOT contain PRD/SRS/Tech Design/Test Plan/Feature Specs — those live exclusively in the documentation repo.

## Context Management

**All per-repo operations use parallel sub-agents.** The main context ONLY handles:
1. Orchestration — determining scope, phase, and spawning sub-agents
2. Spec reference — reading the documentation repo (lightweight, structured docs)
3. Comparison logic — building and evaluating the checklist from structured summaries
4. Phase sequencing — Phase A must complete before Phase B begins
5. Reporting — formatting combined results

Phase A Step 2 spawns **one sub-agent per implementation repo, all simultaneously** for API extraction. Phase B Step 6 spawns **one sub-agent per documentation repo + one per implementation repo, all simultaneously** for documentation auditing. Fix steps spawn **one sub-agent per repo** for applying corrections.

## Workflow

```
Step 0 (ecosystem) -> Step 1 (parse args) -> PHASE A [Steps 2-5] -> PHASE B [Steps 6-8] -> Step 9 (combined report) -> [Step 10 (fix)]
```

---

### Sync Step 1: Parse Arguments and Determine Scope

Parse arguments for all flags. Determine:
- Active phases (a, b, or both)
- Scope groups and language filter
- Fix mode

#### 1.1 CWD-based Default Scope

**If `--scope` is NOT specified:**
1. Detect the current working directory's repo name (basename of CWD, e.g., `apcore-python`)
2. Look up this repo in the discovered ecosystem:
   - If it's a `core-sdk` repo -> set scope to `core`, filter `impl_repos` to **only this repo**
   - If it's a `mcp-bridge` repo -> set scope to `mcp`, filter `impl_repos` to **only this repo**
   - If it's the `protocol` repo (`apcore/`) -> set scope to `core`, include **all** core impl repos (user is editing the spec, so check all implementations against it)
   - If it's a `docs-site` repo (`apcore-mcp/`) -> set scope to `mcp`, include **all** mcp impl repos
   - If it's an `integration` repo -> Phase A is N/A (integrations don't have a protocol spec to compare against), run Phase B only on this repo
   - If it's a `shared-lib` or `tooling` repo -> run Phase B only on this repo (no spec to compare against)
   - If CWD is not inside any discovered repo -> ask: "CWD is not an apcore repo. Which repo do you want to sync?" with options from `repos[]` names + "All repos (full ecosystem scan)"
3. Display: "Scope: {repo-name} (from CWD). Use --scope all for full ecosystem scan."

**If `--scope` IS specified:** use the explicit scope as before.

#### 1.2 Resolve Repos

For each scope group, resolve:
- `doc_repo` — the documentation repo path (e.g., `apcore/` for core, `apcore-mcp/` for mcp)
- `impl_repos[]` — the implementation repo paths (may be a single repo if CWD-scoped)

**Single-SDK handling:** If a scope group contains fewer than 2 implementation repos:
- Skip cross-implementation comparison for that group
- Display: "Only 1 {scope} implementation found ({repo-name}). Cross-language comparison requires at least 2 implementations."
- Still run spec compliance check (Phase A) and documentation consistency check (Phase B) as single-repo validation

Display:
```
Sync scope: {scope} {("(from CWD)" if defaulted)}
Languages: {lang1}, {lang2}, ...
Doc repos: {doc_repo1}, {doc_repo2}
Impl repos: {impl_repo1}, {impl_repo2}, ...
Phases: {A only | B only | A then B}
Mode: {report only | auto-fix}
```

---

## PHASE A: Spec <-> Implementation Consistency

Verify that the documentation repo's feature specs and protocol spec match what each language implementation actually exports. Build an explicit checklist, compare every item.

### Sync Step 2: Extract Public APIs (Parallel Sub-agents — One per Implementation Repo)

Spawn one sub-agent **per implementation repo, all simultaneously in a single round of parallel calls**. Each sub-agent extracts the public API from one repo independently. Do NOT process repos sequentially.

**Sub-agent prompt:**

```
Extract the complete public API surface from {repo_path}.

Follow the API Extraction Protocol:

1. Read the main export file:
   - Python: src/{package}/__init__.py — extract all imports and __all__
   - TypeScript: src/index.ts — extract all export statements

2. For each exported symbol, read its source file and extract:
   - Kind: class | function | type | enum | constant | interface
   - Name (in this language's convention)
   - For classes: constructor params (name, type, required, default), all public methods with full signatures
   - For functions: params (name, type, required, default), return type, async flag
   - For enums: all member names and values
   - For types/interfaces: all fields (name, type, required)
   - For constants: name, type, value

3. Also extract:
   - Error classes: name, error code, parent class
   - Middleware interfaces: method signatures
   - Extension points: discoverer, validator, exporter interfaces

Return a structured summary in this exact format:

REPO: {repo-name}
LANGUAGE: {language}
VERSION: {version}
EXPORT_COUNT: {N}

CLASSES:
- {ClassName}
  constructor({param1}: {type1}, {param2}: {type2} = {default})
  methods:
    - {method_name}({params}) -> {return_type} [async]
    - ...

FUNCTIONS:
- {function_name}({params}) -> {return_type} [async]

ENUMS:
- {EnumName}: {MEMBER1}={value1}, {MEMBER2}={value2}, ...

TYPES:
- {TypeName}: {field1}: {type1}, {field2}: {type2}, ...

ERRORS:
- {ErrorName}(code={CODE}, parent={ParentError})

CONSTANTS:
- {NAME}: {type} = {value}

Error handling:
- If the repo path does not exist, return: REPO: {repo-name}, STATUS: NOT_FOUND
- If the main export file is missing or empty, return: REPO: {repo-name}, STATUS: NO_EXPORTS, REASON: {description}
- If individual source files cannot be read, skip them and note in the summary

Keep the summary concise but complete. Target ~3-5KB.
```

**Main context retains:** Each repo's structured API summary. Store as `api_summaries[repo_name]`.

---

### Sync Step 3: Load Documentation Repo Reference

For each documentation repo in scope, read the authoritative specs:

**For `apcore/` (core scope):**
1. Read `{doc_repo_path}/PROTOCOL_SPEC.md` — extract the API contract sections
2. Scan `{doc_repo_path}/docs/features/*.md` — extract per-feature API definitions (classes, functions, parameters, return types)
3. If `{doc_repo_path}/docs/spec/type-mapping.md` exists — load cross-language type mappings

**For `apcore-mcp/` (mcp scope):**
1. Scan `{doc_repo_path}/docs/features/*.md` — extract per-feature API definitions
2. If a protocol or spec file exists — extract the API contract

**For A2A repos (`apcore-a2a/`):**
1. Read the Tech Design and any protocol spec files
2. Extract the API contract sections defining required classes, methods, and types

Store as `spec_api[scope]` — the canonical API that all implementations in this scope must match.

---

### Sync Step 4: Checklist Comparison (The Core of Phase A)

Build an explicit per-symbol checklist and evaluate every single item. No shortcuts.

#### 4.1 Build the Master Checklist

From `spec_api` and all `api_summaries`, construct a union of all symbols. Apply canonical name normalization for matching, **differentiated by symbol kind**:

**Classes / Types / Enums / Interfaces** -> normalize to `PascalCase`:
- Python, TypeScript, Go, Rust, Java, C#, Kotlin, Swift, PHP: `PascalCase` (pass through)

**Functions / Methods / Variables / Constants** -> normalize to `snake_case`:
- Python: `snake_case` (pass through)
- TypeScript: `camelCase` -> `snake_case`
- Go: `PascalCase` -> `snake_case` (exported functions)
- Rust: `snake_case` (pass through)
- Java: `camelCase` -> `snake_case`
- C#: `PascalCase` -> `snake_case`
- Kotlin: `camelCase` -> `snake_case`
- Swift: `camelCase` -> `snake_case`
- PHP: `camelCase` -> `snake_case`

For each symbol, create a checklist row covering every checkable property.

#### 4.2 Checklist Evaluation Rules

**For each CLASS:**

```
+------------------------+----------+----------+----------+----------+
| Check Item             | Spec     | Python   | TypeScript| Status   |
+------------------------+----------+----------+----------+----------+
| Registry               |          |          |          |          |
|  +- class exists       | Y        | Y        | Y        | PASS     |
|  +- constructor params |          |          |          |          |
|  |  +- config: Config  | required | required | required | PASS     |
|  |  +- discoverers     | optional | optional | MISSING  | FAIL     |
|  +- method: register   |          |          |          |          |
|  |  +- exists          | Y        | Y        | Y        | PASS     |
|  |  +- name convention | register | register | register | PASS     |
|  |  +- params          | (module) | (module) | (module) | PASS     |
|  |  +- return type     | None     | None     | void     | PASS     |
|  |  +- async           | no       | no       | no       | PASS     |
|  +- method: get_module |          |          |          |          |
|  |  +- exists          | Y        | Y        | Y        | PASS     |
|  |  +- name convention | get_mod  | get_mod  | getMod   | PASS     |
|  |  +- params          | (id)     | (id)     | (id)     | PASS     |
|  |  +- return type     | Module?  | Module?  | Module?  | PASS     |
|  +- method: scan_dir   |          |          |          |          |
|  |  +- exists          | Y        | Y        | N        | FAIL     |
|  |  ...                |          |          |          |          |
+------------------------+----------+----------+----------+----------+
```

Checklist items per CLASS:
1. Class exists — present in spec? present in each implementation?
2. Constructor params — for each param: name convention? type matches? required/optional? default value?
3. Methods — for each method:
   a. Method exists in each implementation?
   b. Name follows language convention for the canonical name?
   c. Each parameter: name, type, required/optional, default
   d. Return type matches (using type mapping table)?
   e. Async flag matches?

**For each FUNCTION:**
1. Function exists — present in spec? present in each implementation?
2. Name follows language convention?
3. Each parameter: name, type, required/optional, default
4. Return type matches?
5. Async flag matches?

**For each ENUM:**
1. Enum exists in each implementation?
2. Each member: name matches? value matches?

**For each TYPE/INTERFACE:**
1. Type exists in each implementation?
2. Each field: name matches? type matches? required/optional?

**For each ERROR CLASS:**
1. Error class exists in each implementation?
2. Error code value matches?
3. Parent class matches?

**For each CONSTANT:**
1. Constant exists in each implementation?
2. Type matches? Value matches?

#### 4.3 Protocol Compliance Check

For each implementation repo, compare against the spec API:
1. **Missing from spec** — implementation has symbols not defined in spec (language-specific additions)
2. **Missing from implementation** — spec defines symbols not in implementation
3. **Divergence** — implementation doesn't match spec definition

#### 4.4 Store Phase A Results

Store the full evaluated checklist as `phase_a_results`:
- `verified_api` — the spec-defined API surface with per-symbol verification status from implementations. Definition: the union of all symbols from the spec, annotated with which implementations have them and whether they match. For PASS symbols, the spec definition is confirmed correct. For FAIL symbols, the spec definition is still authoritative (implementations are wrong).
- `checklist` — every item with its PASS/FAIL/WARN status
- `findings` — structured list of all failures with severity

This `verified_api` becomes the input truth for Phase B. When injecting into Phase B sub-agent prompts, format as:
```
VERIFIED API ({repo-name}):
CLASSES:
- {ClassName}: constructor({params}), methods: {method1}({params}) -> {ret}, ...
FUNCTIONS:
- {func_name}({params}) -> {ret}
TYPES:
- {TypeName}: {field1}: {type1}, {field2}: {type2}, ...
ENUMS:
- {EnumName}: {MEMBERS}
CONSTANTS:
- {NAME}: {type} = {value}
ERRORS:
- {ErrorName}(code={CODE})
```

---

### Sync Step 5: Phase A Report

```
=== PHASE A: Spec <-> Implementation Consistency ===

Scope: {scope}
Doc repo: {doc_repo} -> Impl repos: {impl1}, {impl2}, ...

Checklist: {total_items} items checked
  PASS: {n}
  FAIL: {n}
  WARN: {n}

Spec compliance:
  {impl-repo-1}:  {N}/{total} symbols ({pct}%) OK
  {impl-repo-2}:  {N}/{total} symbols ({pct}%) WARNING {missing} missing

Cross-implementation:
  Total symbols: {N}
  Matching: {N}
  Missing: {N}
  Signature mismatch: {N}
  Naming inconsistency: {N}
  Type mismatch: {N}

FAIL items (expanded):
  [CRITICAL] Registry.scan_directory()
     Present in: spec, apcore-python
     Missing in: apcore-typescript
     Spec: defined in docs/features/registry.md

  [CRITICAL] Executor.execute() — param mismatch
     Spec:       (module_id: str, input: dict, context: Context | None = None) -> ExecutionResult
     Python:     (module_id: str, input: dict, context: Context | None = None) -> ExecutionResult  OK
     TypeScript: (moduleId: string, input: Record<string, unknown>) -> ExecutionResult  MISSING context param
```

If `--save` flag: write report to `{ecosystem_root}/sync-report-phase-a-{date}.md`.

If `--phase a` only: display this report and stop. Otherwise continue to Phase B.

---

## PHASE B: Documentation Internal Consistency

Phase B runs ONLY after Phase A completes. It verifies two things:
1. The documentation repo's internal documents are consistent with each other (no contradictions)
2. Implementation repos' README and examples are consistent with `verified_api` from Phase A

### Sync Step 6: Audit Documentation (Parallel Sub-agents)

Spawn sub-agents in parallel: **one per documentation repo** + **one per implementation repo**, all simultaneously.

#### Sub-agent for Documentation Repo (apcore/ or apcore-mcp/)

**Sub-agent prompt:**

```
Audit internal documentation consistency in {doc_repo_path}.

This is a DOCUMENTATION REPO containing specs and feature definitions. Check that
all documents are internally consistent — no contradictions between layers.

=== SCOPE 1: Spec Chain Consistency ===

Read all available documents from the spec chain:
- PRD (if exists): docs/prd.md or similar
- SRS (if exists): docs/srs.md or similar
- Tech Design (if exists): docs/tech-design.md or similar
- Test Plan (if exists): docs/test-plan.md or similar
- Feature Specs: docs/features/*.md
- Protocol Spec (if exists): PROTOCOL_SPEC.md

For each API symbol (class, function, parameter, return type) mentioned across multiple documents:
1. Collect ALL references: which document, what section, what it says
2. Compare: do all documents agree on the symbol's name, parameters, behavior, and types?
3. Flag contradictions:
   - PRD says feature X has capability A, but feature spec says no such capability
   - SRS requirement REQ-001 references function foo(), but tech design calls it bar()
   - Test plan tests for param "timeout" but feature spec defines it as "max_wait"
   - Feature spec A says Registry has method scan(), feature spec B says it's discover()

=== SCOPE 2: Feature Spec Completeness ===

For each feature spec in docs/features/:
1. Does it define clear API symbols (classes, functions, params, return types)?
2. Are there features mentioned in PRD/SRS that have NO corresponding feature spec?
3. Are there feature specs that are NOT referenced by any higher-level document?

=== SCOPE 3: Cross-Document Reference Integrity ===

Check all internal cross-references:
1. Do documents reference sections/features that actually exist?
2. Are version numbers consistent across documents?
3. Are terminology and naming consistent (same concept uses same name everywhere)?

Return findings in this exact format:
DOC_REPO: {repo-name}
DOCUMENTS_FOUND: {list of documents checked with paths}

SPEC_CHAIN:
  LAYERS_CHECKED: {list: prd, srs, tech-design, test-plan, feature-specs, protocol-spec}
  CONTRADICTIONS: {N}
  GAPS: {N}

FINDING_COUNT: {N}
FINDINGS:
- severity: {critical|warning|info}
  scope: {spec-chain|completeness|cross-ref}
  detail: {description}
  locations:
    - {file1:section} says: "{quote1}"
    - {file2:section} says: "{quote2}"
  contradiction: {what disagrees}
  fix: {which document should be authoritative and what to change}

Error handling:
- If the documentation repo path does not exist, return: DOC_REPO: {repo-name}, STATUS: NOT_FOUND
- If no spec chain documents are found, return: DOC_REPO: {repo-name}, STATUS: NO_DOCS, DOCUMENTS_FOUND: []
- If individual files cannot be read, skip them and list as "{path} (unreadable)"
```

#### Sub-agent for Implementation Repo (apcore-python/, apcore-typescript/, etc.)

**Sub-agent prompt:**

```
Audit documentation in {impl_repo_path} for consistency with the verified API surface.

This is an IMPLEMENTATION REPO. It should contain only code and a README (plus optional examples).
It does NOT contain PRD/SRS/Tech Design/Test Plan/Feature Specs.

VERIFIED API (ground truth from Phase A):
{verified_api for this repo — the confirmed-correct API symbols, signatures, types}

=== SCOPE 1: README ===

1. Read README.md
2. Check required sections: Title/badges, Description, Installation, Quick Start, Features, API Overview, Docs link, License
3. For Installation: verify package name matches build config (pyproject.toml/package.json)
4. For Quick Start code examples: extract all API references, verify they match verified API
   - Import names correct?
   - Class names correct?
   - Method names correct?
   - Parameter names and order correct?
5. For API Overview: verify listed classes/functions exist in verified API with correct descriptions
6. For version references: verify they match current version in build config

=== SCOPE 2: API References in Markdown ===

Search ALL markdown files in the repo for API symbol references:
1. For EACH symbol reference found:
   a. Does the symbol exist in the verified API?
   b. Do parameter names/order match the verified signature?
   c. Are import paths correct?
   d. Are return types correctly described?
2. Cross-check: do different markdown files contradict each other?

=== SCOPE 3: Example Code ===

1. Scan examples/, demo/, example/ directories
2. For each example source file:
   a. Extract import statements and API usage
   b. Cross-reference against verified API — correct class names, method names, params?
   c. Check dependency versions reference correct SDK version
3. Check example README exists with setup instructions

=== SCOPE 4: Cross-Document Contradiction Detection ===

For every API symbol mentioned in more than one place within this repo:
1. Collect all references (file, line, what it says)
2. Compare: do all references agree on name, params, behavior?
3. Flag any contradictions between documents

Return findings in this exact format:
REPO: {repo-name}

README:
  SECTIONS_PRESENT: {list}
  SECTIONS_MISSING: {list}
  API_MISMATCHES: {list of references that don't match verified API}
  VERSION_MISMATCHES: {list}
  INSTALL_CORRECT: true|false

API_REFS:
  REFERENCES_CHECKED: {N}
  MISMATCHES: {N}

EXAMPLES:
  EXAMPLE_DIRS: {list or "none"}
  MISMATCHES: {N}

CONTRADICTIONS: {N}

FINDING_COUNT: {N}
FINDINGS:
- severity: {critical|warning|info}
  scope: {readme|api-refs|examples|contradiction}
  detail: {description}
  location: {file:section or file:line}
  verified_api_says: {correct value from Phase A}
  doc_says: {what the doc currently says}
  fix: {suggested fix}

Error handling:
- If the repo path does not exist, return: REPO: {repo-name}, STATUS: NOT_FOUND
- If README.md is missing, report SECTIONS_PRESENT: [], SECTIONS_MISSING: ["all"]
- If no markdown files are found, skip API_REFS scope
- If no example directories exist, report EXAMPLE_DIRS: "none", MISMATCHES: 0
```

**Main context retains:** Structured findings per repo.

---

### Sync Step 7: Cross-Repo Documentation Consistency

After collecting all per-repo findings, the main context performs cross-repo checks:

1. **Cross-repo API description consistency** — if apcore-python's README describes `Registry.get_module()` with certain behavior, and apcore-typescript's README describes `Registry.getModule()` differently, flag it
2. **Shared documentation links** — do all implementation repos link to the same docs site version?
3. **Doc repo vs implementation README alignment** — do implementation READMEs accurately reflect what the documentation repo's feature specs define?

---

### Sync Step 8: Phase B Report

```
=== PHASE B: Documentation Internal Consistency ===

--- Documentation Repos ---

{doc_repo_1} ({scope}):
  Spec chain layers: {list}
  Contradictions: {N}
  Completeness gaps: {N}
  Cross-ref issues: {N}

  CONTRADICTIONS:
    [WARNING] PRD S3.2 says "Registry supports glob patterns"
      but feature spec registry.md defines no glob parameter
    [WARNING] SRS REQ-012 references "Executor.run()"
      but tech design S4.1 calls it "Executor.execute()"

--- Implementation Repos ---

  Repo                    | README | API Refs | Examples | Cross-Doc
  apcore-python           |  PASS  |   PASS   |    —     |   PASS
  apcore-typescript       |  WARN  |   FAIL   |    —     |   FAIL

  MISMATCHES:
    [CRITICAL] apcore-typescript README Quick Start uses `findModule()`
       but verified API says `getModule()`
    [CRITICAL] apcore-typescript docs/usage.md says `execute(moduleId, input)`
       but verified API says `execute(moduleId, input, context?)`

--- Cross-Repo ---

  Cross-repo contradictions: {N}
  Link consistency: {PASS|FAIL}
```

---

### Sync Step 9: Combined Report

```
apcore-skills sync — Unified Consistency Report

Scope: {scope} | Languages: {langs} | Date: {date}
Phases: A (spec <-> code) + B (documentation)

=== PHASE A: Spec <-> Implementation ===

Checklist: {N} items | PASS: {n} | FAIL: {n} | WARN: {n}

{checklist table — only FAIL/WARN items expanded}

Spec compliance:
  {impl-repo-1}: {N}/{total} ({pct}%)
  {impl-repo-2}: {N}/{total} ({pct}%)

Cross-implementation:
  Total: {N} | Match: {N} | Missing: {N} | Mismatch: {N} | Naming: {N} | Type: {N}

=== PHASE B: Documentation Consistency ===

Doc repo internal:
  {doc-repo}: {N} contradictions, {N} gaps

Implementation repo docs:
  Repo                  | README | API Refs | Examples | Cross-Doc
  (matrix)

Cross-repo: {N} contradictions

=== COMBINED FINDINGS (sorted by severity) ===

CRITICAL:
  [A-001] Missing API: Registry.scan_directory()
    Repo: apcore-typescript
    Spec: defined in apcore/docs/features/registry.md
    Phase A — present in spec + Python, missing in TypeScript

  [B-001] Spec chain contradiction
    Doc repo: apcore
    PRD says "glob patterns" but feature spec has no glob param
    Phase B — internal documentation inconsistency

  [B-002] API reference mismatch
    Repo: apcore-typescript
    README uses findModule(), verified API says getModule()
    Phase B — implementation doc does not match verified code

WARNING:
  [A-002] ...
  [B-003] ...

INFO:
  ...

=== SUMMARY ===
  Phase A: {N} findings (critical: {n}, warning: {n}, info: {n})
  Phase B: {N} findings (critical: {n}, warning: {n}, info: {n})
  Total: {N} findings
  Contradictions (doc internal): {N}
  Contradictions (cross-repo): {N}
```

---

### Sync Step 10: Auto-Fix (only with --fix flag)

Group all findings from both phases by repo. Spawn one sub-agent **per repo that has fixable findings, all in parallel**.

**Sub-agent prompt for implementation repos:**

```
Apply sync fixes for {repo_path} ({language}).

Phase A findings to fix:
{naming, missing, type issues from Phase A}

Phase B findings to fix:
{readme, api-ref, examples issues from Phase B}

Fix rules (apply in order):

PHASE A FIXES (code):
1. NAMING FIXES — For each naming inconsistency:
   - Canonical name: {canonical} -> language convention: {expected_name}
   - Rename the function/method/class in its source file
   - Update the export in __init__.py / index.ts
   - Update any internal references within the same repo

2. MISSING API STUBS — For each missing symbol:
   - Generate a stub implementation in {language} with TODO markers
   - Match the signature from the spec (canonical form)
   - Add the export to the main module file
   - Create a corresponding test stub in tests/

3. VERIFY — After all Phase A fixes:
   - Run the full test suite: {pytest --tb=short -q | npx vitest run}
   - If any test fails due to a fix: revert ONLY that specific fix and note it

PHASE B FIXES (docs):
4. README FIXES — Add missing sections, update API names to match verified API, update version references
5. API REFERENCE FIXES — Update symbol names, param names, import paths in all markdown files
6. EXAMPLE FIXES — Update API usage and dependency versions in example code
7. CONTRADICTION FIXES — Resolve contradictions by aligning all docs to verified API

After all fixes:
1. List all files modified with a summary of changes
2. Do NOT commit — leave changes for user review

Return:
REPO: {repo-name}
PHASE_A_FIXES: {count} (naming: {n}, stubs: {n})
PHASE_B_FIXES: {count} (readme: {n}, api-refs: {n}, examples: {n}, contradictions: {n})
TEST_RESULT: {pass|fail|skipped}
TEST_COUNTS: {passed}/{total}
REVERTED_FIXES: {list or "none"}
FILES_MODIFIED: {list}
```

**Sub-agent prompt for documentation repos:**

```
Apply documentation consistency fixes for {doc_repo_path}.

Phase B findings to fix:
{spec chain contradictions, completeness gaps, cross-ref issues from Phase B}

Fix rules:

1. SPEC CHAIN CONTRADICTIONS — For each contradiction between documents:
   - Identify which document is the higher-authority source:
     Authority order: Feature Specs > Tech Design > SRS > PRD
   - Update the lower-authority document to match the higher-authority one
   - If the contradiction is between documents at the same level: flag for manual review, do NOT auto-fix

2. COMPLETENESS GAPS — For features mentioned in PRD/SRS but missing feature specs:
   - Do NOT generate feature specs automatically (too complex for auto-fix)
   - Add a TODO note in the appropriate location

3. CROSS-REFERENCE FIXES — Fix broken internal references

After all fixes:
1. List all files modified
2. Do NOT commit

Return:
DOC_REPO: {repo-name}
FIXES_APPLIED: {count}
FLAGGED_FOR_MANUAL_REVIEW: {count}
FILES_MODIFIED: {list}
MANUAL_REVIEW_ITEMS:
- {description of what needs human decision}
```

Display consolidated fix results:

```
Auto-fix results:

Implementation repos:
  apcore-typescript: Phase A: 3 naming fixes, 1 stub | Phase B: 2 readme fixes
    Tests: 287/287 OK
    Files: 5 changed
  apcore-mcp-typescript: Phase A: 1 naming fix | Phase B: 0
    Tests: 112/112 OK
    Files: 1 changed

Documentation repos:
  apcore: 2 contradiction fixes, 1 flagged for manual review
    Files: 2 changed
    Manual review: PRD S3.2 vs feature spec — need human decision on glob pattern scope

Uncommitted changes — review with:
  cd {repo} && git diff
```

---

# MODE: Audit (/apcore-skills:audit)

Comprehensive consistency audit across all apcore ecosystem repositories.

## Iron Law

**AUDIT EVERY DIMENSION. CLASSIFY EVERY FINDING. A partial audit creates false confidence.**

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

| # | Dimension | Severity Range | Description |
|---|---|---|---|
| D1 | API Surface | critical-warning | Public API alignment across languages |
| D2 | Naming Conventions | critical-warning | File/class/function naming per language rules |
| D3 | Version Sync | critical-info | Version alignment within sync groups |
| D4 | Documentation | warning-info | README, CHANGELOG, docstring completeness |
| D5 | Test Coverage | warning-info | Test file existence and coverage metrics |
| D6 | Dependencies | critical-warning | Dependency versions and compatibility |
| D7 | Configuration | warning-info | APCORE_* settings consistency across integrations |
| D8 | Project Structure | warning-info | File/directory layout per conventions |

## Severity Levels

| Level | Meaning | Action Required |
|---|---|---|
| `critical` | Breaking inconsistency — users will hit errors | Must fix before release |
| `warning` | Non-breaking inconsistency — confusing but functional | Should fix soon |
| `info` | Cosmetic or minor inconsistency | Nice to fix |

## Context Management

**All dimension audits and per-repo fixes are executed by parallel sub-agents.** The main context ONLY handles orchestration, aggregation, and reporting.

Step 2 spawns **up to 8 parallel sub-agents** (one per dimension, all simultaneously). Step 4 spawns **one parallel sub-agent per repo** for fixes.

## Workflow

```
Step 0 (ecosystem) -> Step 1 (parse args) -> Step 2 (parallel audits) -> Step 3 (report) -> [Step 4 (fix)]
```

### Audit Step 1: Parse Arguments and Plan Audit

#### 1.1 CWD-based Default Scope

**If `--scope` is NOT specified:**
1. Detect CWD repo name
2. Look up in discovered ecosystem:
   - `core-sdk` repo -> audit only this repo, dimensions D1-D3, D5-D6, D8
   - `mcp-bridge` repo -> audit only this repo, dimensions D1-D3, D5-D6, D8
   - `integration` repo -> audit only this repo, dimensions D2-D8
   - `protocol`/`docs-site` repo -> audit documentation dimensions only (D4)
   - `shared-lib`/`tooling` repo -> audit D2, D4, D5, D8
   - CWD not an apcore repo -> ask user which repo to audit

#### 1.2 Scope -> Repos & Dimensions

| Scope | Repos | Dimensions |
|---|---|---|
| `core` | Core SDKs | D1-D3, D5-D6, D8 |
| `mcp` | MCP bridges | D1-D3, D5-D6, D8 |
| `integrations` | Framework integrations | D2-D8 (no cross-API sync) |
| `all` | All repos | All dimensions |

### Audit Step 2: Execute Audit Dimensions (Parallel Sub-agents)

Spawn **all dimension sub-agents in parallel (up to 8 simultaneously)**. Each sub-agent audits exactly 1 dimension.

#### D1 — API Surface Audit
Compare exports across SDKs: count total exports, categorize (classes, functions, types, enums), list constructor params and method names per class, find missing symbols and method count mismatches.

#### D2 — Naming Conventions Audit
Check file naming (snake_case.py, kebab-case.ts), function/class naming patterns, package names, error class suffixes, enum value casing.

#### D3 — Version Sync Audit
Check core SDK versions match (major.minor), MCP bridge versions match, internal version consistency (pyproject.toml == __init__.py), integration dependency versions.

#### D4 — Documentation Audit
Check README.md exists with required sections, CHANGELOG.md exists and follows format, LICENSE exists, key source files have docstrings/JSDoc.

#### D5 — Test Coverage Audit
Check tests/ directory exists, count test files, map source to test files for gaps, run test suite, capture coverage.

#### D6 — Dependencies Audit
Check schema validation lib versions, MCP SDK versions, cross-repo dependency compatibility, dev dependencies (linter, type checker, test framework).

#### D7 — Configuration Audit (integrations only)
Extract all APCORE_* settings from config files, compare across integrations for type/default consistency. Required settings: APCORE_ENABLED, APCORE_DEBUG, APCORE_SCANNERS, APCORE_INCLUDE_PATHS, APCORE_EXCLUDE_PATHS, APCORE_MODULE_PREFIX, APCORE_AUTH_ENABLED, APCORE_TRANSPORT, APCORE_HOST, APCORE_PORT.

#### D8 — Project Structure Audit
Check expected directory layout per repo type (Core SDKs: src/ with middleware/, registry/, schema/, observability/, utils/; MCP bridges: src/ with server/, auth/, adapters/, converters/; Integrations: scanners/, output/, cli).

**Each sub-agent returns findings in structured format:**
```
DIMENSION: D{N} — {Name}
FINDING_COUNT: {N}
FINDINGS:
- severity: {critical|warning|info}
  repo: {repo-name}
  detail: {description}
  location: {file:line if applicable}
  fix: {suggested fix}
```

### Audit Step 3: Aggregate and Display Report

```
apcore-skills audit — Ecosystem Consistency Report

Date: {date}
Scope: {scope}
Repos audited: {count}

=== SUMMARY ===

  Dimension              | Critical | Warning | Info
  D1 API Surface         |    2     |    3    |   1
  D2 Naming Conventions  |    0     |    5    |   3
  D3 Version Sync        |    1     |    0    |   0
  D4 Documentation       |    0     |    2    |   4
  D5 Test Coverage       |    0     |    1    |   2
  D6 Dependencies        |    1     |    2    |   0
  D7 Configuration       |    0     |    3    |   1
  D8 Project Structure   |    0     |    1    |   2
  -----------------------------------------------
  TOTAL                  |    4     |   17    |  13

=== CRITICAL FINDINGS ===
(expanded details with repo, location, fix)

=== WARNING FINDINGS ===
(grouped by dimension)

=== INFO FINDINGS ===
(grouped by dimension)

=== HEALTH SCORE ===
  Overall: {score}/100
  API Consistency: {score}/100
  Naming: {score}/100
  Version Sync: {score}/100
  Documentation: {score}/100
  Test Coverage: {score}/100
  Dependencies: {score}/100
```

### Audit Step 4: Auto-Fix (only with --fix flag)

Group fixable findings by repo. Spawn one sub-agent per repo.

**Unfixable (skip and report):**
- API surface fixes (complex — delegate to `/apcore-skills:sync --phase a --fix`)
- Dependency fixes (risky — show as recommendations only)

**Fixable:** Naming (D2), Version (D3), Structure (D8), Documentation (D4). Run tests after each repo's fixes. Revert any fix that breaks tests.

---

# MODE: SDK (/apcore-skills:sdk)

Bootstrap a new apcore core SDK or MCP bridge in a new language.

## Iron Law

**EVERY NEW SDK MUST IMPLEMENT THE FULL PROTOCOL API CONTRACT. No partial SDKs — if you ship it, it must cover all exported symbols from the reference implementation.**

## Anti-Rationalization Table

| Thought | Reality |
|---------|---------|
| "I'll start with just the core classes" | Start with a complete project skeleton. Feature implementation order is code-forge's job. |
| "Copy the Python structure exactly" | Use idiomatic target-language patterns. Same concepts, different structure. |
| "Tests can come later" | TDD is mandatory. Test infrastructure is set up in scaffolding. |
| "I'll figure out the naming as I go" | Naming is defined by conventions. Apply language rules from day one. |

## Command Format

```
/apcore-skills:sdk <language> [--type core|mcp] [--ref apcore-python]
```

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `<language>` | Yes | — | Target language: `go`, `rust`, `java`, `csharp`, `kotlin`, `swift`, `php` |
| `--type` | No | `core` | What to scaffold: `core` (SDK) or `mcp` (MCP bridge) |
| `--ref` | No | auto-detect | Reference implementation to extract API from |

## Workflow

```
Step 0 (ecosystem) -> 1 (parse args) -> 2 (extract API contract) -> 3 (tech stack) -> 4 (scaffold) -> 5 (feature specs) -> 6 (plan generation) -> 7 (summary)
```

### SDK Step 1: Parse Arguments

1. Extract `<language>` — required, ask if missing
2. Extract `--type` — default `core`
3. Extract `--ref` — resolve reference repo: if CWD is same-type apcore repo, use it; otherwise auto-detect (core: `apcore-python`, mcp: `apcore-mcp-python`)
4. Derive target repo name: Core SDK = `apcore-{lang}`, MCP bridge = `apcore-mcp-{lang}`
5. Check if target directory already exists

### SDK Step 2: Extract API Contract (Sub-agent)

Spawn sub-agent to extract the complete public API from the reference implementation. Read main exports, all class/function/type signatures, error hierarchy, middleware interfaces, extension points. Return structured API contract (~5-8KB).

### SDK Step 3: Confirm Tech Stack

Ask user about language-specific choices:
- **Go:** Go version, module path, test framework, schema validation lib
- **Rust:** Edition, async runtime (tokio), serialization (serde), schema lib
- **Java:** Java version, build tool (Gradle/Maven), schema lib (Jackson), test framework (JUnit 5)
- **Other languages:** Open-ended tech stack question

### SDK Step 4: Scaffold Project (Sub-agent)

Spawn sub-agent to create project skeleton with:
- Build config, .gitignore, README.md, CHANGELOG.md, LICENSE
- Source files with stubs for all API symbols (correct signatures, TODO markers)
- Core SDK: executor, context, module, config, errors, acl, approval, async_task, bindings, decorator, extensions, cancel, trace_context, middleware/, registry/, schema/, observability/, utils/
- MCP bridge: server/, auth/, adapters/, converters/, cli, explorer/
- Test directory with config

### SDK Step 5: Generate Feature Specs

Link to existing feature specs from the documentation repo, or generate lightweight specs per module.

### SDK Step 6: Generate .code-forge.json

Write config for code-forge planning integration. Leave git initialization to the user.

### SDK Step 7: Display Summary

Show scaffolded project tree, next steps (code-forge:port, code-forge:impl, apcore-skills:sync).

---

# MODE: Integration (/apcore-skills:integration)

Bootstrap a new framework integration that connects a web framework to the apcore ecosystem.

## Iron Law

**EVERY INTEGRATION MUST IMPLEMENT THE SAME 5 CORE CAPABILITIES: scan endpoints, register modules, map request context, serve via MCP, and export to OpenAI tools format.**

## Anti-Rationalization Table

| Thought | Reality |
|---------|---------|
| "This framework is different" | The 5 core capabilities are the same. Only framework-specific adapters differ. |
| "I'll skip the demo project" | Demo projects are how users evaluate integrations. Always include one. |
| "CLI commands can come later" | CLI is the primary UX. `scan` and `serve` commands are required from day one. |
| "I'll just wrap the core SDK directly" | Integrations must use apcore-discovery for scanner logic to ensure consistency. |

## Command Format

```
/apcore-skills:integration <framework> [--lang python|typescript|go] [--ref django-apcore]
```

## 5 Core Capabilities

| # | Capability | Description | CLI Command |
|---|---|---|---|
| 1 | **Endpoint Scanner** | Discover framework routes -> apcore modules | `{framework} apcore scan` |
| 2 | **Module Registry** | Register scanned endpoints as apcore modules | (automatic) |
| 3 | **Context Mapping** | Map framework request -> apcore Context | (automatic) |
| 4 | **MCP Server** | Start MCP server exposing modules as tools | `{framework} apcore serve` |
| 5 | **OpenAI Export** | Export modules as OpenAI tool definitions | `{framework} apcore export` |

## Workflow

```
Step 0 (ecosystem) -> 1 (parse args) -> 2 (analyze reference) -> 3 (framework research) -> 4 (scaffold) -> 5 (demo project) -> 6 (plan) -> 7 (summary)
```

### Integration Step 1: Parse Arguments

1. Extract `<framework>` — required, ask if missing
2. Extract `--lang` — auto-detect from framework (Python: fastapi/flask/django; TypeScript: express/fastify/nestjs; Go: gin/echo/fiber; etc.)
3. Extract `--ref` — resolve reference integration (same-language preferred)
4. Derive target: `{framework}-apcore`

### Integration Step 2: Analyze Reference Integration (Sub-agent)

Analyze reference integration's extension mechanism, configuration (APCORE_* settings), scanner pattern, context mapping, CLI commands, demo structure.

### Integration Step 3: Framework-Specific Research

Ask user about routing mechanisms, authentication patterns, API definition style.

### Integration Step 4: Scaffold Project (Sub-agent)

Create project skeleton with: extension entry point, config with all APCORE_* settings, scanners/, output/, cli, context mapping, registry, tests/, examples/demo/ with Dockerfile.

### Integration Step 5: Generate Demo Project

Minimal app with 3-5 sample CRUD endpoints, apcore integration, docker-compose.yml.

### Integration Step 6: Generate Code-Forge Config and Feature Specs

Feature specs: scanner, config, context, registry, cli, observability.

### Integration Step 7: Display Summary

Show scaffolded structure, core capability status, next steps.

---

# MODE: Release (/apcore-skills:release)

Execute a coordinated release across multiple apcore ecosystem repositories.

## Iron Law

**NEVER PUSH WITHOUT EXPLICIT USER APPROVAL. All changes are committed locally and presented for review before any push.**

## Anti-Rationalization Table

| Thought | Reality |
|---------|---------|
| "I'll just bump the version number" | Version exists in 2-3 files per repo. Miss one and imports break. |
| "CHANGELOG can be updated later" | CHANGELOG is part of the release artifact. Generate it now from git log. |
| "Tests passed last time, skip them" | Test every repo after version bump. Dependency changes can break things. |
| "I'll push one repo at a time" | Coordinate all repos first, push together after approval. |

## Command Format

```
/apcore-skills:release <version> [--scope core|mcp|integrations|all] [--dry-run]
```

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `<version>` | Yes | — | Target version (e.g., `0.9.0`, `1.0.0`) |
| `--scope` | No | **cwd** | Which repos to release |
| `--dry-run` | No | off | Show what would change without making changes |

## Workflow

```
Step 0 (ecosystem) -> 1 (parse & validate) -> 2 (pre-flight) -> 3 (version bump) -> 4 (changelog) -> 5 (deps update) -> 6 (test) -> 7 (commit) -> 8 (summary) -> [9 (push)]
```

### Release Step 1: Parse Arguments and Validate

Extract `<version>` (required, semver format X.Y.Z), `--scope` (CWD-based default), `--dry-run`.

For `all` scope, ask user for version per group (core SDKs, MCP bridges, integrations).

### Release Step 2: Pre-flight Checks (Parallel Sub-agents)

Per repo: git status (must be clean), branch (should be main/master), current version, recent tags.

For repos with issues, ask user: "Stash changes" / "Skip this repo" / "Abort".

### Release Step 3: Version Bump (Parallel Sub-agents)

Per repo: update ALL version files:
- Python: pyproject.toml, __init__.py, _version.py
- TypeScript: package.json, index.ts VERSION, package-lock.json
- Go: internal/version.go
- Rust: Cargo.toml, Cargo.lock
- Java: pom.xml or build.gradle
- Also: README.md version badges

### Release Step 4: CHANGELOG Generation (Parallel Sub-agents)

Per repo: read git log since last tag, categorize commits (Added, Changed, Fixed, Breaking, Documentation), prepend new entry to CHANGELOG.md.

### Release Step 5: Cross-Repo Dependency Updates (Parallel Sub-agents)

For integration repos depending on released core SDKs: update version constraints in build config.

### Release Step 6: Test Verification (Parallel Sub-agents)

Per repo: run full test suite (detect language, use appropriate runner). If any fail, ask user: "Fix and retry" / "Skip this repo" / "Abort release".

### Release Step 7: Commit Changes

Stage only modified files (NEVER `git add -A`). Commit with `release: v{new_version}`.

### Release Step 8: Release Summary and Approval

Display complete summary table. Ask user:
- "Review changes first" -> show git diff
- "Push all repos" -> Step 9
- "Push selected repos" -> Step 9 with selection
- "Done (keep local, don't push)"

### Release Step 9: Push and Tag (only with explicit approval)

For each approved repo: `git push origin {branch} && git tag v{new_version} && git push origin v{new_version}`.

If push fails: display error, ask "Retry" / "Skip" / "Abort remaining". Never force-push.

Display next steps: create GitHub releases, publish packages, update docs, announce.

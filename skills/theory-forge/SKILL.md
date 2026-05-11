# theory-forge — Professional Academic Theory Auditor

A specialized orchestrator for auditing academic theory documentation (markdown-based foundations, specs, and glossaries). Detects fabricated citations, formal-definition drift, falsifiability gaps, and argument structure flaws.

## Commands

### `/theory-forge`
**Description**: Main orchestrator. Routes to dashboard (no args), full-suite audit (path arg), or specific sub-audits.
**Procedure**: @./commands/theory-forge.md

### `/theory-forge:cite-audit`
**Description**: Audit citations for truth, attribution, and bibliography completeness.
**Procedure**: @./commands/cite-audit.md

### `/theory-forge:consistency`
**Description**: Audit cross-section semantic coherence and definition drift.
**Procedure**: @./commands/consistency.md

### `/theory-forge:falsifiability`
**Description**: Audit claims for falsifiability, evidence grounding, and hypothesis markers.
**Procedure**: @./commands/falsifiability.md

### `/theory-forge:argument-structure`
**Description**: Audit the logical flow and evidence-backing of arguments.
**Procedure**: @./commands/argument-structure.md

### `/theory-forge:scope`
**Description**: Audit the stated vs. actual empirical scope of the theory.
**Procedure**: @./commands/scope.md

### `/theory-forge:concept-import`
**Description**: Audit cross-disciplinary concept imports for semantic fidelity.
**Procedure**: @./commands/concept-import.md

### `/theory-forge:counter-argument`
**Description**: Audit how the project addresses and integrates counter-arguments.
**Procedure**: @./commands/counter-argument.md

### `/theory-forge:cross-lang`
**Description**: Audit consistency across multi-language documentation mirrors.
**Procedure**: @./commands/cross-lang.md

### `/theory-forge:propagate`
**Description**: Propagate a changed definition to all downstream mentions.
**Procedure**: @./commands/propagate.md

### `/theory-forge:help`
**Description**: Display detailed help and usage examples.
**Procedure**: @./commands/help.md

## Operational Standards
- **Sub-agent Delegation**: For full-suite audits, use `invoke_agent` with the `generalist` agent in parallel waves.
- **Read-Only by Default**: Most audits produce a `_research/` report and only propose fixes with explicit user opt-in.
- **Severity Discipline**: Always apply the `references/academic-severity-levels.md` rubric.
- **Reporting**: Save all outputs to `_research/` to avoid polluting the main documentation.

# theory-forge — Professional Academic Theory Auditor

**Academic-Rigor Toolkit for Theory Documentation in Gemini CLI**

`theory-forge` is the academic counterpart to `spec-forge` (software) and `code-forge` (implementation). It is built for documents whose ground truth is **scholarship**, not code: theoretical-framework papers, monographs, theses, foundation docs for research projects, and any long-form work whose claims must stand against citation, falsifiability, and cross-linguistic scrutiny.

## Core Mandate: 大胆假设，小心求证 (Bold Hypothesis, Rigorous Verification)

The skill does NOT suppress speculative claims; bold hypotheses are scientifically valuable. The skill enforces **honest labeling**:
- **Verified** claims (with citation + replicable evidence) must hold against scrutiny.
- **Hypotheses** are welcome — but must be explicitly marked ("We hypothesize...", "[unverified]").
- **Unmarked speculation passed as established fact** is the failure mode the audit catches.

## Commands

### `/theory-forge`
**Description**: Main orchestrator. Routes to dashboard (no args), full-suite audit in parallel waves (path arg), or specific sub-audits.
**Procedure**: @./commands/theory-forge.md

### `/theory-forge:cite-audit`
**Description**: Verify every citation exists, is correctly attributed, and is in the bibliography. Uses CrossRef → Semantic Scholar → OpenAlex.
**Procedure**: @./commands/cite-audit.md

### `/theory-forge:consistency`
**Description**: Audit cross-section semantic coherence (formal-definition drift) and granularity-aware T1/T2/T3 consistency.
**Procedure**: @./commands/consistency.md

### `/theory-forge:falsifiability`
**Description**: Classify claims (Type A/B/C/D/E) and check for methodology + falsification conditions.
**Procedure**: @./commands/falsifiability.md

### `/theory-forge:argument-structure`
**Description**: Audit Major claims for Toulmin elements (Claim + Data + Warrant + Qualifier + Rebuttal) and 10 common fallacies.
**Procedure**: @./commands/argument-structure.md

### `/theory-forge:scope`
**Description**: Audit boundary-condition discipline (catches unbounded generalizations).
**Procedure**: @./commands/scope.md

### `/theory-forge:concept-import`
**Description**: Audit cross-disciplinary borrowing for T1 technical / T2 partial / T3 metaphorical marking.
**Procedure**: @./commands/concept-import.md

### `/theory-forge:counter-argument`
**Description**: Audit engagement with canonical opposing positions per topic.
**Procedure**: @./commands/counter-argument.md

### `/theory-forge:cross-lang`
**Description**: Audit cross-linguistic universality claims for typological family coverage (≥3 families).
**Procedure**: @./commands/cross-lang.md

### `/theory-forge:propagate`
**Description**: Propagate foundation document changes downstream through the doc chain.
**Procedure**: @./commands/propagate.md

### `/theory-forge:help`
**Description**: Display detailed command reference and workflow recipes.
**Procedure**: @./commands/help.md

## Operational Standards
- **Read-Only by Default**: Audits read and report to `_research/`. Edits require explicit user opt-in.
- **Severity Discipline**: Critical (stop before publication) / Major (address before submission) / Minor (polish) / Info (positive practice).
- **Parallel waves**: Full-suite audit runs in two parallel waves of 4 to optimize wall-clock time.
- **Reference Grounding**: Use `BIBLIOGRAPHY.md` for tool self-audit and `references/language-data.md` for cross-linguistic verification.

## See Also
- `README.md` — Detailed introduction and design principles.
- `RELEASE-NOTES.md` — Version history and recent optimizations.
- `docs/usage.md` — End-to-end workflow recipes.
- `_research/self-audit-report.md` — Known gaps in this tool.

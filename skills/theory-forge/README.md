# theory-forge

**Academic-Rigor Toolkit for Theory Documentation in Gemini CLI**

`theory-forge` is the academic counterpart to `spec-forge` (software) and `code-forge` (implementation). It is built for documents whose ground truth is **scholarship**, not code: theoretical-framework papers, monographs, theses, foundation docs for research projects, and any long-form work whose claims must stand against citation, falsifiability, and cross-linguistic scrutiny.

## Quick Start

```bash
# 1. See the dashboard with usage examples for all commands
/theory-forge

# 1b. Get help (same content as dashboard, without the project-status header)
/theory-forge help

# 1c. Get detailed help for one command
/theory-forge help cite-audit

# 2. Run the full audit suite (all 8 audits, sequential)
/theory-forge .

# 3. Or pick a single audit
/theory-forge:cite-audit              # citation truth + bibliography integrity
/theory-forge:consistency             # cross-section coherence
/theory-forge:falsifiability          # Type A/B/C/D/E framing
/theory-forge:argument-structure      # Toulmin completeness + fallacies
/theory-forge:scope                   # boundary-condition discipline
/theory-forge:concept-import          # cross-disciplinary borrowing tiers
/theory-forge:counter-argument        # engagement with opposing positions
/theory-forge:cross-lang              # cross-linguistic example coverage

# 4. After editing a foundational definition, propagate downstream
/theory-forge:propagate docs/foundations/core-concept.md
```

All audit reports land in `<project>/_research/`. See [`docs/usage.md`](./docs/usage.md) for end-to-end workflow recipes (pre-submission audit, definition revision, interdisciplinary import review, etc.).

## When to Use

Use theory-forge when you are editing or maintaining:

- A **theoretical framework** (linguistics, cognitive science, philosophy of language, education theory, formal pragmatics, computational semantics)
- A **research monograph** or **doctoral thesis** with non-trivial citation density
- **Foundation documents** of a research project where claims must trace to peer-reviewed scholarship
- Documents making **cross-linguistic universality claims** that require typologically diverse examples
- Documents making **descriptive empirical claims** that should be Popperian-falsifiable

Do **not** use theory-forge for software specs (`spec-forge`), implementation work (`code-forge`), or generic collaborative documents (`doc-coauthoring`).

### Scope of validation

theory-forge 0.2.0 has been **calibrated against English-language theory documents** (specifically the CFLT — Core-First Language Theory — corpus). Behavior on non-English documents is not yet validated. The plugin operates on the document's source language; multilingual mirrors (e.g., `docs/zh/`, `docs/ja/`) should be audited independently with the same skill, but results have not been verified.

Domains tested:
- ✓ Linguistics / cognitive linguistics (CFLT)
- ✗ Cognitive science (untested)
- ✗ Philosophy of language (untested)
- ✗ Education theory / SLA (untested)
- ✗ Other humanities and sciences (untested)

Use outside the tested domain is at the user's discretion. The skill structure is domain-neutral; calibration may need tuning for project-specific conventions.

## Design Principles

1. **Citations are claims about scholarship, not decoration.** Every cited paper must (a) exist, (b) say what the text claims, (c) appear in the bibliography. `cite-audit` enforces all three.
2. **Read-only by default.** Audits read and report. Edits to your documents require explicit user opt-in at the end of each command.
3. **Severity discipline.** Findings are classified Critical / Major / Minor / Info so you can fix what matters first.
4. **大胆假设，小心求证 — Bold Hypothesis, Rigorous Verification.** The skill does NOT suppress speculative claims; bold hypotheses are scientifically valuable and often the most interesting parts of a theory paper. The skill enforces **honest labeling**:
   - **Verified** claims (with citation + replicable evidence) must hold against scrutiny
   - **Hypotheses** are welcome — *but must be explicitly marked* ("We hypothesize...", "[unverified]", section labeled "Open Questions")
   - **Unmarked speculation passed as established fact** is the failure mode the audit catches
5. **Cross-linguistic realism.** Universality claims need typologically diverse examples; the skill catches English-only "universals."
6. **Anti-hallucination by construction.** Generation modes (cross-lang `--generate`) produce *scaffolds* by default, not concrete content. Concrete generation requires explicit user acknowledgment and is always marked as machine-drafted.
7. **Reproducible.** Reports go to `_research/` so they can be re-run and version-controlled.

## Output

All audit reports are written to `<docs-root>/_research/` (underscore-prefix so MkDocs and similar generators can be configured to ignore them by default):

- `_research/citation-audit.md` — fabricated / mis-attributed / orphan / unused citations
- `_research/consistency-report.md` — cross-section component-list inconsistencies
- `_research/falsifiability-audit.md` — claims classified A/B/C/D/E, gaps flagged
- `_research/argument-structure-report.md` — Toulmin coverage per claim, fallacy detections
- `_research/scope-audit.md` — unbounded generalizations, scope-discipline practice
- `_research/concept-import-audit.md` — cross-disciplinary borrowing tier audit
- `_research/counter-argument-audit.md` — engagement-with-opposition profile
- `_research/cross-lang-audit.md` — universality-claim coverage by language family
- `_research/propagation-report-{timestamp}.md` — downstream edits proposed for a definition change
- `_research/theory-forge-master-report.md` — full-suite aggregate

## Counter-Argument Engagement

Before adopting theory-forge, the following objections deserve substantive consideration:

### Objection 1 — "Audit tools impose mechanical standards on craftwork"

*Position*: Scholarly writing is a craft; automating its evaluation reduces it to checklist compliance. (A view in some humanities and STS circles.)

*theory-forge's response*: The skill does not prescribe writing style or rhetorical choices — it surfaces issues for the author's judgement. Read-only by default. Every "finding" is an item the author chooses to act on or not. The audit is a **second pair of eyes**, not a copy-editor or a gatekeeper.

### Objection 2 — "LLM-based audits will hallucinate audits"

*Position*: A skill that uses an LLM to detect issues will itself produce false-positive issues; the audit may be worse than nothing.

*theory-forge's response*: This is a legitimate risk and has driven multiple design choices:
- Critical findings are NEVER auto-fixed (cite-audit Step 8)
- `--generate` modes produce scaffolds by default, not concrete content (cross-lang)
- Conservative threshold defaults (cite-audit keyword-alignment); calibration is required before trusting reports
- Charitable reading principle in falsifiability, consistency, scope, concept-import, counter-argument skills
- Severity is intentionally calibrated to favor under-reporting over over-reporting

The audit's failure mode is **silently missing issues** — not **flagging non-issues as Critical**. We accept the former as a controlled risk.

### Objection 3 — "Authors should use peer review, not auto-tools"

*Position*: Peer review is the established quality-control mechanism for scholarship; theory-forge is duplicative or distracting.

*theory-forge's response*: Peer review and theory-forge address different stages. Peer review is post-submission; theory-forge is pre-submission, before peer reviewers waste their time on issues the author could fix mechanically. The skill targets the iteration loop **before** submission, not after.

### Objection 4 — "Software-style automation can't capture academic nuance"

*Position*: Scholarly judgment cannot be reduced to detection rules.

*theory-forge's response*: Correct — and the skill does not attempt to. It flags **specific, well-defined failure modes** (orphan citations, formal-definition drift, unmarked speculation, unbounded generalizations, concept-smuggling) where mechanical detection is reliable. Judgment-heavy issues (whether a hypothesis is fruitful, whether an argument is convincing) are left to peer review and the author.

### What we are NOT claiming

- theory-forge does NOT replace peer review
- theory-forge does NOT guarantee a "clean" status corresponds to high scholarly quality
- theory-forge does NOT enforce any single philosophy of science (the Popperian framing in `falsifiability` is one option among many)
- theory-forge does NOT cover all academic methodology issues — see `_research/self-audit-report.md` for known gaps

## License

MIT. See [LICENSE](./LICENSE).

## See Also

- [`spec-forge`](https://github.com/tercel/spec-forge) — software specifications
- [`code-forge`](https://github.com/tercel/code-forge) — implementation workflow

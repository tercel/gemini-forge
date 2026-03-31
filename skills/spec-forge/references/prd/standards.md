# PRD Standards

## Mermaid Diagrams

Mermaid diagrams make the PRD scannable and visually informative. This skill uses three types of diagrams.

**User Journey Flowcharts.** Use `graph TD` or `graph LR` to show the step-by-step path a user takes through the feature. Include decision nodes for branching logic and clearly label happy-path versus error-path flows.

**Feature Architecture Diagrams.** Use `graph TD` to show the high-level component relationships: which services, APIs, data stores, and external systems interact. This is not a detailed system design; it is a conceptual map that helps non-engineers understand the moving parts.

**Gantt Charts for Timelines.** Use `gantt` to lay out phases, milestones, and dependencies over time. Include sections for design, development, testing, and launch. Mark critical-path items.

All Mermaid code blocks must use the ` ```mermaid ` fence so they render correctly in GitHub, GitLab, and most Markdown viewers.

## PRD ID Naming Convention

Every requirement, risk, and trackable item in the PRD receives a unique identifier following this pattern:

```
PRD-<MODULE>-<NNN>
```

- **PRD** is the fixed prefix indicating the document type.
- **MODULE** is a short uppercase code (three to five characters) representing the feature area or module. Examples: `AUTH`, `PAY`, `DASH`, `NOTIF`, `ONBRD`.
- **NNN** is a zero-padded three-digit sequence number starting at 001.

Examples: `PRD-AUTH-001`, `PRD-PAY-012`, `PRD-DASH-003`.

This convention ensures IDs are grep-friendly, sort-friendly, and unambiguous across multiple PRDs in the same repository.

## Feature Prioritization

Requirements are prioritized using a three-tier system.

- **P0 -- Must Have.** The feature cannot ship without these requirements. They address core user needs or regulatory obligations. If a P0 item is cut, the launch must be reconsidered.
- **P1 -- Should Have.** These requirements significantly improve the user experience or business outcome but are not strictly necessary for a minimum viable launch. They are the first candidates for inclusion if the timeline allows.
- **P2 -- Nice to Have.** These are enhancements, polish items, or forward-looking capabilities that can be deferred to a subsequent release without materially affecting the launch.

When assigning priorities, tie each decision back to the goals defined earlier in the document. If a requirement does not clearly support a stated goal, question whether it belongs in this PRD at all.

## Anti-Shortcut Rules

The following shortcuts are **strictly prohibited** — they are common AI failure modes that produce low-quality PRDs:

1. **Do NOT fabricate market data.** TAM/SAM/SOM numbers without a cited source are worthless. If real data is unavailable, state "data not available" and recommend the user research it — never invent numbers.
2. **Do NOT skip or trivialize competitive analysis.** Listing zero or only one competitor is unacceptable. Every market has at least indirect competitors. Analyze a minimum of 2 competitors with honest strengths and weaknesses.
3. **Do NOT rubber-stamp the GO verdict.** A feasibility analysis that always concludes "GO" adds no value. Evaluate technical, business, and resource feasibility honestly — CONDITIONAL GO and NO-GO are valid and valuable outcomes.
4. **Do NOT use vague language instead of specific metrics.** Phrases like "improve user experience", "high performance", or "scalable system" are meaningless without numbers. Every success metric must have a concrete target (e.g., "page load < 2s at p95", "NPS > 40").
5. **Do NOT skip the "What happens if we don't build this?" analysis.** This is a critical anti-pseudo-requirement check. If the answer is "nothing significant changes", the feature may not be worth building.

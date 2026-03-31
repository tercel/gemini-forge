# PRD Writing Guidelines

## Key Sections

The following guidelines apply when writing each section of the PRD.

**Document Information and Revision History.** Fill in all metadata fields. Use the current date. Set the initial version to `0.1` and the status to `Draft`. The revision history table must have at least one entry corresponding to the initial draft.

**Executive Summary.** Write two to four sentences that a busy executive can read in under thirty seconds. State the problem, the proposed solution, and the expected impact. Avoid jargon.

**Product Overview and Background.** Provide enough context so that a new team member can understand why this initiative exists. Reference prior PRDs or design documents when they exist in the repository.

**Market Research and Analysis.** This section proves that the product addresses a real market opportunity, not an imagined one. Include market sizing (TAM/SAM/SOM) with cited sources — never fabricate market data. Map the competitive landscape with at least two competitors, honestly acknowledging their strengths. Clearly articulate what differentiates this product. Include industry trends that support the initiative's timing. This section should answer: "Is there a real market for this?"

**Value Proposition and Validation.** This is the anti-pseudo-requirement section. State the value proposition in one sentence. Then provide hard evidence of real demand from at least three sources: user interviews, survey data, support ticket patterns, usage analytics, beta test results, or revenue impact estimates. Include a "What happens if we don't build this?" subsection that quantifies the cost of inaction. If sufficient evidence does not exist, the PRD should honestly flag this and recommend a validation phase before committing engineering resources.

**Feasibility Analysis.** Assess technical feasibility (technology readiness, infrastructure, POC status), business feasibility (revenue model, ROI, strategic alignment), and resource feasibility (team availability, skills, budget, timeline). Conclude with a clear GO / CONDITIONAL GO / NO-GO verdict. A well-reasoned NO-GO saves more resources than a poorly justified GO. Do not rubber-stamp everything as GO.

**Problem Statement.** Structure this section around three lenses: the current situation, the pain points users experience, and the opportunity that addressing those pain points unlocks. Use data or user quotes when available.

**Goals and Non-Goals.** Goals must be specific, measurable, and time-bound. Non-goals are equally important; they tell the team what is explicitly out of scope so energy is not wasted on tangential work.

**User Personas.** Define at least two personas in table format. Each persona should have a name, role, demographic summary, core needs, and pain points. Personas must be referenced later in user stories.

**User Stories and Acceptance Criteria.** Every user story follows the canonical format: "As a [user type], I want [action] so that [benefit]." Each story must have at least two acceptance criteria written as testable conditions.

**Functional Requirements Overview.** List requirements in a table. Each row gets a unique ID following the naming convention described below, a short feature name, a description, a priority, a **Priority Rationale**, and a status. The Priority Rationale must answer "why this tier and not the one above or below" — referencing user impact, business consequence, or the presence/absence of an acceptable workaround. Never assign a priority without this justification; undefended priorities are flagged during the quality check.

**Success Metrics.** Every metric must have a target value and a measurement method. Include the current baseline when known. Tie metrics back to the goals defined earlier.

**Timeline, Milestones, and Risk Assessment.** Use Mermaid Gantt charts for the timeline. Risks go in a matrix with likelihood, impact, mitigation strategy, and an owner.

**Dependencies, Open Questions, and Appendix.** Capture anything that blocks progress, anything still unresolved, and any supplementary material such as raw research data, detailed competitive analysis spreadsheets, or wireframe links.

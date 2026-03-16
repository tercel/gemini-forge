---
description: "Generate a deep-dive technical analysis report for developers, tech leads, and AI investors. Performs 4-phase analysis: Deep Scan → Market Intelligence → Value Modeling → Report Generation. Outputs include architecture diagrams (Mermaid), data-driven competitor matrices, and investment assessments."
---

# Hype-Forge — Report

Generate high-authority technical analysis reports that translate engineering depth into strategic insight. Designed for audiences who make adoption or investment decisions.

## Command: `/hype-forge:report`

### Usage:
`/hype-forge:report [project-path-or-url] [--audience investor|tech-lead|dev-community|general] [--lang en|zh]`

- `project-path-or-url`: Local project path (default: current directory) or a documentation URL to analyze.
- `--audience`: Tailors depth, tone, and emphasis (default: `tech-lead`).
- `--lang`: Output language (default: `en`).

---

## Execution Workflow

You MUST execute these 4 phases in order. Each phase feeds the next.

### Phase 1: Deep Scan (Context Acquisition)

Thoroughly scan the project to build a technical mental model.

**Actions:**
1. Read `README.md`, `package.json` / `pyproject.toml` / `Cargo.toml` for identity, dependencies, and tech stack.
2. Use `Glob` and `Grep` to identify:
   - Core entry points and module boundaries.
   - Architectural patterns (e.g., plugin system, middleware chain, schema-driven, event-sourced).
   - Performance-critical paths (caching, async, pooling, lazy-loading).
   - Security mechanisms (auth, ACL, input validation, secrets handling).
   - Observability hooks (logging, tracing, metrics).
3. If a documentation URL is provided, use `WebFetch` to extract the official spec/docs.
4. Summarize findings into an internal brief (do NOT output this to the user):
   - **Identity**: Name, version, license, language(s).
   - **Architecture Pattern**: The dominant 1-2 patterns.
   - **Innovation Candidates**: 3-5 features that are technically novel or differentiated.
   - **Quality Signals**: Test coverage indicators, CI config, type safety, error handling.

### Phase 2: Market Intelligence (Competitive Landscape)

Research the competitive landscape using web search. This phase is critical for credibility.

**Actions:**
1. Use `WebSearch` to find:
   - 3-5 direct competitors or alternatives in the same problem space.
   - GitHub star counts, npm/PyPI download stats, or other popularity metrics for each competitor.
   - Recent benchmark comparisons or technical reviews (blog posts, HN discussions).
   - Industry trend data (e.g., "AI agent framework adoption 2025-2026").
2. Build a **Competitor Intelligence Table** (internal, will be formatted in Phase 4):

   | Dimension | Project | Competitor A | Competitor B | Competitor C |
   |-----------|---------|-------------|-------------|-------------|
   | GitHub Stars | ? | ? | ? | ? |
   | Weekly Downloads | ? | ? | ? | ? |
   | Language Support | ? | ? | ? | ? |
   | Key Differentiator | ? | ? | ? | ? |
   | Weakness | ? | ? | ? | ? |

3. If real data is unavailable, clearly mark estimates as `[estimated]` — never fabricate exact numbers.

### Phase 3: Value Modeling (Innovation → Business Value)

Transform technical findings into value propositions for the target audience.

**Actions:**
1. For each Innovation Candidate from Phase 1, create a **Value Bridge**:
   - **Technical Feature** → **User Benefit** → **Business Impact**
   - Example: "Schema-driven module definition" → "AI agents can auto-discover and call modules" → "Reduces integration cost by eliminating manual API documentation"
2. Rank innovations by audience relevance:
   - **Investor**: Market size impact, competitive moat, scalability.
   - **Tech Lead**: Integration cost, maintenance burden, risk mitigation.
   - **Dev Community**: DX improvement, learning curve, contribution ease.
   - **General**: Real-world use cases, problem clarity, accessibility of the solution.
3. Identify the **#1 Strategic Narrative** — the single sentence that captures why this project matters now.

### Phase 4: Report Generation (Multi-Dimensional Output)

Generate the final report using the structure below. Adapt emphasis based on `--audience`.

---

## Report Structure

### 1. Executive Summary

- **One-Line Verdict**: A single bold sentence (the Strategic Narrative from Phase 3).
- **What It Is**: 2-3 sentences defining the project.
- **Why It Matters Now**: Market timing, trend alignment, or problem urgency.
- **Target Audience**: Who benefits most and why.

### 2. Technical Architecture Deep Dive

- **Architecture Overview**: Include a **Mermaid diagram** showing the system's layered or component architecture.
  ```
  Use ```mermaid code blocks for all diagrams.
  Prefer flowchart TD or graph TD for architecture.
  Prefer sequenceDiagram for execution flows.
  ```
- **Core Pattern Analysis**: Name the 1-2 dominant patterns and explain why they were chosen.
- **Innovation Highlights**: Present 3-5 innovations using the Value Bridge format:
  > **[Feature Name]**
  > Technical: [what it does]
  > Benefit: [what it enables]
  > Impact: [why it matters to the audience]
- **Engineering Quality Assessment**: Rate and explain:
  - Security posture (ACL, validation, secrets).
  - Observability (tracing, metrics, logging).
  - Scalability design (horizontal/vertical, async, caching).
  - Developer Experience (docs, SDK quality, error messages).

### 3. Market Positioning & Competitive Landscape

- **Market Context**: Current state of the problem space with trend data from Phase 2.
- **Competitor Comparison Matrix**: A formatted table from Phase 2 data.
- **Differentiation Analysis**: For each competitor, explain:
  - Where the project wins.
  - Where the competitor wins.
  - Whether they are complementary or competitive.
- **Positioning Statement**: One paragraph on ideal market positioning strategy.

### 4. Ecosystem & Growth Potential

- **Integration Map**: Which ecosystems does it plug into? (frameworks, protocols, platforms)
- **Adoption Path**: How does a team go from "discovery" to "production deployment"?
- **Growth Vectors**: 2-3 realistic expansion directions with rationale.
- **Community Health**: Open-source activity indicators (if available).

### 5. Risk & Opportunity Assessment

- **Opportunities** (3-5 bullets):
  - Each with a concrete "If X, then Y" framing.
- **Risks** (3-5 bullets):
  - Each with severity (High/Medium/Low) and a suggested mitigation.
- **Strategic Recommendation**: A final 2-3 sentence conclusion tailored to the audience:
  - **Investor**: "Invest/Watch/Pass" with rationale.
  - **Tech Lead**: "Adopt/Evaluate/Hold" with integration advice.
  - **Dev Community**: "Contribute/Use/Follow" with quickstart path.
  - **General**: "Worth watching/Not yet relevant" with plain-language reasoning.

---

## Audience Adaptation Guide

For detailed guidance on tailoring the report to specific audiences, refer to:
@./audience-guide.md

---

## Output Format

- Write the report as a single Markdown document.
- Use `Write` tool to save the report to `reports/[project-name]-report.md`.
- All Mermaid diagrams MUST be in fenced code blocks with the `mermaid` language tag.
- Tables must be properly formatted GitHub-Flavored Markdown.
- Data sourced from web search must include inline citations: `[Source](URL)`.
- Estimated or unavailable data must be marked with `[estimated]` or `[data unavailable]`.

---

## Quality Checklist

- [ ] Does the Executive Summary give a clear invest/adopt/pass signal in under 30 seconds of reading?
- [ ] Does the Architecture section include at least one Mermaid diagram?
- [ ] Is the Competitor Matrix populated with real or clearly-marked estimated data?
- [ ] Does every Innovation Highlight follow the Value Bridge format (Technical → Benefit → Impact)?
- [ ] Are risks honest and specific (not generic "adoption might be slow")?
- [ ] Is the tone consistently matched to the target audience?
- [ ] Are all web-sourced claims cited with URLs?
- [ ] Does the Strategic Recommendation give a concrete, actionable verdict?

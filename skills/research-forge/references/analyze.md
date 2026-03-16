---
name: analyze
description: >
  Full due diligence analysis of a project across business, technical, and investment
  dimensions. Supports remote URLs, local directories, and local files.
---

# Research-Forge — Analyze

Deep due diligence analysis across all three dimensions defined in the Research-Forge framework.

## Command: `/research-forge:analyze`

### Usage:
`/research-forge:analyze <target> [--lang zh|en] [--focus business|technical|investment]`

- Target can be a URL, local directory path, or local file path.
- `--focus`: Optionally deep-dive into one specific dimension while keeping others at summary level.
- Default output language: Chinese (Simplified). Override with `--lang en`.

### Analysis Workflow:

#### Phase 1: Data Collection

**Remote targets:**
1. **WebFetch** the project's README, docs site, and landing page.
2. **WebSearch** for:
   - Recent news, blog posts, or announcements about the project.
   - Funding rounds, acquisitions, or partnership announcements.
   - Community discussions (HN, Reddit, X.com) for sentiment.
   - Competitor landscape — search for "[project] vs" and "[project] alternatives".
3. If a GitHub URL, extract repo metrics via the GitHub web interface.

**Local targets:**
1. **Read** README, manifest files, key config files.
2. **Glob** to map project structure: source, tests, docs, CI config.
3. **Read** representative source files (entry points, core modules, tests) to assess code quality.
4. **Grep** for patterns: TODO/FIXME density, error handling, logging, security patterns.
5. Check git history for activity patterns, contributor stats, branch hygiene.
6. If git remote exists, **WebSearch** for external context about the project.
7. **WebSearch** for competitor landscape regardless of target type.

#### Phase 2: Business & Market Analysis
Rate each sub-dimension (1-5):
- **Problem Acuteness** (1-5): Is the pain point real, urgent, and widespread?
- **Solution Fit** (1-5): Does the product actually solve the problem well?
- **Business Model Clarity** (1-5): Is there a clear, credible revenue path?
- **Market Timing** (1-5): Is the market ready? Too early? Too late?
- **Competitive Position** (1-5): How defensible is the position vs. alternatives?
- **Adoption Momentum** (1-5): Is usage growing? Community signals?

#### Phase 3: Technical & Architecture Analysis
Rate each sub-dimension (1-5):
- **Architecture Quality** (1-5): Modularity, design patterns, API quality.
- **Technical Moat** (1-5): Hard-to-replicate tech, algorithms, or data.
- **Engineering Culture** (1-5): Code quality, testing, CI/CD, PR review.
- **Scalability** (1-5): Can it handle growth without fundamental redesign?
- **Security Posture** (1-5): Dependency hygiene, vulnerability handling.
- **Documentation** (1-5): Quality, completeness, maintenance.

For local targets, the Technical dimension benefits from direct code reading — provide specific evidence from the codebase (file paths, code patterns, architecture observations).

#### Phase 4: Investment Thesis
- Construct the **Bull Case** (3-5 strongest arguments for success).
- Construct the **Bear Case** (3-5 most significant risks).
- Assess **Team** (if identifiable): background, track record, key-person risk.
- Identify **Comparable Outcomes**: similar projects and their trajectories.
- Produce **Verdict**: Strong Buy / Watch Closely / Hold / Pass.

#### Phase 5: Output
Generate a structured report with:
1. Executive Summary (3-5 sentences)
2. Scorecard table (all sub-dimensions with ratings)
3. Detailed analysis per dimension
4. Bull Case / Bear Case
5. Verdict with confidence level (High/Medium/Low)
6. Recommended actions / next steps

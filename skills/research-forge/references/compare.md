---
name: compare
description: >
  Side-by-side comparison of 2+ competing projects. Supports mixing remote URLs
  and local paths. Produces a comparison matrix with ranked recommendation.
---

# Research-Forge — Compare

Compare competing projects head-to-head across all analysis dimensions.

## Command: `/research-forge:compare`

### Usage:
`/research-forge:compare <target1> <target2> [target3...] [--lang zh|en]`

Targets can be any mix of URLs, local directory paths, or local file paths.

### Comparison Workflow:

#### 1. Parallel Scan
- Run a scan (equivalent to `/research-forge:scan`) on each target in parallel using sub-agents.
- Collect metadata, metrics, and first impressions for all projects.
- Adapt data collection strategy per target type (remote vs. local).

#### 2. Comparison Matrix
Build a side-by-side table covering:

| Dimension | Project A | Project B | Project C |
|---|---|---|---|
| **Target Type** | Remote/Local | Remote/Local | Remote/Local |
| **Stars / Files** | | | |
| **Contributors** | | | |
| **Last Commit** | | | |
| **License** | | | |
| **Language** | | | |
| *Business & Market* | | | |
| **Problem Acuteness** (1-5) | | | |
| **Solution Fit** (1-5) | | | |
| **Business Model Clarity** (1-5) | | | |
| **Market Timing** (1-5) | | | |
| **Competitive Position** (1-5) | | | |
| **Adoption Momentum** (1-5) | | | |
| *Technical & Architecture* | | | |
| **Architecture Quality** (1-5) | | | |
| **Technical Moat** (1-5) | | | |
| **Engineering Culture** (1-5) | | | |
| **Scalability** (1-5) | | | |
| **Security Posture** (1-5) | | | |
| **Documentation** (1-5) | | | |
| **Overall Score** | | | |

#### 3. Key Differentiators
For each project, identify:
- **Unique Strength**: What does this project do better than all others?
- **Critical Weakness**: What is the biggest gap vs. competitors?
- **Best For**: What use case or user profile is this project ideal for?

#### 4. Verdict
- Rank projects from most to least recommended.
- Provide context-dependent recommendation: "If you need X, choose A. If you need Y, choose B."

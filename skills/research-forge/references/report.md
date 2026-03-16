---
name: report
description: >
  Generate a polished, investor-ready due diligence report. Supports remote URLs,
  local directories, and local files as analysis targets.
---

# Research-Forge — Report

Generate a formal, polished due diligence report ready for sharing.

## Command: `/research-forge:report`

### Usage:
`/research-forge:report <target> [--lang zh|en] [--output path/to/output.md]`

- Target can be a URL, local directory path, or local file path.
- Default output: `./research-reports/[project-name]-due-diligence-[date].md`
- Default output language: Chinese (Simplified).

### Report Generation Workflow:

#### 1. Full Analysis
- Execute the complete `/research-forge:analyze` workflow internally.
- Adapt data collection to target type (remote vs. local).
- Gather all data, ratings, and assessments.

#### 2. Report Structure

Generate a formal document with the following sections:

```markdown
# [Project Name] — Due Diligence Report
> Analysis Date: [Date] | Analyst: Research-Forge | Verdict: [Verdict]
> Target: [URL or Local Path]

## Executive Summary
[3-5 sentence overview with key finding and recommendation]

## 1. Project Overview
- Name, URL/path, founding date, team size
- One-paragraph description
- Key metrics snapshot table

## 2. Business & Market Analysis
### 2.1 Problem & Solution
### 2.2 Business Model & Monetization
### 2.3 Market Size & Timing
### 2.4 Competitive Landscape
### 2.5 Adoption & Community Traction
**Business Score: X.X / 5.0**

## 3. Technical & Architecture Analysis
### 3.1 Tech Stack & Architecture
### 3.2 Technical Moat
### 3.3 Code & Engineering Quality
### 3.4 Scalability & Performance
### 3.5 Security & Reliability
**Technical Score: X.X / 5.0**

## 4. Investment Thesis
### 4.1 Bull Case
### 4.2 Bear Case / Key Risks
### 4.3 Team Assessment
### 4.4 Comparable Outcomes

## 5. Scorecard

| Dimension | Rating | Notes |
|---|---|---|
| Problem Acuteness | X/5 | ... |
| Solution Fit | X/5 | ... |
| Business Model Clarity | X/5 | ... |
| Market Timing | X/5 | ... |
| Competitive Position | X/5 | ... |
| Adoption Momentum | X/5 | ... |
| Architecture Quality | X/5 | ... |
| Technical Moat | X/5 | ... |
| Engineering Culture | X/5 | ... |
| Scalability | X/5 | ... |
| Security Posture | X/5 | ... |
| Documentation | X/5 | ... |
| **Overall** | **X.X / 5.0** | |

## 6. Verdict & Recommendation
[Final verdict with confidence level and recommended next steps]

## Appendix
- Data sources and references
- Methodology notes
- Disclaimer
```

#### 3. Save Report
- Write the report to the specified output path (or default location).
- Inform the user of the file location.

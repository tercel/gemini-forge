---
name: scan
description: >
  Quick scan of a project — gather metadata, key metrics, and first impressions.
  Supports remote URLs, local directories, and local files.
---

# Research-Forge — Scan

Quick reconnaissance scan of a project to gather key signals before a full analysis.

## Command: `/research-forge:scan`

### Usage:
`/research-forge:scan <target> [--lang zh|en]`

Target can be a URL, local directory path, or local file path.

### Scan Logic:

#### 1. Detect Target Type & Fetch Project Metadata

**Remote URL:**
- Use WebFetch to retrieve the project's README, GitHub API data, or landing page.
- Extract: name, description, language, license, creation date, last commit date.

**Local Directory:**
- Read README (README.md, README.rst, README.txt — whichever exists).
- Read package manifest (package.json, Cargo.toml, go.mod, pyproject.toml, pom.xml, build.gradle, etc.).
- Glob project structure to understand scope: source files, test files, config files, docs.
- Check git history: `git log --oneline -20`, `git remote -v`, `git shortlog -sn`.
- Extract: name (from manifest or directory name), description, language, license, creation date (first commit), last commit date.

**Local File:**
- Read the file. If it's a README or spec doc, extract project info directly.
- If it's source code, identify the parent project directory and treat as Local Directory.

#### 2. Quantitative Signals

**Remote projects:**
- Popularity: Stars, forks, watchers count and growth trajectory.
- Activity: Commit frequency (last 30/90/365 days), open vs. closed issues ratio, PR merge velocity.
- Community: Number of contributors, contributor concentration (bus factor), Discord/Slack links.
- Dependencies: Key dependencies, number of dependents (who uses this?).

**Local projects:**
- Structure: Total file count, source file count, test file count, lines of code estimate.
- Activity: Commit frequency from git log, number of contributors, branch count.
- Dependencies: Key dependencies from manifest, dependency count, outdated signals.
- Quality signals: Presence of CI config, linter config, test framework, documentation.

#### 3. Qualitative First Impressions
- README quality: Is it clear, professional, well-structured?
- Documentation: Does it exist? Is it maintained?
- Positioning: How does the project describe itself? What problem does it claim to solve?
- Code organization: Is the structure clean and conventional for the language/framework?

#### 4. Output Format
Produce a concise snapshot card:

```
Project Snapshot: [Name]
Target: [URL or Path]
Scan Date: [Date]

Quick Stats:
  [Remote] Stars: X | Forks: X | Contributors: X
  [Local]  Files: X | Source: X | Tests: X
  Last Commit: [Date] | Open Issues: X
  Language: [Lang] | License: [License]

First Impressions:
  [2-3 sentence summary]

Key Signals:
  [Bullet list of notable positive/negative signals]

Recommended Next Step:
  [ ] Full analysis warranted → /research-forge:analyze <target>
  [ ] Compare with competitors → /research-forge:compare <target> <competitor>
  [ ] Not worth pursuing → [reason]
```

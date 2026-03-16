---
description: "Project due diligence — auto-chain full analysis pipeline (default: current directory)."
argument-hint: "[target] [--lang zh|en] [--output path] [--focus dimension]"
allowed-tools: [Read, Glob, Grep, Write, Bash, WebFetch, WebSearch, Agent, AskUserQuestion]
---

The user invoked `/research-forge:run` with: $ARGUMENTS

## Argument Parsing

1. **Extract `--lang`**: If `--lang en` or `--lang zh` is present, use that language for output. Default: `zh` (Chinese Simplified).
2. **Extract `--output`**: If `--output <path>` is present, use that path for the final report file.
3. **Extract `--focus`**: If `--focus <dimension>` is present, note it for Phase 2.
4. **Determine target**: Everything remaining (not a flag) is the target. **If no target is provided, default to the current working directory (`.`).**

## Target Types

A target can be:
- **Remote URL**: `https://github.com/...`, `https://example.com`, etc.
- **Local directory**: `/path/to/project`, `./my-project`, `~/Workspace/foo`, or `.` (current directory, the default)
- **Local file**: `/path/to/file.py`, `./README.md`, `~/project/package.json`

### Target Detection & Data Collection Strategy

Determine the target type and adapt data collection accordingly:

#### Type A: Remote URL
- **WebFetch** the project page, README, docs.
- **WebSearch** for news, funding, competitors, community sentiment.
- Extract GitHub metrics if it's a GitHub URL.

#### Type B: Local Directory
- **Read** the project's README, package.json / Cargo.toml / go.mod / pyproject.toml / pom.xml (whichever exists).
- **Glob** to understand project structure: `**/*.{ts,js,py,go,rs,java}`, config files, test files.
- **Grep** for architecture patterns, TODOs, dependency declarations.
- **Read** key source files to assess code quality, architecture, and patterns.
- If the project has a git remote, extract the remote URL and **WebSearch** for external context (community, competitors, funding).
- If no git remote, analyze purely from local artifacts.

#### Type C: Local File
- **Read** the file to understand the project context.
- If it's a README or spec doc, extract project description and use it as the research basis.
- If it's source code, identify the parent project directory and escalate to Type B analysis.

---

Execute the **Full Auto-Chain Pipeline** — run ALL phases sequentially, passing results from each phase to the next. Do NOT stop between phases. Do NOT ask the user for confirmation between phases. Complete the entire pipeline in one go.

### Auto-Chain Pipeline:

#### Phase 1: Quick Scan
Follow the `research-forge:scan` skill exactly. Collect:
- Project metadata (name, language, license, dates)
- For remote targets: quantitative signals (stars, forks, contributors, activity)
- For local targets: project structure, dependencies, test presence, git history stats
- README quality and first impressions
- Output the Snapshot Card

#### Phase 2: Deep Analysis
Follow the `research-forge:analyze` skill exactly. Using Phase 1 data as foundation:
- Business & Market Analysis (6 sub-dimensions, each rated 1-5)
- Technical & Architecture Analysis (6 sub-dimensions, each rated 1-5)
- Investment Thesis (bull case, bear case, team, comparables)
- Output the structured analysis with scorecard

#### Phase 3: Formal Report
Follow the `research-forge:report` skill exactly. Compile Phase 1 + Phase 2 into:
- A polished, investor-ready due diligence report
- Save to `./research-reports/[project-name]-due-diligence-[date].md` (or `--output` path if specified)
- Inform the user of the saved file path

### Pipeline Rules:
1. **Data handoff**: Each phase builds on data from previous phases. Maintain a running context of all collected data (metadata, metrics, ratings, assessments) across phases. Do NOT re-fetch, re-read, or re-analyze data already collected in earlier phases.
2. Run the pipeline end-to-end without stopping for user input.
3. Use sub-agents (Agent tool) to parallelize independent research tasks within each phase.
4. **Output language**: Use the language specified by `--lang` (default: `zh`, Chinese Simplified). When `--lang en` is specified, output in English. Use English for technical terms, product names, and metrics regardless of language setting.
5. For local projects, supplement with WebSearch to gather external context (competitors, market landscape) when possible.
6. **`--focus` parameter**: If `--focus` is specified, it applies ONLY to Phase 2 (Analyze) — the focused dimension gets a deep-dive while the other two dimensions receive summary-level analysis. Phase 1 (Scan) and Phase 3 (Report) are unaffected and run in full.

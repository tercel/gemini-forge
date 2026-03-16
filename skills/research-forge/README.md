# Research Forge

The "Deep Research" skill for projects: Codebase, Architecture, and Strategic analysis.

Perform deep analysis on technical projects — including open-source repos, commercial products, and internal systems — across technical, business, and strategic dimensions, then generate structured, actionable reports.

## Quick Start

```bash
# Full auto-chain pipeline (scan → analyze → report)
/research-forge:run                                    # Analyze current directory
/research-forge:run https://github.com/example/project # Analyze remote project
/research-forge:run ./my-local-project                 # Analyze local directory
/research-forge:run --lang en                          # Output in English

# Individual commands
/research-forge:scan <target>              # Quick scan
/research-forge:analyze <target>           # Deep 3-dimension analysis
/research-forge:compare <target1> <target2> # Side-by-side comparison
/research-forge:report <target>            # Formal report generation
```

## Target Types

- **Remote URL** — `https://github.com/...`, any web address
- **Local directory** — `/path/to/project`, `./my-project`
- **Local file** — `./README.md`, `~/project/package.json`

## Analysis Framework

### Dimension 1: Business & Market (6 sub-dimensions)
Problem Acuteness, Solution Fit, Business Model Clarity, Market Timing, Competitive Position, Adoption Momentum

### Dimension 2: Technical & Architecture (6 sub-dimensions)
Architecture Quality, Technical Moat, Engineering Culture, Scalability, Security Posture, Documentation

### Dimension 3: Investment Thesis
Bull Case, Bear Case, Team Assessment, Comparable Outcomes, Verdict

## Rating System

Each sub-dimension scored 1-5. Verdict: Strong Buy / Watch Closely / Hold / Pass.

## Options

| Flag | Description |
|---|---|
| `--lang zh\|en` | Output language (default: zh) |
| `--focus business\|technical\|investment` | Deep-dive one dimension |
| `--output path` | Custom report output path |

## Output

Reports saved to `./research-reports/[project-name]-due-diligence-[date].md` by default.

### Manual Installation
If you are installing this skill manually (via `/install:skill` or by moving it to `~/.gemini/skills/`), it is **strongly recommended** to rename the directory to its original name (without the `-gemini` suffix) to ensure correct path authorization and command mapping in the Gemini CLI:

---
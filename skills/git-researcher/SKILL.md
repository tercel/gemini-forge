---
name: git-researcher
description: High-performance GitHub research orchestrator. Features search result caching, multi-dimensional analysis, and sub-agent delegation to minimize token usage and prevent context contamination.
---

# Git Researcher

## User Guide (How to use)
You can trigger this skill by asking me to research GitHub projects. Here are some examples:

- **Basic Search**: "Research Python LLM agent projects with more than 100 stars."
- **Complex Search**: "Search for topic:ai topic:rag stars:50..500 language:python. Analyze the top 2 and give me a Chinese report (--lang zh)."
- **Specific Project**: "Analyze the repository 'langchain-ai/langchain' from technical, user, and investor perspectives."
- **Batch Analysis**: "From my last search results, analyze project #3 and #5."

### Parameters you can specify:
- **Keywords/Topics**: `topic:ai`, `llm`, `agent`, etc.
- **Metrics**: `stars:>100`, `forks:10..50`.
- **Language**: `--lang zh` (Chinese report), `--lang en` (English report, default).
- **Limit**: "Show me the top 10 results."

---

## Architectural Principles
- **Orchestration**: The main agent acts as an orchestrator, delegating heavy lifting to sub-agents.
- **Persistence**: Search results are cached locally in `search_results.json` to avoid redundant API calls.
- **Isolation**: Each repository analysis is handled by a fresh sub-agent (e.g., `generalist` or `codebase_investigator`) within its specific directory.

## Workflow

### 1. Search & Cache Phase
- Use `gh search repos` with user criteria.
- **Action**: Save the raw JSON output to `search_results.json` in the current directory.
- **Example**: `gh search repos "..." --json ... > search_results.json`
- **Logic**: If the user asks for more projects from a previous query, check `search_results.json` first before re-searching.

### 2. Selection & Delegation
- Read `search_results.json` and present a numbered list to the user.
- For each selected project, **delegate** the process to a sub-agent.

### 3. Execution Phase (Sub-Agent Delegation)
For each project, spawn a **sub-agent** (using the `generalist` tool) with the following specific mission:
1. **Clone**: Clone the repository into a unique directory.
2. **Investigate**: Use `codebase_investigator` inside that directory to understand the Technical, User, and Investor perspectives.
3. **Draft**: Create the `git-research.md` report based on `references/report_guide.md`.
4. **Report Back**: Return only a concise summary of the analysis to the Orchestrator.

### 4. Reporting & Synthesis
- The Orchestrator summarizes the status of all analyzed projects.
- Ensures the workspace remains clean by isolating project-specific artifacts.

## Guidelines
- **Token Efficiency**: Never read the entire codebase into the main context. Always use `codebase_investigator` via a sub-agent.
- **Anti-Redundancy**: Verify `search_results.json` and existing directories before every major action.
- **Multi-lingual**: If `--lang zh` is used, ensure the sub-agent generates the report in Chinese.

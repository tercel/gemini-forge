# Research-Forge — Target Types & Data Collection

All Research-Forge commands accept three types of targets. Data collection and analysis strategies adapt automatically to the target type.

## 1. Remote URL
- **Examples**: `https://github.com/facebook/react`, `https://openai.com`, `https://blog.example.com`
- **Data Collection**:
  - **WebFetch**: Retrieve README, documentation pages, landing pages, and API-exposed metadata.
  - **WebSearch**: Gather external context — news, funding rounds, community sentiment (Reddit, HN, X), and competitor landscape.
  - **GitHub Extraction**: If the URL is a GitHub repository, extract quantitative metrics (stars, forks, contributors, issue/PR activity).

## 2. Local Directory
- **Examples**: `/Users/me/WorkSpace/my-project`, `./current-repo`, `.` (current directory)
- **Data Collection**:
  - **Read**: Project manifest (e.g., `package.json`, `Cargo.toml`, `go.mod`, `pyproject.toml`, `pom.xml`, `README.md`).
  - **Glob**: Map the codebase structure (source code, tests, documentation, configuration files).
  - **Grep**: Identify architecture patterns, TODO/FIXME density, dependency declarations, and security configurations.
  - **Read (Surgical)**: Analyze representative source files to assess code quality and architectural maturity.
  - **Git Analysis**: Use `run_shell_command` to extract commit history, contributor stats, and activity patterns.
  - **WebSearch**: If a git remote exists, use it to gather external context (market positioning, competitors).

## 3. Local File
- **Examples**: `/path/to/spec.pdf`, `./README.md`, `~/project/main.py`
- **Data Collection**:
  - **Read**: Directly extract information from the file content.
  - **Escalation**: 
    - If the file is a project README or specification, use it as the foundational context for the research.
    - If the file is a source code file, identify the parent project directory and escalate to **Local Directory** analysis.

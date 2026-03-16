# Gemini Forge (GSF)

`gemini-forge` is a high-performance, cross-platform CLI tool designed to streamline the lifecycle of **Gemini CLI Skills**. It automates the detection, packaging, and deployment of skills while ensuring strict compatibility with the official Gemini CLI specification.

## Core Features

- 🧠 **Structural Signature Scanning**: Automatically detects valid Gemini skills by analyzing directory structures, `.toml` command definitions, and core sub-agent references.
- 📦 **Automated Packaging**: Builds `.skill` files from single or multi-skill project structures.
- 🚀 **One-Click Deployment**: Installs skills and syncs custom commands to the local or workspace `.gemini` directory in a single step.
- 🐧 **Cross-Platform Robustness**: Fully compatible with both macOS (BSD) and Linux (GNU).
- 🛠️ **Smart Syncing**: Automatically manages custom `.toml` commands and ensures they are correctly registered with the Gemini CLI.

## Installation

### Global Installation (Recommended)

```bash
npm install -g gemini-forge
# or
pnpm add -g gemini-forge
```

### Local Development Usage

```bash
git clone https://github.com/tercel/gemini-forge.git
cd gemini-forge
npm link
```

## Usage

### 1. Verify a Skill
Check if a directory is a valid Gemini Skill:
```bash
gemini-forge check ./my-skill-dir
```

### 2. Build and Package
Generate `.skill` files in the `dist/` directory:
```bash
gemini-forge package
```

### 3. Deploy Everything
Build, install, and sync commands to the user's scope:
```bash
gemini-forge deploy user
```

### 4. Upgrading & Maintenance
When updating an existing skill, a simple `deploy` is usually sufficient to overwrite existing files. However, **if you have deleted files** (such as `.toml` commands or sub-agent directories), it is recommended to uninstall first to ensure a clean state:

```bash
# Recommended sequence for major changes or file deletions:
gemini-forge uninstall . user
gemini-forge deploy . user
```

> **Pro Tip**: Use `uninstall` before `deploy` to prune "zombie" command definitions from the `~/.gemini` directory that no longer exist in your source code.

### 5. Advanced Installation
Install with specific scopes:
```bash
gemini-forge install user      # Install to global user scope
gemini-forge install workspace # Install to local project scope
```

## How It Identifies a Gemini Skill

`gemini-forge` uses **Structural Signature Scanning** to differentiate Gemini skills from other platforms (like Claude Code) or generic Markdown files. A directory is recognized as a Gemini Skill if it contains:

1. **TOML Commands**: A `commands/` directory containing `.toml` files.
2. **Standard Metadata**: A `SKILL.md` file with mandatory `name` and `description` YAML frontmatter.
3. **Core Sub-Agents**: References to Gemini sub-agents (e.g., `gsd-planner`, `codebase_investigator`) in `SKILL.md`.
4. **Nested Skills**: A `skills/` directory containing sub-directories with their own `SKILL.md`.

## Project Structure Standards

For the best experience, follow this standard layout for your Gemini projects:

```text
my-project/
├── commands/           # Custom .toml commands
├── skills/             # (Optional) Sub-agents/Skills
│   └── my-sub-agent/
│       └── SKILL.md
├── SKILL.md            # Main Skill definition
└── package.json        # Project metadata
```

## License

MIT © [tercel](https://github.com/tercel)

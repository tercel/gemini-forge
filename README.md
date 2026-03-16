# Gemini Forge (GSF)

**Gemini Forge (GSF)** is a high-performance ecosystem of specialized skills and management tools for the **Gemini CLI**. It provides a suite of "Forge" orchestrators designed for professional software engineering, architectural specification, ecosystem management, and technical evangelism.

## 🛠️ The Forge Suite

The project consists of several core "Forge" skills, each optimized for a specific part of the development and business lifecycle:

| Skill | Focus Area | Key Capabilities |
| :--- | :--- | :--- |
| **[code-forge](./skills/code-forge/SKILL.md)** | **SDLC Orchestrator** | TDD-driven implementation, 14-dimension code review, systematic debugging, and automated planning. |
| **[spec-forge](./skills/spec-forge/SKILL.md)** | **Product & Tech Design** | Idea validation, project decomposition, technical design (Google/Uber style), and feature specification. |
| **[apcore-skills](./skills/apcore-skills/SKILL.md)** | **Ecosystem Sync** | Cross-language SDK management, API consistency auditing, and coordinated multi-repo releases. |
| **[git-researcher](./skills/git-researcher/SKILL.md)** | **GitHub Intel** | High-performance repository research, competitive analysis, and trend discovery. |
| **[hype-forge](./skills/hype-forge/SKILL.md)** | **Growth & Evangelism** | Transforming code into high-impact content (articles, X threads) and technical audits. |
| **[research-forge](./skills/research-forge/SKILL.md)** | **Technical Due Diligence** | Deep project intelligence, architectural analysis, and investor-ready reports. |
| **[gskills-forge](./skills/gskills-forge/SKILL.md)** | **Skill Development** | Professional scaffolding and optimization for building new Gemini CLI skills. |

---

## 🚀 Management Tool: `gemini-forge` CLI

In addition to the skills themselves, this repository includes the **`gemini-forge` CLI**, a utility designed to streamline the lifecycle of Gemini CLI Skills.

### Key Features
- 🧠 **Structural Signature Scanning**: Automatically detects valid Gemini skills.
- 📦 **Automated Packaging**: Builds `.skill` files from monorepo or single-skill structures.
- 🚀 **One-Click Deployment**: Installs and syncs commands to your `.gemini` directory.

### Quick Start

1. **Install the CLI Tool**:
   ```bash
   npm install -g .
   ```

2. **Deploy the Entire Forge Suite**:
   ```bash
   gemini-forge deploy . user
   ```

3. **Verify Installation**:
   ```bash
   gemini help
   # You should see commands like /code-forge:plan, /spec-forge:prd, etc.
   ```

Detailed CLI documentation can be found in **[CLI.md](./CLI.md)**.

---

## 📂 Project Structure

- `bin/`: Source code for the `gemini-forge` CLI management tool.
- `skills/`: The collection of high-performance Gemini skills.
  - Each skill directory (e.g., `code-forge/`) contains its own `SKILL.md` and specialized resources.

---

## 📄 License

MIT © [tercel](https://github.com/tercel)

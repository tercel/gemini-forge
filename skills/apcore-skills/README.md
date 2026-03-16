# apcore-skills

> Part of [aipartnerup/apcore-skills](https://github.com/aipartnerup/apcore-skills)

Apcore ecosystem management skill for Claude Code. Handles cross-language SDK synchronization, framework integration scaffolding, multi-repo audits, coordinated releases, and documentation alignment.

## Commands

| Command | Description |
|---------|-------------|
| `/apcore-skills` | Ecosystem dashboard — versions, coverage, health |
| `/apcore-skills:sync` | Cross-language API + documentation consistency check & fix |
| `/apcore-skills:sdk` | Bootstrap a new language SDK from reference |
| `/apcore-skills:integration` | Bootstrap a new framework integration |
| `/apcore-skills:audit` | Deep cross-repo consistency audit |
| `/apcore-skills:release` | Coordinated multi-repo release pipeline |

## Ecosystem

The apcore ecosystem consists of:

**Core Protocol:**
- `apcore` — Protocol specification and documentation

**Core SDKs (must stay in sync):**
- `apcore-python` — Python SDK
- `apcore-typescript` — TypeScript SDK (npm: `apcore-js`)

**MCP Bridges (must stay in sync):**
- `apcore-mcp-python` — Python MCP server
- `apcore-mcp-typescript` — TypeScript MCP server (npm: `apcore-mcp`)

**Framework Integrations:**
- `django-apcore` — Django integration
- `flask-apcore` — Flask integration
- `nestjs-apcore` — NestJS integration
- `tiptap-apcore` — TipTap editor integration

**Shared Libraries:**
- `apcore-discovery-python` — Shared discovery utilities

## Prerequisites

1. All apcore ecosystem repos should be in a common parent directory (e.g., `~/WorkSpace/aipartnerup/`)
2. The `apcore/` protocol repo with `PROTOCOL_SPEC.md` is required for `sync` and `sdk` commands
3. No config file needed — ecosystem discovery is automatic based on directory naming conventions
4. Optional: `.apcore-skills.json` in the ecosystem root to customize discovery and version groups
5. **[code-forge](https://github.com/tercel/code-forge)** skill required for `sdk` and `integration` commands (generates `.code-forge.json` and uses `code-forge:port`, `code-forge:plan`, `code-forge:impl`)

## Integration with Other Skills

- **spec-forge** — Generate specifications for new features before implementing
- **code-forge** — Plan and implement features within individual repos
- **code-forge:port** — Port features from one language SDK to another
- **apcore-skills** — Ecosystem-level operations that span multiple repos

---
## Installation Note

This repository uses the `-gemini` suffix in its directory name to distinguish it from Claude-compatible versions in the source workspace.

### Recommended Deployment (via gemini-forge)
If you use [gemini-forge](https://github.com/tercel/gemini-forge), you can deploy directly:
```bash
gemini-forge deploy . user
```

### Manual Installation
If you are installing this skill manually (via `/install:skill` or by moving it to `~/.gemini/skills/`), it is **strongly recommended** to rename the directory to its original name (without the `-gemini` suffix) to ensure correct path authorization and command mapping in the Gemini CLI:

---

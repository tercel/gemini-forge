# Gemini Skills Forge

Gemini CLI Skill Architect — specialized in scaffolding, converting (Claude to Gemini), and refactoring/optimizing skills.

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


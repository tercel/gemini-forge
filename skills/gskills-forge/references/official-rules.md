# Official Gemini CLI Skill Rules

Source: [Gemini CLI Skills Documentation](https://geminicli.com/docs/cli/skills)

## 1. Core Definition
- **Progressive Disclosure**: Only the name and description are loaded initially. Full instructions are fetched only upon activation (`activate_skill`).
- **Self-Contained**: A skill is a directory containing a `SKILL.md` and any necessary assets (scripts, templates, data).
- **On-Demand**: Skills are activated by the agent when a task matches the skill's description.

## 2. Directory Structure & Discovery
Gemini CLI searches for skills in the following locations (highest to lowest precedence):

| Tier | Paths | Note |
|------|-------|------|
| **Workspace** | `.gemini/skills/` or `.agents/skills/` | Committed to Git, specific to the project. |
| **User** | `~/.gemini/skills/` or `~/.agents/skills/` | Available across all projects for the user. |
| **Extension** | Bundled in CLI extensions | Installed via extensions. |

**Precedence Note:** Within any tier, `.agents/skills/` always takes precedence over `.gemini/skills/`.

## 3. Required File: `SKILL.md`
Every skill MUST have a `SKILL.md` file with a YAML frontmatter:
- **name**: Short identifier for the skill.
- **description**: Clear, concise explanation of the skill's expertise (used for discovery).
- **instructions**: High-level procedural framework or core guidance.

## 4. Standard Section for Commands
Commands are discovered and displayed contextually by the agent.
- **Section Header**: Use `## Commands` to list available sub-commands.
- **Command Format**: Use `### /command-name` for each command.
- **Content**: Include a **Description** and **Instructions** (procedural steps) for each command.
- **Dynamic Discovery**: The agent learns these commands once `activate_skill` is called.

## 5. Activation & Lifecycle
- **Tool-Based**: The `activate_skill` tool is called by the agent.
- **User Approval**: The user must approve the activation after seeing the skill's name and purpose.
- **Context Injection**: Upon approval, the full content of `SKILL.md` and the directory structure are injected into the session history.
- **Persistence**: Once activated, the skill remains active for the duration of the session.

## 5. Best Practices
- **Procedural Frameworks**: Use skills to define consistent, multi-step workflows.
- **Resource Bundling**: Include all necessary scripts or templates within the skill directory.
- **Clear Descriptions**: Ensure the name and description clearly define the specific expertise provided for accurate discovery.
- **Authoritative Guidance**: Instructions should be written as authoritative guidance that the agent prioritizes over general defaults.

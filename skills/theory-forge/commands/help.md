---
description: "Display theory-forge command reference and usage examples."
argument-hint: "[command-name]"
---

You are the theory-forge help display. The user invoked: `/theory-forge help $ARGUMENTS`

## Workflow

1. Read `../templates/dashboard-output.md` (the source of truth for help content).

2. Parse `$ARGUMENTS`:
   - **Empty** → Render the "Help view" section from `../templates/dashboard-output.md`.
   - **Known command name** (e.g., `cite-audit`, `consistency`) → Render the "Detailed help" template:
     - Read `./{command}.md` for: description, argument-hint, and Usage Examples.
     - Read `../references/{command}-workflow.md` for: Anti-patterns and severity table.
     - Fill in the "Detailed help" template from `../templates/dashboard-output.md`.
   - **Unknown token** → Render the "Unknown command" template from `../templates/dashboard-output.md`.

3. Output the rendered help text. Done.

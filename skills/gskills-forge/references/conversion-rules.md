# Conversion Rules: Claude to Gemini

## 1. Metadata Mapping
Claude uses `plugin.json`. Gemini uses the YAML frontmatter in `SKILL.md`.
- `display_name` -> `name`
- `description` -> `description`

## 2. Import Syntax
- **Claude**: `@shared/rules.md` or `@../shared/rules.md`
- **Gemini**: `@./references/shared/rules.md` (Must be relative to `SKILL.md`)

## 3. Tool Mapping Table
| Claude Tool | Gemini Tool | Notes |
|-------------|-------------|-------|
| `ReadFile`  | `read_file` | |
| `WriteFile` | `write_file`| |
| `Edit`      | `replace`   | Gemini `replace` requires `old_string` |
| `Grep`      | `grep_search`| |
| `Task`      | `generalist`| Use `generalist` for sub-task delegation |

## 4. Hierarchy
- **Claude**: Prefers many small files in `skills/`.
- **Gemini**: Prefers a master `SKILL.md` with instructions + `@` imports for rules.

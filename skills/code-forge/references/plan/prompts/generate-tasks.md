**Sub-agent prompt must include:**
- The plan file path: `{output_dir}/{feature_name}/plan.md` (sub-agent reads it from disk)
- The task list summary returned by Step 7 (paste it into the prompt)
- The tasks directory path: `{output_dir}/{feature_name}/tasks/`
- All the principles and format requirements below
- If `reference_summaries` is non-empty, include a `## Reference Context` section:
  ```
  ## Reference Context

  The following project documents provide architectural context.
  Ensure task steps follow project conventions and integrate with existing components.

  {reference_summaries — all summaries concatenated, separated by blank lines}
  ```

**Sub-agent must create `tasks/{name}.md`** for each task, following these principles:
- TDD first: test → implement → verify
- Concrete steps: include code examples and commands
- Traceable: annotate dependencies (depends on / required by)

**Each task file must include:**
- **Goal** — what this task accomplishes
- **Files Involved** — files to create/modify
- **Steps** — numbered, with code examples where helpful
- **Acceptance Criteria** — checklist
- **Dependencies** — depends on / required by
- **Estimated Time**

**Naming (critical):** Use descriptive filenames: `setup.md`, `models.md`, `api.md` — **NO numeric prefixes** (`01-setup.md`, `02-models.md` are WRONG). Execution order is defined in `overview.md` Task Execution Order table and `state.json` `execution_order` array, never in filenames.

**Sub-agent must return** (as response text) the list of generated files:

    GENERATED_FILES:
    - tasks/<task_id>.md: <task_title>
    - tasks/<task_id>.md: <task_title>
    ...

**Sub-agent prompt must include:**
- The input document file path (sub-agent re-reads the original for full context)
- The structured summary from Step 4 (paste it into the prompt)
- User answers from Step 5 (tech stack choice, testing strategy, task granularity)
- The output file path: `{output_dir}/{feature_name}/plan.md`
- Instructions to write the plan file AND return a concise task list summary
- If `reference_summaries` is non-empty, include a `## Reference Context` section:
  ```
  ## Reference Context

  The following project documents provide architectural context.
  Ensure the implementation plan is consistent with existing architecture and conventions.

  {reference_summaries — all summaries concatenated, separated by blank lines}
  ```

**Sub-agent must write `plan.md`** with these required sections:
- **Goal** — one sentence describing what to implement
- **Architecture Design** — component structure, data flow, technical choices with rationale
- **Task Breakdown** — dependency graph (mermaid `graph TD`) + task list with estimated time and dependencies
- **Risks and Considerations** — identified technical challenges
- **Acceptance Criteria** — checklist (tests pass, code review, docs, performance)
- **References** — related technical docs and examples

**Task ID naming rules (critical):** Task IDs must be descriptive names **without numeric prefixes**. Use `setup`, `models`, `api` — **NOT** `01-setup`, `02-models`, `03-api`. Execution order is controlled by `overview.md` and `state.json`, not by filename ordering or numeric prefixes.

**Sub-agent must return** (as response text, separate from the file it writes) a concise task list summary:

    TASK_COUNT: <number>
    TASKS:
    - <task_id>: <task_title> [depends on: <deps or "none">] (~<estimated_time>)
    - <task_id>: <task_title> [depends on: <deps or "none">] (~<estimated_time>)
    ...
    EXECUTION_ORDER: <task_id_1>, <task_id_2>, ...

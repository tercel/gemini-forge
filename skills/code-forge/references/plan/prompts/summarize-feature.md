**Sub-agent prompt must include:**
- The input document file path (so the sub-agent reads it, NOT the main context)
- Instruction to return ONLY a structured summary
- If `reference_summaries` is non-empty (from Step 1), include a `## Reference Context` section:
  ```
  ## Reference Context

  The following project documents provide architectural context.
  Use these to align your analysis with existing project decisions and patterns.

  {reference_summaries — all summaries concatenated, separated by blank lines}
  ```

**Sub-agent must analyze and return:**
1. **Feature Name** — extracted from the source **filename** (kebab-case, without `.md` extension). Always use the filename, never the document title. Example: source file `security.md` → feature name `security`, even if the document title is "Security Manager".
2. **Technical Requirements** — tech stack, frameworks, languages mentioned
3. **Functional Scope** — 2-3 sentence summary of what needs to be implemented
4. **Constraints** — performance, security, compatibility requirements
5. **Testing Requirements** — testing strategy mentioned, or "not specified"
6. **Key Components** — major modules/components to build (bulleted list)
7. **Estimated Complexity** — low/medium/high with brief rationale

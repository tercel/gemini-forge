**Each sub-agent prompt:**
- The file path (sub-agent reads it from disk)
- Instruction to return ONLY a structured summary in this exact format:

```
DOC_PATH: {file_path}
DOC_TYPE: <architecture | api | requirements | conventions | data-model | other>
SUMMARY: <2-3 sentence summary of what this document describes>
KEY_DECISIONS: <bulleted list of important technical decisions, constraints, or patterns>
RELEVANCE_TAGS: <comma-separated keywords for matching against feature docs>
```

**Target summary size:** ~300-500 bytes per doc.

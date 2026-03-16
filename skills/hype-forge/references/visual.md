---
description: "Suggest where to insert GIFs, images, diagrams, and code screenshots to improve readability and engagement in technical drafts. Provides placement recommendations and descriptive captions."
---

# Hype-Forge — Visual

Enhance technical drafts with strategic visual element suggestions.

## Usage

`/hype-forge:visual [path to draft]`

## Workflow

1. **Identify**: Scan the draft for long text blocks, complex concepts, or architecture descriptions.
2. **Suggest**: Recommend the right visual type for each section:
   - GIFs for interactions (e.g., "Show the CLI in action").
   - Diagrams for architecture (e.g., "Use a Mermaid chart here").
   - Code screenshots for social media sharing.
   - Before/after comparisons for performance improvements.
3. **Captioning**: Provide friendly, descriptive captions for each suggestion.
4. **Placement**: Indicate where each visual should go using placeholder format: `![GIF: Description](URL)`.

## Visual Type Guidelines

| Content Type | Recommended Visual | Platform Fit |
|---|---|---|
| CLI / terminal interaction | GIF (15-30s) | Dev.to, X Thread |
| System architecture | Mermaid diagram or draw.io | Hashnode, HN |
| Code comparison | Side-by-side screenshot | X Article, Dev.to |
| Performance data | Chart / graph | HN, Hashnode |
| UI component | Screenshot or short GIF | Reddit, X Thread |

## Quality Checklist
- [ ] Are the visual suggestions relevant and helpful?
- [ ] Is there a good balance between text and visuals?
- [ ] Are captions descriptive enough to guide content creation?
- [ ] Do visual types match the target platform?

---
description: ""Show all hype-forge commands and usage guide""
allowed-tools: [Read, Glob, Grep]
---

The user invoked `/hype-forge:hype-forge`. This is the main entry point.

**Do not route or parse subcommands.** Instead, display the available commands:

```
Hype Forge — Available Commands

Deep Analysis:
  /hype-forge:report                        Deep technical analysis report
  /hype-forge:report --audience investor    Report tailored for investors
  /hype-forge:report --audience tech-lead   Report tailored for tech leads

Content Strategy:
  /hype-forge:strategy                      Analyze project and plan a content series
  /hype-forge:strategy --goal "launch week" Strategy with a specific goal

Content Creation:
  /hype-forge:draft --platform devto        Generate a Dev.to draft
  /hype-forge:draft --platform hashnode     Generate a Hashnode draft
  /hype-forge:draft --platform hn           Generate a Hacker News post
  /hype-forge:draft --platform reddit       Generate a Reddit post
  /hype-forge:draft --platform x-article    Generate an X.com article
  /hype-forge:draft --platform x-thread     Generate an X.com thread

Content Enhancement:
  /hype-forge:code [path or snippet]        Transform code into narrative explanation
  /hype-forge:visual [path to draft]        Suggest GIFs, images, and diagrams

Quality & Review:
  /hype-forge:roast [path to draft]         Critique draft as community readers
```

If the user provided arguments ($ARGUMENTS), suggest the correct command. For example:
- `report` → suggest `/hype-forge:report`
- `report --audience investor` → suggest `/hype-forge:report --audience investor`
- `strategy` → suggest `/hype-forge:strategy`
- `strategy --goal "launch"` → suggest `/hype-forge:strategy --goal "launch"`
- `draft --platform devto` → suggest `/hype-forge:draft --platform devto`
- `code src/main.ts` → suggest `/hype-forge:code src/main.ts`
- `roast drafts/post.md` → suggest `/hype-forge:roast drafts/post.md`
- `visual drafts/post.md` → suggest `/hype-forge:visual drafts/post.md`
- (no args) → display the command list above

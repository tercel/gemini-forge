---
description: "Generate a platform-specific technical draft based on project context. Supports Dev.to, Hashnode, Hacker News, Reddit, X.com Articles, and X.com Threads — each with a unique persona and structure."
---

# Hype-Forge — Draft

This skill focuses on generating high-quality technical drafts for various developer platforms.

## Command: `/hype-forge:draft`

Generates a platform-specific draft based on the project context (README, source code, and tech stack).

### Usage:
`/hype-forge:draft --platform [devto | hashnode | hn | reddit | x-article | x-thread]`

### Platform Logic:

#### 1. Dev.to / Hashnode (`--platform devto` or `--platform hashnode`)
- **Persona**: Friendly, conversational developer sharing a personal journey.
- **Hook**: Start with a relatable problem or a personal "Why I built this" story.
- **Tech Stack**: Clearly mention the stack (e.g., "Using React + Tailwind").
- **Code Snippets**: 3-5 key snippets with clear, narrative-driven explanations.
- **CTA**: "Check out the repo on GitHub" or "Let me know what you think in the comments!"

#### 2. Hacker News (`--platform hn`)
- **Persona**: Hardcore, transparent engineer focused on technical innovation.
- **Focus**: Performance, architecture, unique solutions, and honest trade-offs.
- **Style**: No emojis, no "hype" adjectives (e.g., avoid "revolutionary", "game-changing").
- **Structure**: Link to project -> Short technical summary -> Deep dive into architecture/benchmarks.

#### 3. Reddit (`--platform reddit`)
- **Persona**: Helpful community member contributing to a specific niche.
- **Targeting**: Mention the subreddit (e.g., "Posted to /r/webdev").
- **Hook**: "Hey everyone, I built [X] to solve [Y]. Would love to get some feedback."
- **Interaction**: Ask a specific question to spark discussion.

#### 4. X.com Article (`--platform x-article`)
- **Persona**: Thought leader sharing "the future of [Topic]".
- **Format**: High-impact headings, short paragraphs, punchy sentences.
- **Vibe**: Fast-paced, authoritative, and value-dense.

#### 5. X.com Thread (`--platform x-thread`)
- **Persona**: Engaging builder sharing a breakthrough.
- **Tweet 1 (The Hook)**: "I just built [Product] that does [Result]. Here's how it works 🧵."
- **Tweet 2 (The Demo)**: Describe a visual of the tool in action.
- **Tweet 3-5 (The Code)**: Breakdown of the 1-2 most important functions or architectural choices.
- **Final Tweet (The CTA)**: "Source code here: [Link] | Star if useful!"

## Quality Checklist
- [ ] Is it written in the first person ("I")?
- [ ] Are the code snippets relevant and well-commented?
- [ ] Does it follow the specific platform's tone?
- [ ] Are there placeholders for visual elements (GIFs/Images)?

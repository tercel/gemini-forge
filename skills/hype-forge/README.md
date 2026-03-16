# Hype-Forge — Gemini CLI Skills

A Gemini skill designed to help developers transform their code and projects into high-impact content for technical platforms (Dev.to, Hashnode, X.com, Hacker News, Reddit).

## Commands

| Command | Description |
|---|---|
| `/hype-forge:strategy` | Strategize your content launch |
| `/hype-forge:report` | Generate a high-authority technical investment/audit report |
| `/hype-forge:draft` | Generate platform-specific articles and threads |
| `/hype-forge:code` | Turn raw snippets into narrative-driven explanations |
| `/hype-forge:roast` | Get skeptical feedback to refine your content |
| `/hype-forge:visual` | Get suggestions for GIFs, diagrams, and captions |

## Supported Platforms

| Platform | Persona | Tone |
|---|---|---|
| Dev.to / Hashnode | The Friendly Mentor | Conversational, code-rich, personal |
| Hacker News | The Transparent Engineer | No-fluff, data-driven, architecture-deep |
| Reddit | The Community Contributor | Interactive, humble, subreddit-specific |
| X.com (Article) | The Thought Leader | Punchy, authoritative, value-dense |
| X.com (Thread) | The Hook Architect | Scroll-stopping, concise, visual-first |

## Getting Started

```
1.  /hype-forge:report            # Deep technical audit for investors/leads
2.  /hype-forge:strategy          # Analyze project, plan content series
3.  /hype-forge:draft --platform devto   # Generate first draft
4.  /hype-forge:roast              # Polish before posting
```

---

## Command Reference

### `/hype-forge:report`

Generate a deep-dive technical analysis report for developers, tech leads, and investors.

**Usage**

```
/hype-forge:report [--audience investor|tech-lead|dev-community]
```

**Workflow**

1.  **Technical Audit** — Scans architecture, core patterns, and engineering quality.
2.  **Market Comparison** — Identifies 3-5 competitors and generates a feature-parity matrix.
3.  **Value Mapping** — Translates technical features (e.g., "W3C Traceability") into business value (e.g., "Enterprise Compliance").
4.  **Growth Analysis** — Evaluates ecosystem potential and integration opportunities.

**Example**

```
/hype-forge:report --audience investor
```

---

### `/hype-forge:strategy`

Analyze a project and plan a multi-platform content series.

**Usage**

```
/hype-forge:strategy [--goal goal]
```

**Workflow**

1. **Analyze Context** — Scans README, source code, and tech stack. Identifies the 3 most unique features and target audience.
2. **Generate Content Ideas** — Produces 4 content angles:
   - The Hook/Announcement: "Why I built [Product]"
   - Technical Deep Dive: "How we achieved [Metric] using [Tech]"
   - The Tutorial: "Building a [Example App] with [Product] in 10 minutes"
   - The Growth/Hype: "I discovered [Product] — here's how it changed my workflow"
3. **Schedule Suggestion** — Recommends a 7-day publishing cadence:
   - Day 1: X (Thread) + Dev.to
   - Day 3: Technical Deep Dive on Hashnode
   - Day 5: Showcase on Reddit (/r/webdev, /r/reactjs)
   - Day 7: Official Announcement on Hacker News

**Example**

```
/hype-forge:strategy --goal "launch awareness for my new CLI tool"
```

---

### `/hype-forge:draft`

Generate a platform-specific technical draft based on project context.

**Usage**

```
/hype-forge:draft --platform [devto | hashnode | hn | reddit | x-article | x-thread]
```

**Platform Guides**

| Platform | Persona | Hook Style | Structure |
|---|---|---|---|
| `devto` / `hashnode` | Friendly Mentor | Personal story / pain point | Hook → Problem → Approach → Code → Lessons → CTA |
| `hn` | Transparent Engineer | Direct technical value | Link → Summary → Deep Dive → Benchmarks → Limitations |
| `reddit` | Community Member | "Hey /r/[sub], I built..." | Intro → Demo → Features → Request feedback |
| `x-article` | Thought Leader | Punchy headline | H1 → Short paragraphs → Bullets → Conclusion |
| `x-thread` | Hook Architect | "I just built X that does Y 🧵" | Hook → Demo → Code → CTA |

**Examples**

```
/hype-forge:draft --platform devto
/hype-forge:draft --platform hn
/hype-forge:draft --platform x-thread
```

---

### `/hype-forge:code`

Transform raw code snippets into narrative-driven explanations — the "story" of the code.

**Usage**

```
/hype-forge:code [path to file or snippet]
```

**Workflow**

1. **Context** — What problem does this code solve?
2. **Narrative** — "I started with [Naive approach], but found [Problem]. So, I [Solution]."
3. **Explanation** — Break down the code into 2-3 logical steps.
4. **Trade-offs** — Why this approach? (e.g., "Trading readability for performance").

**Example**

```
/hype-forge:code src/core/parser.ts
```

---

### `/hype-forge:roast`

Critique a technical draft by simulating real-world developer community feedback.

**Usage**

```
/hype-forge:roast [path to draft]
```

**Roast Personas**

| Persona | Perspective | Critique Focus |
|---|---|---|
| Skeptical HN Reader | "Why does this exist?" "Where are the benchmarks?" | Technical originality, performance, transparency |
| Practical Dev.to Junior | "This is too complicated." "Can you explain simpler?" | Readability, educational value, approachability |
| Anti-AI Advocate | "This sounds like ChatGPT wrote it." "Too many buzzwords." | Removing AI-isms, ensuring personal voice, finding human anecdotes |

**Example**

```
/hype-forge:roast drafts/devto-launch-post.md
```

---

### `/hype-forge:visual`

Suggest where to insert GIFs, images, diagrams, and code screenshots to improve readability and engagement.

**Usage**

```
/hype-forge:visual [path to draft]
```

**Workflow**

1. **Identify** — Scan for long text blocks, complex concepts, or architecture descriptions.
2. **Suggest** — Recommend the right visual type for each section.
3. **Caption** — Provide friendly, descriptive captions.
4. **Place** — Insert placeholders using `![GIF: Description](URL)` format.

**Visual Type Guidelines**

| Content Type | Recommended Visual | Best For |
|---|---|---|
| CLI / terminal interaction | GIF (15-30s) | Dev.to, X Thread |
| System architecture | Mermaid diagram or draw.io | Hashnode, HN |
| Code comparison | Side-by-side screenshot | X Article, Dev.to |
| Performance data | Chart / graph | HN, Hashnode |
| UI component | Screenshot or short GIF | Reddit, X Thread |

**Example**

```
/hype-forge:visual drafts/hashnode-deep-dive.md
```

---
*Forged by hype-forge.*

---
## Installation Note

This repository uses the `-gemini` suffix in its directory name to distinguish it from Claude-compatible versions in the source workspace.

### Recommended Deployment (via gemini-forge)
If you use [gemini-forge](https://github.com/tercel/gemini-forge), you can deploy directly:
```bash
gemini-forge deploy . user
```

### Manual Installation
If you are installing this skill manually (via `/install:skill` or by moving it to `~/.gemini/skills/`), it is **strongly recommended** to rename the directory to its original name (without the `-gemini` suffix) to ensure correct path authorization and command mapping in the Gemini CLI:

---

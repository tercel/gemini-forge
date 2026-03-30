# spec-forge

**Professional Software Specification Generator for Gemini CLI**

Generate industry-standard specifications — from early-stage brainstorming to Technical Design with auto-generated feature specs — each usable standalone or as part of a streamlined auto chain.

## Overview

Software projects need clear specifications. spec-forge covers the full journey from idea to implementation-ready documents:

| Command | Description | Standards |
|---------|-------------|-----------|
| `/spec-forge:idea <name>` | Interactive brainstorming — explore and refine ideas | — |
| `/spec-forge:decompose <name>` | Decompose project into sub-features | — |
| `/spec-forge:tech-design <name>` | Technical Design Document + auto-generated feature specs | Google Design Doc, RFC Template |
| `/spec-forge <name>` | **Full chain** — auto-run Idea → Decompose → Tech Design + Feature Specs → Review | All of the above |
| `/spec-forge:review <name>` | Review generated specs for quality & consistency, auto-fix issues | — |
| `/spec-forge:prd <name>` | Product Requirements Document (on-demand) | Google PRD, Amazon PR/FAQ |
| `/spec-forge:srs <name>` | Software Requirements Specification (on-demand) | IEEE 830, ISO/IEC/IEEE 29148 |
| `/spec-forge:test-cases <name>` | Test Cases with coverage matrix (on-demand) | Multi-dimensional coverage |
| `/spec-forge:audit [path]` | Audit docs for quality, completeness & code alignment | — |
| `/spec-forge:analyze [path]` | Analyze document collection — map themes, find conflicts & gaps | — |

**Aliases**: `/prd`, `/srs`, `/tech-design`, `/test-cases`, `/idea`, `/decompose`, `/review`, `/audit`, `/analyze` work as shortcuts — they invoke each skill directly, bypassing the `/spec-forge` orchestrator.

## Features

- **Idea to Spec**: Brainstorm interactively, then graduate ideas into architecture docs + feature specs
- **Full Chain Mode**: One command runs the streamlined chain (Idea → Decompose → Tech Design + Feature Specs → Review)
- **Standalone or Chained**: Use any command on its own, or run the full chain for traceability
- **Industry Standards**: Templates grounded in Google, Amazon, Stripe, IEEE, and ISTQB best practices
- **Automatic Context Scanning**: Scans your project structure, README, and existing docs before generation
- **Project Decomposition**: Automatically analyzes scope and splits large projects into sub-features
- **Smart Upstream Detection**: Finds upstream documents when available; asks compensating questions when not
- **Quality Checklists**: Built-in 4-tier validation (completeness, quality, consistency, formatting)
- **Mermaid Diagrams**: Architecture, sequence, user journey, and Gantt diagrams
- **Spec Review**: Review generated specs for quality and consistency with auto-fix
- **Documentation Audit**: Cross-reference docs against code for quality, completeness, and consistency
- **Document Landscape Analysis**: Map, cluster, and evaluate document ecosystems

## Commands

### `/spec-forge:idea <name>` — Brainstorming

Interactive, multi-session brainstorming for early-stage ideas:
- **Iterative**: Explore an idea across multiple sessions, days apart
- **Persistent**: Sessions stored in `ideas/` directory
- **Graduated**: When an idea is ready, it flows into the spec chain seamlessly

### `/spec-forge <name>` — Full Chain

Run the streamlined specification chain in one command:
```bash
/spec-forge user-login              # Auto: Idea → Decompose → Tech Design + Feature Specs → Review
```

### `/spec-forge:tech-design <name>`

Generates a Technical Design Document including:
- C4 architecture diagrams (Context, Container, Component)
- Alternative solution comparison matrix
- API design (RESTful / GraphQL / gRPC)
- Database schema and migration strategy
- Security, performance, and observability design
- Auto-generates per-component feature specs in `docs/features/`

### `/spec-forge:test-cases <name>`

Generates structured test cases with multi-dimensional coverage:
- Happy Path (L1) + Boundary/Error (L2) + Negative (L3)
- Coverage matrix with gap analysis
- `--formal` adds management sections

## Installation

### Gemini CLI

```bash
/skill install spec-forge
```

## License

MIT License

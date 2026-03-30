# Spec-Forge Chain Execution Logic

This document defines the logic for the `/spec-forge <name>` auto-chain pipeline.

## Overview
The chain runs: **Idea → Decompose → Tech Design + Feature Specs → Review**.
It uses a "sub-agent" model where each stage is delegated to a `generalist` agent to keep the orchestrator context clean.

## Stage 1: Project Context Scan (Pre-Chain)
Before starting, perform a deep scan of the project to build shared context.
- Use `glob` and `grep_search` to detect tech stack and architecture.
- Store summary in `project_context_summary`.
- Reference: `@../references/shared/project-context.md`

## Stage 2: Idea Validation
- Check `ideas/{argument}/` for existing draft.
- If not ready, delegate to `generalist` to run the `/spec-forge:idea` skill.
- Goal: Produce `ideas/{argument}/draft.md`.

## Stage 3: Project Decomposition
- Delegate to `generalist` to run the `/spec-forge:decompose` skill.
- If `docs/project-{argument}.md` is created, switch to multi-split execution mode.

## Stage 4: Tech Design + Feature Specs
- For each (sub-)feature, delegate to `generalist` to run the `/spec-forge:tech-design` skill.
- Use `idea-first mode` if a draft exists.
- This automatically generates `docs/{feature}/tech-design.md` and `docs/features/*.md`.

## Stage 5: Specification Review
- Delegate to `generalist` to run the `/spec-forge:review` skill.
- Review all generated documents for quality and consistency.

## Stage 6: Completion
- Show completion summary and recommended next steps (e.g., `/code-forge:plan`).
- Mark idea as `graduated`.

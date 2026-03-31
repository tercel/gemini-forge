---
name: srs-generation
description: >
  Generates professional Software Requirements Specification (SRS) documents based on IEEE 830,
  ISO/IEC/IEEE 29148, and Amazon technical specification standards. This skill activates when the
  user needs a requirements document, requirements specification, SRS, functional requirements,
  non-functional requirements, software requirements, requirements analysis, or requirements
  engineering. It formalizes product needs into structured, testable, and traceable requirements
  with unique IDs, acceptance criteria, use cases, a CRUD matrix, and a full traceability matrix
  linking back to the upstream PRD.
instructions: >
  Generate a complete Software Requirements Specification following IEEE 830, ISO/IEC/IEEE 29148,
  and Amazon technical specification standards. Use the template at references/template.md and
  validate against references/checklist.md before finalizing.
---

# SRS Generation Skill

## What Is a Software Requirements Specification?

A Software Requirements Specification (SRS) is a formal document that describes exactly what a software system must do and the constraints under which it must operate. It serves as the contractual bridge between stakeholders who define the product vision (captured in a PRD) and the engineering team that designs, builds, and tests the system. A well-written SRS eliminates ambiguity, reduces rework, and provides a single source of truth for every requirement the system must satisfy.

The two foundational standards for SRS documents are **IEEE 830** (IEEE Recommended Practice for Software Requirements Specifications) and **ISO/IEC/IEEE 29148** (Systems and Software Engineering -- Life Cycle Processes -- Requirements Engineering). IEEE 830 established the canonical section structure -- introduction, overall description, specific requirements -- and defined the quality attributes every requirement must exhibit: correctness, unambiguity, completeness, consistency, ranking for importance, verifiability, modifiability, and traceability. ISO/IEC/IEEE 29148 modernized this foundation by integrating requirements engineering into the full systems and software lifecycle, emphasizing stakeholder needs analysis, requirements analysis, and requirements validation as continuous activities rather than one-time documentation events. This skill combines the structural rigor of both standards with the pragmatic, metric-driven approach found in Amazon technical specifications, where every requirement must be tied to a measurable outcome.

## Generation Workflow

The SRS generation process follows a six-step workflow designed to produce a complete, high-quality document:

### Step 1: Scan Context

Before writing a single requirement, scan the project to build context:

@../shared/project-context.md

Execute the Project Context Protocol (PC.1 through PC.3) to establish the technical landscape — programming languages, frameworks, project profile, existing APIs, data stores. This ensures requirements are grounded in the real project environment rather than written in a vacuum. The detected project profile (PC.3) determines which non-functional requirement categories are most relevant (e.g., database-backed projects need data integrity NFRs; CLI tools need usability NFRs).

### Step 2: Find the Upstream PRD

The most critical input to any SRS is the Product Requirements Document. The skill automatically searches for a matching PRD file (following the `docs/<feature-name>/prd.md` naming convention) and reads it thoroughly when found. The PRD provides the product vision, user stories, feature definitions, success metrics, and scope boundaries that the SRS must formalize into precise, testable requirements. If no PRD is found, the skill proceeds but flags that traceability to product-level requirements will be limited.

### Step 3: Clarify Questions

The skill asks the user targeted clarification questions covering functional scope, performance targets, security needs, data requirements, integration points, availability and reliability expectations, compatibility constraints, and regulatory or compliance obligations. These questions fill gaps that the PRD may not address at the level of detail an SRS demands -- for example, specific response-time thresholds, concurrent-user targets, or data-retention policies.

### Step 4: Generate the SRS

Using the template at `references/template.md`, the skill generates the full SRS document. Follow the writing guidelines and standards defined in the reference files below.

- **Writing Guidelines**: @./writing-guidelines.md
- **Standards**: @./standards.md

Every section of the IEEE 830 structure is populated: introduction, overall description, functional requirements, non-functional requirements, data requirements, external interface requirements, and the requirements traceability matrix. Requirements are written following the conventions and quality standards described in the reference files.

### Step 5: Traceability

If an upstream PRD was found, the skill builds a requirements traceability matrix (RTM) that maps every PRD feature or user story to one or more SRS requirements. This matrix ensures complete coverage -- no PRD item should be left without a corresponding SRS requirement -- and provides downstream documents (Technical Design, Test Plan) with a clear chain of custody for every requirement.

### Step 6: Quality Check

Before finalizing, the skill loads the checklist at `references/checklist.md` and evaluates the generated document against every item. Any failed check triggers revision. The document is only written to disk once all checklist items pass.

## Reference Files

The SRS generation skill relies on two reference files:

- **`references/template.md`**: The complete SRS document template following IEEE 830 structure. This template defines every section, provides placeholder guidance, and establishes the formatting conventions for requirements, tables, and diagrams.
- **`references/checklist.md`**: The quality checklist used during the final validation step. It contains items organized into four categories -- completeness, quality, consistency, and format -- that the generated document must satisfy before it is written to disk.

## Output Convention

The final SRS document is written to `docs/<feature-name>/srs.md` in the project root, where `<feature-name>` is a sanitized, lowercase, hyphen-separated slug derived from the user's input. The `docs/<feature-name>/` directory is created if it does not already exist. If a file with the same name already exists, confirm with the user before overwriting. This naming convention places all documents for a feature in a single `docs/<feature-name>/` directory (`prd.md`, `srs.md`, `tech-design.md`, `test-cases.md`) and enables automatic upstream document discovery by downstream skills.

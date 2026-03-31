# SRS Writing Guidelines

## Requirement ID Conventions

Every requirement receives a unique identifier that encodes its type and module or category:

- **Functional Requirements**: `FR-<MODULE>-<NNN>` where `<MODULE>` is a short uppercase label for the feature module (e.g., AUTH, CART, SEARCH, NOTIFY) and `<NNN>` is a zero-padded sequential number. Examples: FR-AUTH-001, FR-CART-012, FR-SEARCH-003.
- **Non-Functional Requirements**: `NFR-<CATEGORY>-<NNN>` where `<CATEGORY>` identifies the quality attribute (e.g., PERF, SEC, REL, AVL, MNT, PRT, USB) and `<NNN>` is a zero-padded sequential number. Examples: NFR-PERF-001, NFR-SEC-003, NFR-REL-002.

These IDs are used throughout the document -- in the requirements traceability matrix, in cross-references between related requirements, and in downstream documents such as technical designs and test plans. Consistent ID formatting is essential for automated traceability and search.

## Functional Requirements Writing Standards

Each functional requirement is structured as a complete use case specification with the following elements:

- **Requirement ID and Title**: The unique identifier and a concise descriptive title.
- **Description**: A clear statement of what the system shall do, written from the perspective of the system behavior rather than the implementation approach.
- **Actors**: The user classes or external systems that participate in this requirement. Actors include both human users and AI agent consumers — if a requirement is exercised by an API client, automation tool, or other programmatic consumer, list that actor explicitly with its interaction pattern (REST API, async event, webhook, etc.).
- **Preconditions**: The conditions that must be true before the requirement can be exercised.
- **Main Flow**: A numbered sequence of steps describing the standard successful path through the use case.
- **Alternative Flows**: Branches from the main flow covering variations, error conditions, and edge cases.
- **Postconditions**: The observable state of the system after successful completion of the main flow.
- **Acceptance Criteria**: Specific, testable conditions that must be met for the requirement to be considered satisfied. Each acceptance criterion should be verifiable through inspection, demonstration, test, or analysis. For agent-facing requirements, acceptance criteria must be machine-verifiable — expressed as exact input/output contracts (e.g., "Given POST /api/v1/users with body {name, email}, then response status is 201 and JSON body contains {id, email, created_at}") rather than human-subjective descriptions.
- **Priority**: The importance level of the requirement (P0 = must-have, P1 = should-have, P2 = nice-to-have), consistent with the prioritization used in the upstream PRD.
- **Source**: A reference back to the PRD item or stakeholder request that originated this requirement.

Each functional requirement also carries a **Priority Rationale** field explaining *why* the assigned priority (P0/P1/P2) was chosen. Stating "P0" without justification is not sufficient — the rationale must connect the priority to a concrete consequence: "P0: the product cannot launch without this because it is the sole entry point for all user actions" or "P2: a manual workaround exists in v1 and user research shows it is acceptable for the first six months." Priority assignments that lack rationale are flagged as incomplete during the quality check.

In addition to individual requirement specifications, the SRS includes a **CRUD matrix** -- a table that maps data entities (rows) against Create, Read, Update, and Delete operations (columns), with each cell indicating which functional requirement governs that operation. The CRUD matrix provides a rapid completeness check: if an entity has no "Delete" operation defined, that may be intentional (soft-delete policy) or an oversight that needs resolution.

## Non-Functional Requirements Categories

Non-functional requirements define the quality attributes and constraints of the system. Each NFR must include a specific, measurable metric, a target value, a measurement method, and a **Threshold Rationale** explaining *why this specific target value was chosen* rather than a higher or lower one. The rationale must cite at least one of: a business contract or SLA obligation, observed production baseline data, competitive benchmark, regulatory standard, or a cost/complexity trade-off analysis. NFR targets written without threshold rationale (e.g., "99.9% uptime" with no explanation) are treated as unsubstantiated guesses and flagged during the quality check. The SRS organizes NFRs into the following categories:

- **Performance (NFR-PERF)**: Response times, throughput, latency percentiles (p50, p95, p99), concurrent user capacity, and resource utilization limits.
- **Security (NFR-SEC)**: Authentication mechanisms, authorization models, encryption standards, data protection measures, vulnerability scanning requirements, and compliance with security frameworks.
- **Reliability (NFR-REL)**: Mean time between failures (MTBF), mean time to recovery (MTTR), error rates, data integrity guarantees, and fault tolerance mechanisms.
- **Availability (NFR-AVL)**: Uptime SLAs (e.g., 99.9%), planned maintenance windows, disaster recovery objectives (RPO/RTO), and geographic redundancy requirements.
- **Maintainability (NFR-MNT)**: Code quality standards, documentation requirements, deployment frequency targets, and technical debt constraints.
- **Portability (NFR-PRT)**: Supported platforms, browsers, operating systems, container runtimes, and cloud provider compatibility.
- **Usability (NFR-USB)**: Accessibility standards (WCAG compliance level), internationalization requirements, maximum task-completion times, and user satisfaction targets.

# SRS Standards

## Requirements Traceability Matrix

The requirements traceability matrix (RTM) is a table that establishes bidirectional links between PRD items and SRS requirements. Each row maps a PRD identifier to one or more SRS functional or non-functional requirement IDs, along with a coverage status (Fully Covered, Partially Covered, or Not Covered). The RTM serves three purposes: it confirms that every product need has been addressed, it enables impact analysis when requirements change, and it provides the foundation for downstream traceability into technical design and test planning.

## Requirement Language Conventions

The SRS uses precise modal verbs to convey obligation levels, following IEEE 830 and RFC 2119 conventions:

- **"shall"**: Indicates a mandatory requirement. The system must satisfy this requirement to be considered compliant. Example: "The system shall authenticate users via OAuth 2.0 before granting access to protected resources."
- **"should"**: Indicates a recommended requirement. The system is expected to satisfy this requirement under normal circumstances, but justified exceptions are acceptable. Example: "The system should cache frequently accessed queries to reduce database load."
- **"may"**: Indicates an optional requirement. The system is permitted but not required to implement this behavior. Example: "The system may provide a dark-mode theme for the user interface."

Avoiding ambiguous language is critical. Terms like "fast," "user-friendly," "efficient," or "robust" are never used in isolation. Every qualitative claim must be paired with a quantitative target (e.g., "The system shall return search results within 200ms at the 95th percentile" rather than "The system shall be fast").

## Requirement Quality Attributes

Every requirement in the SRS -- functional or non-functional -- must satisfy four quality attributes:

1. **Unambiguous**: The requirement has exactly one interpretation. There is no room for disagreement about what the requirement means. Techniques for achieving unambiguity include using precise terminology defined in the glossary, avoiding pronouns with unclear antecedents, and stating explicit boundary conditions.
2. **Testable**: The requirement includes acceptance criteria or measurable targets that can be verified through testing, inspection, demonstration, or analysis. If a requirement cannot be tested, it must be rewritten until it can.
3. **Traceable**: The requirement can be traced both backward (to its source in the PRD or stakeholder request) and forward (to the design components and test cases that address it). Traceability is maintained through the requirement ID system and the RTM.
4. **Complete**: The requirement contains all information necessary for implementation. It specifies inputs, outputs, preconditions, postconditions, error handling, and boundary conditions without requiring the reader to make assumptions.

## Anti-Shortcut Rules

The following shortcuts are **strictly prohibited** — they are common AI failure modes that produce low-quality SRS documents:

1. **Do NOT copy-paste PRD content as requirements.** The PRD describes *what the product should be*; the SRS must specify *what the system shall do* in precise, testable terms. Simply rephrasing PRD bullets is not requirements engineering.
2. **Do NOT skip alternative flows and exception scenarios.** Every use case has error paths, edge cases, and recovery scenarios. Writing only the happy path is incomplete. Each functional requirement must include alternative and exception flows.
3. **Do NOT use vague verbs.** Words like "handle", "manage", "process", or "support" are ambiguous. Replace with specific behaviors: "validate", "reject with error code 422", "persist to the `orders` table", "return within 200ms".
4. **Do NOT omit boundary conditions.** Every input field, parameter, and data entity has limits. If you don't specify min/max lengths, allowed characters, and range constraints, engineers will guess differently.
5. **Do NOT write untestable requirements.** If a requirement cannot be verified by a concrete test case, it is not a valid requirement. Every requirement must have measurable acceptance criteria (Given/When/Then or explicit conditions).

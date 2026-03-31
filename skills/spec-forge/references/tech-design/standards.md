# Tech Design Standards

## Architecture Diagram Standards -- C4 Model

All architecture diagrams follow the C4 model, which provides four levels of abstraction for communicating software architecture.

**Level 1 -- Context Diagram.** Shows the system as a single box surrounded by the people who use it and the external systems it interacts with. This is the highest-level view and should be understandable by non-technical stakeholders. Use a Mermaid `flowchart TB` diagram with clear labels for each actor and system.

**Level 2 -- Container Diagram.** Zooms into the system box and shows the high-level technology building blocks: web applications, APIs, databases, message queues, file storage, and other containers. Each container is labeled with its technology choice. Use a Mermaid `flowchart TB` diagram with subgraphs to group related containers.

**Level 3 -- Component Diagram.** Zooms into a single container and shows the major structural components inside it: controllers, services, repositories, domain models, and their relationships. Use a Mermaid `flowchart LR` or `flowchart TB` diagram.

**Level 4 -- Code Diagram.** Typically not included in the design document itself but may be referenced for particularly complex algorithms or data structures. When needed, use Mermaid `classDiagram` notation.

All Mermaid code blocks must use the ` ```mermaid ` fence so they render correctly in GitHub, GitLab, and most Markdown viewers. Every diagram must have a descriptive title, and every node must have a human-readable label.

## Naming Conventions

Inconsistent naming across code, APIs, and databases is one of the most common sources of confusion in engineering teams. The design document must define naming conventions at three levels:

**Code Naming.** Specify conventions for files/modules, classes/structs, interfaces/traits, functions/methods, variables, constants, enums, and test files. Follow the chosen language ecosystem's conventions (e.g., camelCase for JavaScript, snake_case for Python/Rust, PascalCase for Go exported names).

**API Naming.** Specify conventions for URL path segments (kebab-case plural nouns recommended for REST), query parameters, request/response body fields, custom headers, and error codes. The request and response field conventions must match.

**Database Naming.** Specify conventions for table names (snake_case plural recommended), column names, primary/foreign keys, index names, constraint names, and enum types. Use a consistent pattern like `idx_<table>_<columns>` for indexes and `fk_<table>_<referenced_table>` for foreign keys.

## Anti-Shortcut Rules

The following shortcuts are **strictly prohibited** — they are common AI failure modes that produce low-quality tech designs:

1. **Do NOT present only one solution disguised as a comparison.** The plan requires at least 2 genuine alternatives with honest trade-off analysis. Adding a straw-man "do nothing" option does not count.
2. **Do NOT use "handle appropriately" or "validate as needed".** Every error condition must specify the exact HTTP status code, error code, retry behavior, and user-facing message. Every validation rule must specify the exact type, range, pattern, and error response.
3. **Do NOT omit parameter validation details.** Every API parameter must have: type, required/optional, min/max, regex pattern, default value, sanitization rule, and specific error message. No parameter may be left unspecified.
4. **Do NOT draw empty-shell Mermaid diagrams.** Every node must have a label. Every arrow must have a description. Diagrams without annotations are decoration, not documentation. If a diagram doesn't add information beyond the text, remove it.
5. **Do NOT write "details to follow" or "TBD" without a concrete follow-up plan.** If a section is incomplete, state what is unknown, what is needed to resolve it, and who is responsible. Open questions must be logged in the document's Open Questions section.

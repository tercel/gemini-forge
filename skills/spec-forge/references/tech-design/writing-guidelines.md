# Tech Design Writing Guidelines

## Key Sections and Content Guidance

The following guidelines apply when writing each section of the Technical Design Document.

**Technology Stack Decision.** Every technical design must begin with explicit technology choices. The Technology Stack section requires a table listing every layer of the system (programming language, runtime, framework, ORM, database, cache, message queue, frontend framework, testing framework, build tool, containerization) with the specific version and a rationale explaining why it was chosen. Rationales must be project-specific -- "it's popular" is not sufficient; "Go 1.22 was chosen because the team has 3 years of Go experience and its concurrency model fits our real-time event processing needs" is.

**Parameter Validation & Input Parsing.** Every parameter that crosses a trust boundary must have explicit validation rules. The design document must include a Validation Rules Matrix table where each row defines: parameter name, type, required/optional, minimum value, maximum value, pattern/format (regex or standard like RFC 5322 for email), default value, sanitization strategy, and the specific error message returned on failure.

Beyond the matrix, the document must define type coercion rules (how strings are parsed to integers, booleans, dates, enums), input sanitization strategy (HTML/XSS, SQL injection, path traversal, command injection, JSON depth limits), and the distinction between null, missing, and empty values.

**Boundary Values & Edge Cases.** The design must document every system limit and what happens when it is exceeded. This includes: request body size, string field lengths, array sizes, concurrent connections, rate limits, file upload sizes, JSON nesting depth, pagination result caps, and bulk operation batch sizes. For each limit, specify the exact number, the behavior when exceeded (specific HTTP error code), and the rationale.

Edge cases must be documented in a table covering at minimum: empty string input, unicode/emoji handling, idempotent duplicate requests, behavior during database migration, concurrent update conflicts, referential integrity on delete, timezone handling, numeric overflow, null vs zero semantics, and long-running request timeouts.

**Business Logic Rules.** All business rules must be documented precisely enough that an engineer can implement them without ambiguity.

**State Machines.** If entities have lifecycle states, define the state machine using a Mermaid `stateDiagram-v2` diagram. For every transition, document: from state, to state, trigger, guard conditions (what must be true), and side effects (what happens as a result).

**Computation Rules.** For every calculation or derived value, document: a rule ID, description, formula/logic, inputs, output type, numeric precision and rounding strategy, and a worked example with real numbers.

**Conditional Logic.** For complex branching behavior, document each condition with what happens when true and when false, plus any relevant notes about configurability or thresholds.

**Error Handling Strategy.** Define a comprehensive error taxonomy covering every error category the system can produce. For each category, specify: HTTP status code, error code pattern, whether the client should retry, and the user-facing message. Additionally, define retry and circuit breaker configuration for every external dependency: retry count, backoff strategy, circuit breaker threshold, timeout, and fallback behavior.

**API Design Conventions.** The design document must specify API conventions appropriate to the chosen protocol.

**RESTful APIs.** Follow resource-oriented design. Endpoints use plural nouns (e.g., `/api/v1/users`, `/api/v1/orders/{orderId}/items`). Use standard HTTP methods: GET for retrieval, POST for creation, PUT/PATCH for updates, DELETE for removal. Version the API in the URL path (e.g., `/api/v1/`). Define standard error response shapes with error codes, messages, and request IDs.

**GraphQL APIs.** Define the schema with queries, mutations, and subscriptions. Document resolver responsibilities and data loader patterns for N+1 prevention. Specify error handling conventions within the GraphQL response structure.

**gRPC APIs.** Define service and message protobuf schemas. Document streaming patterns (unary, server-streaming, client-streaming, bidirectional). Specify deadline and retry policies.

Regardless of protocol, every API specification must include: endpoint or operation name, authentication requirements, request schema with field types and validation rules, response schema with example payloads, and a complete error code table.

**Database Design Standards.** Database design sections must include the following elements.

**Schema Design.** Define every table or collection with its columns, data types, constraints (primary key, foreign key, unique, not null, defaults), and purpose. Use a table format for clarity.

**ER Diagram.** Use Mermaid `erDiagram` syntax to visualize entity relationships. Label every relationship with its cardinality and nature.

**Index Strategy.** For each table, define the indexes needed: primary indexes, unique indexes, composite indexes for common query patterns, and partial or conditional indexes where appropriate. Document the rationale for each index in terms of the queries it supports.

**Migration Strategy.** Plan how schema changes will be applied: migration tool selection, forward and backward compatibility, zero-downtime migration techniques (expand-contract pattern), and data backfill procedures.

**Solution Comparison Methodology.** Every design document must evaluate at least two alternative solutions. The comparison follows a structured methodology.

1. **Describe each solution** with enough detail that a reader can understand its architecture, key technology choices, and implementation approach.
2. **List pros and cons** for each solution, organized by technical merit, operational impact, and business alignment.
3. **Build a comparison matrix** evaluating all solutions against consistent criteria: implementation complexity, performance characteristics, scalability ceiling, operational cost, team expertise alignment, time to delivery, and risk profile. Use a rating system (e.g., High / Medium / Low or numeric scores) for each criterion.
4. **Document the decision** with explicit rationale explaining why the recommended solution was chosen and why the alternatives were rejected.

**Security Design Principles.** Security must be treated as a first-class architectural concern, not a bolt-on afterthought.

**Authentication.** Specify the authentication mechanism (OAuth 2.0, JWT, API keys, mTLS, SAML) and document the token lifecycle including issuance, validation, refresh, and revocation.

**Authorization.** Define the authorization model (RBAC, ABAC, or hybrid). Document roles, permissions, and access control rules. Specify how authorization is enforced at the API gateway, service, and data layers.

**Data Encryption.** Specify encryption at rest (algorithm, key management, rotation policy) and encryption in transit (TLS version, certificate management). Document handling of sensitive fields (PII, payment data) including tokenization or field-level encryption where applicable.

**Audit Logging.** Define what events are logged (authentication attempts, data access, configuration changes), the log format, retention policy, and how audit logs are protected from tampering.

**Performance Design.** Performance sections must be specific and measurable, not aspirational.

**Target Metrics.** Define concrete targets: API response time at p50, p95, and p99 percentiles; throughput in requests per second; error rate thresholds; and resource utilization limits.

**Caching Strategy.** Specify what is cached (query results, computed values, static assets), where caching happens (browser, CDN, application layer, database query cache), cache invalidation strategy (TTL, event-driven, manual), and cache warming procedures.

**Optimization Plan.** Document specific optimization techniques: query optimization, connection pooling, lazy loading, pagination strategies, batch processing, and async processing for non-critical paths.

**Observability.** The design must plan for production observability from the start.

**Logging.** Define log levels, structured log format (JSON recommended), correlation ID propagation, and log aggregation destination. Specify what must be logged at each level.

**Monitoring and Metrics.** Define the key metrics to track: RED metrics (Rate, Errors, Duration) for services, USE metrics (Utilization, Saturation, Errors) for resources, and business metrics. Specify the monitoring tool and dashboard requirements.

**Alerting.** Define alerting rules with conditions, severity levels, notification channels, and escalation procedures. Include runbook references for each alert.

**Deployment Strategy.** The deployment section ensures the design is production-ready.

**Environments.** Define the environment topology (development, staging, production) with purpose, configuration differences, and access controls for each.

**CI/CD Pipeline.** Describe the pipeline stages: build, unit test, integration test, security scan, artifact creation, deployment, smoke test, and promotion. Specify any gates or approval steps.

**Rollback Strategy.** Define how to roll back a failed deployment: blue-green switching, canary percentage reduction, feature flag disabling, or database migration reversal. Specify the rollback decision criteria and the maximum time to rollback.

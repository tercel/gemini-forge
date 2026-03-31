# Test Case Standards

## ID Format

```
TC-<MODULE>-<NNN>
```

- **TC** — fixed prefix
- **MODULE** — 3-5 character uppercase code for feature area (AUTH, PAY, CART, TOOL, CLI)
- **NNN** — zero-padded three-digit sequence starting at 001

## Test Case Structure

Each test case must be implementation-ready. Fields:

- **TC ID** — unique identifier (TC-MODULE-NNN)
- **Title** — pattern: `[action] [condition] [expected outcome]`
- **Module** — feature area or component under test
- **Dimensions** — which dimension values this case covers (e.g., `L2, Auth:admin`)
- **Priority** — P0 / P1 / P2
- **Category** — Functional / Data Integrity / Security / Performance
- **Preconditions** — exact state before test runs (database records with specific field values, auth state, config flags). No vague descriptions.
- **Steps** — numbered steps with concrete test data. Use real values: `name: "John Doe"`, `email: "test@example.com"`. Never use placeholders like `[valid name]`.
- **Expected Result** — two parts: (1) Response/output (exact status code, body structure). (2) State After (for write operations, exact database/state verification).
- **Not Expected** — what should NOT happen (required for L3 cases, recommended for all)
- **Test Infra** — what infrastructure the test needs: Real DB / Temp dir / Mock external (with justification) / N/A
- **Automation** — automated / to-be-automated / manual

## Formal Mode (`--formal`)

When `--formal` flag is provided, the output additionally includes:
- Document information and revision history
- Test environment specifications (hardware, software, network)
- Entry and exit criteria
- Test data management strategy
- Defect management process (severity classification, lifecycle, reporting template)
- Risk assessment (testing risks, product risks with reasoning)
- Test schedule (Gantt chart, milestones)
- Roles and responsibilities

These sections follow IEEE 829 structure for teams that need formal QA documentation.

# Assertions and Triggers

This section demonstrates database-level enforcement beyond standard queries by using assertions and triggers.

## Topics Covered

- Global integrity rules with `ASSERTION`
- `BEFORE INSERT` repair triggers
- `AFTER INSERT` validation triggers
- Statement-level trigger logging
- Audit table design
- Success and violation test cases

## Files

- `assertions.sql` — global business rule enforcement
- `audit_setup.sql` — audit table for trigger logging
- `triggers.sql` — repair, validation, and statement-level triggers

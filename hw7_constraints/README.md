# Constraints, Foreign Keys, and Deferred Constraints

This section demonstrates schema hardening and referential integrity features in SQL.

## Topics Covered

- Attribute-level and tuple-level `CHECK` constraints
- `NOT NULL` enforcement
- Named constraints and dropping constraints
- Foreign keys with `ON DELETE RESTRICT`
- Foreign keys with `ON UPDATE CASCADE`
- Foreign keys with `ON DELETE SET NULL`
- Deferred constraint checking for circular references

## Files

- `constraints.sql` — basic attribute and tuple constraints
- `foreign_keys.sql` — foreign keys and referential actions
- `deferred_constraints.sql` — deferred constraint example with circular references

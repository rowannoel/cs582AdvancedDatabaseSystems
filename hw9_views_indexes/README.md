# Views, Indexing, and Database Performance

This project demonstrates advanced database concepts including views, indexing, and performance optimization.

## Topics Covered

### Views
- Creating filtered and aggregated views
- Querying views
- Understanding how DBMS expands view definitions

### Updatable Views
- View constraints using `WITH CHECK OPTION`
- Insert operations through views

### Materialized View Simulation
- Precomputed aggregation tables
- Manual refresh strategies
- Handling stale data

### Indexing
- Single-attribute index (order_date)
- Multi-attribute index (order_id, prod_id)
- Query performance analysis using EXPLAIN

### Clustering
- Simulated clustering using ordered tables
- Impact on range queries and I/O behavior

---

## Key Concepts

- Reducing query cost through indexing
- Trade-offs between read performance and write overhead
- Physical vs logical data organization
- Precomputation vs real-time computation

---

## Files

- `schema_and_queries.sql` — full implementation including schema, views, indexes, and performance testing

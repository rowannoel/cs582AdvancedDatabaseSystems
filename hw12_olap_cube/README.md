# OLAP Data Cube and Slice/Dice Analytics

This project demonstrates OLAP-style analytics using SQL, including fact table construction, multidimensional aggregation, and materialized cube persistence.

## Topics Covered

- Fact table construction from dimension tables
- GROUP BY CUBE for multidimensional aggregation
- Slice operations (filtering one dimension)
- Dice operations (filtering multiple dimensions)
- Materialized view for persisted cube results
- Refreshing aggregated data after new inserts

## Schema

Dimension Tables:
- Product(productID, productName)
- Dealer(dealerID, dealerName, region)

Fact Table:
- Sales(saleID, productID, dealerID, saleDate, price)

The Sales table acts as the fact table, while Product and Dealer serve as dimensions for OLAP analysis.

## Files

- `schema.sql` — Creates tables and inserts sample data
- `fact_table.sql` — Builds the OLAP fact table join
- `cube_queries.sql` — GROUP BY CUBE aggregation
- `slice_dice.sql` — Slice and dice analytical queries
- `materialized_cube.sql` — Materialized cube and refresh logic
- `HW12.pdf` — Original submission including query output screenshots and explanations

## Notes

The `HW12.pdf` file contains:
- Fact table output
- GROUP BY CUBE results
- Slice query results
- Dice query results
- Materialized view before refresh
- Materialized view after refresh

These screenshots demonstrate the execution and correctness of the OLAP queries.

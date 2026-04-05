-- HW8 - Audit table used by the statement-level trigger

CREATE TABLE Audit (
    order_id INT,
    rows_added INT,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

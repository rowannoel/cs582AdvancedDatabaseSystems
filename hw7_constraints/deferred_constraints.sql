-- HW7 - Problem 3: Deferred Constraints & Circularity

-- Circular foreign key example using DEFERRABLE INITIALLY DEFERRED

CREATE TABLE A (
    a_id INT PRIMARY KEY,
    b_id INT,
    CONSTRAINT fkAB
        FOREIGN KEY (b_id) REFERENCES B(b_id)
        DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE B (
    b_id INT PRIMARY KEY,
    a_id INT,
    CONSTRAINT fkBA
        FOREIGN KEY (a_id) REFERENCES A(a_id)
);

BEGIN;

INSERT INTO A (a_id, b_id) VALUES (1, NULL);
INSERT INTO B (b_id, a_id) VALUES (1, 1);
UPDATE A
SET b_id = 1
WHERE a_id = 1;

COMMIT;

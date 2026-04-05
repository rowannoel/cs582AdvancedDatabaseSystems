-- HW8 - Problem 4: Assertions

-- Enforce that the total payroll across Staff never exceeds $10,000,000.
CREATE ASSERTION totalMonthlyPayCap
CHECK (
    (SELECT SUM(salary) FROM Staff) <= 10000000
);

-- Example success case: total remains under the cap
INSERT INTO Staff (staff_id, name, role, hire_date, salary)
VALUES (1, 'Alicia', 'Manager', '2020-02-01', 5000000);

INSERT INTO Staff (staff_id, name, role, hire_date, salary)
VALUES (2, 'Bren', 'Engineer', '2021-05-10', 4000000);

-- Example violation: total would exceed the cap
INSERT INTO Staff (staff_id, name, role, hire_date, salary)
VALUES (3, 'Cara', 'Analyst', '2022-06-15', 2000000);

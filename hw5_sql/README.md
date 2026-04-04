# SQL Querying and Data Modification

This project demonstrates core SQL operations including querying, aggregation, joins, and data modification.

## Schema

The following schema was used:

- Students(student_id, name, major, start_year)
- Instructors(instr_id, name, dept, hire_year, salary)
- Courses(course_id, title, dept, credits)
- Sections(section_id, course_id, term, year, instr_id)
- Enrollments(student_id, section_id, grade)

---

## Problem 1: SQL Queries

### (a)
List the names and majors of students who started in or after 2023, ordered alphabetically by name.

### (b)
List all course titles and their departments for courses worth three or more credits.

### (c)
For each department, show how many distinct courses it offers and the average number of credits.

### (d)
Find the names of instructors who taught only a single section in Fall 2024.

### (e)
Find the names of students who have enrolled in a section taught by Dr. Kim.

### (f)
Find instructors whose salary is greater than all instructors in the Math department.

---

## Problem 2: SQL Modifications

### (a)
Insert a new course in the CS department.

### (b)
Insert a new section for that course in Fall 2025.

### (c)
Enroll a student into that section.

### (d)
Increase salaries of CS instructors hired before 2020 by 5%.

### (e)
Delete enrollments with NULL grades for sections before 2023.

---

## Key Concepts

- Filtering and sorting (WHERE, ORDER BY)
- Aggregation (COUNT, AVG)
- Grouping and HAVING
- Joins and multi-table queries
- Subqueries
- Data modification (INSERT, UPDATE, DELETE)

---

## Files

- `queries.sql` — SELECT queries
- `modifications.sql` — INSERT, UPDATE, DELETE statements

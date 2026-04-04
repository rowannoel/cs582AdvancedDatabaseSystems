-- Problem 2: Modifications

-- (a)
INSERT INTO Courses (course_id, title, dept, credits)
VALUES ('270', 'Intro to Database Systems', 'CS', 4);

-- (b)
INSERT INTO Sections (section_id, course_id, term, year, instr_id)
VALUES ('800', '270', 'Fall', 2025, '123');

-- (c)
INSERT INTO Enrollments (student_id, section_id, grade)
VALUES ('456', '800', NULL);

-- (d)
UPDATE Instructors
SET salary = salary * 1.05
WHERE dept = 'CS' AND hire_year < 2020;

-- (e)
DELETE FROM Enrollments
WHERE grade IS NULL
  AND section_id IN (
      SELECT section_id
      FROM Sections
      WHERE year < 2023
  );

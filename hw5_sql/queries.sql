-- Problem 1: Queries

-- (a)
SELECT name, major
FROM Students
WHERE start_year >= 2023
ORDER BY name ASC;

-- (b)
SELECT title, dept
FROM Courses
WHERE credits >= 3;

-- (c)
SELECT dept,
       COUNT(DISTINCT course_id) AS num_courses,
       AVG(credits) AS avg_credits
FROM Courses
GROUP BY dept;

-- (d)
SELECT inst.name
FROM Instructors inst
JOIN Sections secs ON inst.instr_id = secs.instr_id
WHERE secs.term = 'Fall' AND secs.year = 2024
GROUP BY inst.instr_id, inst.name
HAVING COUNT(secs.section_id) = 1;

-- (e)
SELECT DISTINCT stud.name
FROM Students stud, Enrollments enroll, Sections sec, Instructors inst
WHERE stud.student_id = enroll.student_id
  AND enroll.section_id = sec.section_id
  AND sec.instr_id = inst.instr_id
  AND inst.name = 'Dr. Kim';

-- (f)
SELECT name
FROM Instructors
WHERE salary > ALL (
    SELECT salary
    FROM Instructors
    WHERE dept = 'Math'
);

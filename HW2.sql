DROP DATABASE HW2;

CREATE DATABASE HW2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE HW2;


CREATE TABLE Students (
student_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
major VARCHAR(50)
);

CREATE TABLE Enrollments (
enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT,
course VARCHAR(50),
FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students (name, major) VALUES ('Mathew','Math'),('Emily','CS'),('Bob','Math'),
('Cassy','English'),('Stacy','CS');
INSERT INTO Enrollments (student_id, course) VALUES 
((select student_id from Students where name = 'Mathew'), 'MA101'), ((select student_id from Students where name = 'Mathew'), 'MA120'),
((select student_id from Students where name = 'Emily'), 'Database Systems'), ((select student_id from Students where name = 'Bob'), 'MA201'),
((select student_id from Students where name = 'Stacy'), 'CS120');

SELECT * FROM Students;
SELECT * FROM Students WHERE student_id = 2;
SELECT * from Enrollments WHERE course = 'Database Systems';

INSERT INTO Enrollments (student_id, course) VALUES
(999, 'CS444');
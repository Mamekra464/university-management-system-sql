-- Part 2: Create the Database
-- 1. Create the database
CREATE DATABASE UniversityManagement;
USE UniversityManagement;

-- 2.Define Tables
-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE,
    HeadOfDepartment VARCHAR (100),
);

-- Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
	LastName VARCHAR(50),
    DOB DATE NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
);

-- Create Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(100),
    Credits INT CHECK (Credits BETWEEN 1and 6),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
);

-- Create Faculty table
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(100),
    Designation VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade DECIMAL(3,2) CHECK (Grade BETWEEN 0.00 AND 4.00),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Create Library table
CREATE TABLE Library (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200),
    Author VARCHAR(100),
    BorrowerID INT,
    DueDate DATE,
    FOREIGN KEY (BorrowerID) REFERENCES Students(StudentID)
        ON DELETE SET NULL
);

-- Create indexes for optimization
CREATE NONCLUSTERED INDEX idx_students_lastname ON Students(LastName);

-- Non-clustered index on Courses' CourseName
CREATE NONCLUSTERED INDEX idx_courses_name ON Courses(CourseName);

-- Composite index for join optimization on Enrollments
CREATE INDEX idx_enrollments_student_course ON Enrollments(StudentID, CourseID);

-- Part 3: Populate tables
-- Populate Detpartments table
INSERT INTO Departments (DepartmentName, HeadOfDepartment) VALUES
('Computer Science', 'Dr. Alice Johnson'),
('Electrical Engineering', 'Dr. Bob Smith'),
('Mechanical Engineering', 'Dr. Carol Lee'),
('Mathematics', 'Dr. Dan Brown'),
('Business Administration', 'Dr. Eva Green'),
('Physics', 'Dr. Frank White'),
('Civil Engineering', 'Dr. Grace Liu'),
('Environmental Science', 'Dr. Henry Kim'),
('Economics', 'Dr. Irene Wang'),
('Chemistry', 'Dr. Jack Black');
SELECT * FROM Departments;

--Populate Students table
INSERT INTO Students (StudentID, FirstName, LastName, DOB, DepartmentID) VALUES
(101, 'John', 'Doe', '2001-05-21', 1),
(102, 'Emma', 'Smith', '2000-11-10', 2),
(103, 'Liam', 'Brown', '2002-03-14', 3),
(104, 'Olivia', 'Jones', '2001-07-23', 1),
(105, 'Noah', 'Garcia', '2000-02-01', 4),
(106, 'Ava', 'Martinez', '2002-09-15', 5),
(107, 'William', 'Davis', '1999-12-30', 6),
(108, 'Sophia', 'Lopez', '2003-04-10', 7),
(109, 'James', 'Wilson', '2001-06-28', 8),
(110, 'Isabella', 'Anderson', '2000-08-05', 9);
SELECT * FROM Students

-- Populate table Courses
INSERT INTO Courses (CourseID, CourseName, Credits, DepartmentID) VALUES
(301, 'Intro to Programming', 3, 1),
(302, 'Data Structures', 4, 1),
(303, 'Circuit Theory', 3, 2),
(304, 'Thermodynamics', 3, 3),
(305, 'Linear Algebra', 4, 4),
(306, 'Marketing Principles', 3, 5),
(307, 'Quantum Physics', 4, 6),
(308, 'Structural Analysis', 3, 7),
(309, 'Climate Change', 2, 8),
(310, 'Microeconomics', 3, 9);
SELECT * FROM Courses;

-- Popilate table Faculty
INSERT INTO Faculty (FacultyID, FacultyName, Designation, DepartmentID) VALUES
(201, 'Johnson', 'Professor', 1),
(202, 'Smith', 'Lecturer', 2),
(203, 'Lee', 'Associate Professor', 3),
(204, 'Brown', 'Lecturer', 4),
(205, 'Green', 'Professor', 5),
(206, 'White', 'Assistant Professor', 6),
(207, 'Liu', 'Lecturer', 7),
(208, 'Kim', 'Professor', 8),
(209, 'Wang', 'Lecturer', 9),
(210, 'Black', 'Assistant Professor', 10);
SELECT * FROM Faculty;

--Populate Enrollments table
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(401, 101, 301, 3.5),
(402, 102, 303, 3.7),
(403, 103, 304, 3.2),
(404, 104, 302, 3.9),
(405, 105, 305, 3.6),
(406, 106, 306, 3.1),
(407, 107, 307, 2.8),
(408, 108, 308, 3.4),
(409, 109, 309, 3.3),
(410, 110, 310, 3.0);
SELECT * FROM Enrollments;

-- Populate Library tabe
INSERT INTO Library (BookID, Title, Author, BorrowerID, DueDate) VALUES
(501, 'Database Systems', 'Elmasri & Navathe', 101, '2025-04-10'),
(502, 'Clean Code', 'Robert C. Martin', 104, '2025-04-08'),
(503, 'Digital Circuits', 'Morris Mano', 102, '2025-04-05'),
(504, 'Thermal Engineering', 'R.K. Rajput', 103, '2025-04-12'),
(505, 'Business Basics', 'Kotler', 106, '2025-04-11'),
(506, 'Quantum Mechanics', 'Griffiths', 107, NULL),
(507, 'Civil Engineering Materials', 'Neville', 108, NULL),
(508, 'Environmental Policies', 'Jane Goodall', 109, '2025-04-09'),
(509, 'Economic Theory', 'Samuelson', 110, NULL),
(510, 'Organic Chemistry', 'Solomons', NULL, NULL);
SELECT * FROM Library;

-- Part 4: Data Manipulation
-- 1.Basic CRUD Operations
-- Add a new student
INSERT INTO Students (StudentID, FirstName, LastName, DOB, DepartmentID)
VALUES (111, 'Mia', 'Turner', '2002-10-01', 1);

-- Add a new course
INSERT INTO Courses (CourseID, CourseName, Credits, DepartmentID)
VALUES (311, 'Web Development', 3, 1);

-- Add a new faculty member
INSERT INTO Faculty (FacultyID, FacultyName, Designation, DepartmentID)
VALUES (211, 'Parker', 'Lecturer', 1);

-- Update a student's department
UPDATE Students SET DepartmentID = 2 WHERE StudentID = 111;

-- Update a course's credits
UPDATE Courses SET Credits = 4 WHERE CourseID = 311;

-- Delete a faculty member
DELETE FROM Faculty WHERE FacultyID = 210;

-- 2.Complex Queries:
-- The list of all students enrolled in a specific course.
SELECT S.FirstName, S.LastName, C.CourseName, E.Grade
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseID = 301;

-- The department-wise count of students.
SELECT D.DepartmentName, COUNT(S.StudentID) AS StudentCount
FROM Departments D
LEFT JOIN Students S ON D.DepartmentID = S.DepartmentID
GROUP BY D.DepartmentName;

-- The details of books borrowed by students in a specific department
SELECT S.FirstName, S.LastName, D.DepartmentName, L.Title, L.Author, L.DueDate
FROM Library L
JOIN Students S ON L.BorrowerID = S.StudentID
JOIN Departments D ON S.DepartmentID = D.DepartmentID
WHERE D.DepartmentID = 1;

-- The top 3 students with the highest GPA.
SELECT TOP 3 S.FirstName, S.LastName, AVG(E.Grade) AS GPA
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
GROUP BY S.StudentID, S.FirstName, S.LastName
ORDER BY GPA DESC;

-- The faculty members teaching the most courses.
-- Create CourseFaculty table
CREATE TABLE CourseFaculty (
    CourseFacultyID INT PRIMARY KEY,
    FacultyID INT,
    CourseID INT,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
INSERT INTO CourseFaculty (CourseFacultyID, FacultyID, CourseID) VALUES
(1, 201, 301),  
(2, 202, 302),  
(3, 203, 303),  
(4, 204, 304),  
(5, 205, 305),  
(6, 206, 306),  
(7, 207, 307),  
(8, 208, 308),  
(9, 209, 309),  
(11, 211, 311); 

SELECT TOP 3 F.FacultyName, COUNT(CF.CourseID) AS TotalCourses
FROM Faculty F
JOIN CourseFaculty CF ON F.FacultyID = CF.FacultyID
GROUP BY F.FacultyID, F.FacultyName
ORDER BY TotalCourses DESC;

-- Part 5: Views and Stored Procedures
-- Create a view to show student enrollments with course details (e.g., StudentName, CourseName, Grade).
CREATE VIEW vw_StudentEnrollments AS
SELECT 
    S.StudentID,
    CONCAT(S.FirstName, ' ', S.LastName) AS StudentName,
    C.CourseName,
    E.Grade
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;

--	Create a view to display faculty details along with the courses they teach.
CREATE VIEW vw_FacultyCourses AS
SELECT 
    F.FacultyID,
    F.FacultyName,
    C.CourseName
FROM CourseFaculty CF
JOIN Faculty F ON CF.FacultyID = F.FacultyID
JOIN Courses C ON CF.CourseID = C.CourseID;

-- Write a stored procedure to add a new student and enroll them in multiple courses.
DROP PROCEDURE sp_AddStudentAndEnroll;
CREATE PROCEDURE sp_AddStudentAndEnroll
    @StudentID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DOB DATE,
	@DepartmentID INT,
    @Course1ID INT,
    @Course2ID INT
AS
BEGIN
    -- Add student
    INSERT INTO Students (StudentID, FirstName, LastName, DOB)
    VALUES (@StudentID, @FirstName, @LastName, @DOB);

    -- Enroll in two courses
    INSERT INTO Enrollments (StudentID, CourseID, Grade)
    VALUES 
        (@StudentID, @Course1ID, NULL),
        (@StudentID, @Course2ID, NULL);
END;

-- Write a stored procedure to calculate the average grade for a course
CREATE PROCEDURE sp_AverageGradeForCourse
    @CourseID INT
AS
BEGIN
    SELECT 
        C.CourseName,
        AVG(E.Grade) AS AverageGrade
    FROM Enrollments E
    JOIN Courses C ON E.CourseID = C.CourseID
    WHERE E.CourseID = @CourseID
    GROUP BY C.CourseName;
END;

-- Part 6: Query Optimization
-- Rewrite non-SARGable queries to ensure optimal index usage
--non-SARGable queries
SELECT * FROM Students WHERE YEAR(DOB) = 2002;
-- to make it sarable
SELECT * FROM Students
WHERE DOB >= '2002-01-01' AND DOB < '2003-01-01';

-- 2. Index Analysis
CREATE NONCLUSTERED INDEX IX_Students_DepartmentID
ON Students (DepartmentID);

CREATE NONCLUSTERED INDEX IX_Enrollments_CourseID
ON Enrollments (CourseID);

-- Part 7: Concurrency and Transactions
-- 1.	Simulate Concurrency:
-- Create a scenario where two students try to borrow the same book at the same time.
-- Insert sample data into Library table
INSERT INTO Library (BookID, Title, Author, BorrowerID, DueDate)
VALUES (1, 'SQL for Beginners', 'John Doe', NULL, NULL);  -- Book is available (no borrower yet)
-- Insert Alice (StudentID = 1001)
INSERT INTO Students (StudentID, FirstName, DOB, DepartmentID)
VALUES (1001, 'Alice', '1995-05-15', 1);  -- Example data

-- Insert Bob (StudentID = 1002)
INSERT INTO Students (StudentID, FirstName, DOB, DepartmentID)
VALUES (1002, 'Bob', '1994-04-10', 2);  -- Example data

-- Alice borrows the book (StudentID = 1001)
BEGIN TRANSACTION;

UPDATE Library
SET BorrowerID = 1001,  -- Alice's StudentID
    DueDate = DATEADD(DAY, 14, GETDATE())  -- Set due date to 14 days from today
WHERE BookID = 1 AND BorrowerID IS NULL;

COMMIT;

-- Bob attempts to borrow the book (StudentID = 1002)
BEGIN TRANSACTION;

UPDATE Library
SET BorrowerID = 1002,  -- Bob's StudentID
    DueDate = DATEADD(DAY, 14, GETDATE())  -- Set due date to 14 days from today
WHERE BookID = 1 AND BorrowerID IS NULL;

COMMIT;

-- Implement transaction isolation levels to prevent concurrency issues.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

UPDATE Library
SET BorrowerID = 1001,  -- Alice's StudentID
    DueDate = DATEADD(DAY, 14, GETDATE())  -- Set due date
WHERE BookID = 1 AND BorrowerID IS NULL;

COMMIT;

-- Add cascade on DELETE for the DepartmentID in Faculty table
ALTER TABLE Faculty
ADD CONSTRAINT FK_Faculty_Departments
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
ON DELETE CASCADE;


-- Simulate Alice borrowing the book
BEGIN TRANSACTION;

-- Check if the book is available (BorrowerID should be NULL)
SELECT BorrowerID FROM Library WHERE BookID = 1;

-- If the book is available, Alice borrows it
UPDATE Library
SET BorrowerID = 1001,  -- Alice's StudentID
    DueDate = DATEADD(DAY, 14, GETDATE())  -- Set due date to 14 days from today
WHERE BookID = 1 AND BorrowerID IS NULL;

-- Commit Alice's transaction
COMMIT;

-- Check if Alice's and Bob's StudentID exist in the Students table
SELECT StudentID, FirstName FROM Students WHERE StudentID IN (1001, 1002);

--Part 8: Reporting and Analytics
-- 1.	Generate Reports:
-- list of students with overdue books.
SELECT s.StudentID, s.FirstName, s.LastName, l.BookID, l.Title, l.DueDate
FROM Library l
JOIN Students s ON l.BorrowerID = s.StudentID
WHERE l.DueDate < GETDATE() AND l.BorrowerID IS NOT NULL;

-- summary report of department-wise course enrollments.
SELECT d.DepartmentName, COUNT(e.StudentID) AS NumberOfEnrollments
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Departments d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY NumberOfEnrollments DESC;

--ranking of students by GPA, grouped by department.

WITH StudentGPAs AS (
    SELECT 
        s.StudentID,
        s.FirstName,
		s.LastName,
        d.DepartmentName,
        AVG(e.Grade) AS GPA,
        COUNT(e.EnrollmentID) AS CoursesCompleted
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    JOIN Departments d ON s.DepartmentID = d.DepartmentID
    WHERE e.Grade IS NOT NULL
    GROUP BY s.StudentID, s.FirstName, s.LastName, d.DepartmentName
    HAVING COUNT(e.EnrollmentID) >= 3
)
SELECT 
    StudentID,
    FirstName,
	LastName,
    DepartmentName,
    GPA,
    CoursesCompleted,
    RANK() OVER (PARTITION BY DepartmentName ORDER BY GPA DESC) AS DepartmentRank,
    RANK() OVER (ORDER BY GPA DESC) AS UniversityRank
FROM StudentGPAs
ORDER BY DepartmentName, GPA DESC;



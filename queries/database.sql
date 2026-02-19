CREATE TABLE Student (
    StudentId INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE Club(
    ClubName VARCHAR(100) PRIMARY KEY,
    ClubRoom VARCHAR(20) NOT NULL,
    ClubMentor VARCHAR(100) NOT NUmm
);


CREATE TABLE Membership(
    StudentId INT NOT NULL,
    ClubName VARCHAR(100) NOT NULL,
    JoinDate  DATE NOT NULL,
    PRIMARY KEY (StudentID, ClubName),               
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ClubName)  REFERENCES Club(ClubName)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


INSERT INTO Student (StudentID, StudentName, Email) VALUES
(1, 'Asha',   'asha@email.com'),
(2, 'Bikash', 'bikash@email.com'),
(3, 'Nisha',  'nisha@email.com'),
(4, 'Rohan',  'rohan@email.com'),
(5, 'Suman',  'suman@email.com'),
(6, 'Pooja',  'pooja@email.com'),
(7, 'Aman',   'aman@email.com');


INSERT INTO Club (ClubName, ClubRoom, ClubMentor) VALUES
('Music Club',   'R101', 'Mr. Raman'),
('Sports Club',  'R202', 'Ms. Sita'),
('Drama Club',   'R303', 'Mr. Kiran'),
('Coding Club',  'Lab1', 'Mr. Anil');


INSERT INTO Membership (StudentID, ClubName, JoinDate) VALUES
(1, 'Music Club',   '2024-01-10'),   
(1, 'Sports Club',  '2024-01-12'),   
(2, 'Music Club',   '2024-01-15'),   
(3, 'Sports Club',  '2024-01-27'),   
(4, 'Drama Club',   '2024-01-18'),   
(5, 'Drama Club',   '2024-01-22'),  
(5, 'Sports Club',  '2024-01-25'),   
(6, 'Sports Club',  '2024-01-27'),   
(7, 'Coding Club',  '2024-01-30');   

SELECT * FROM Student;

SELECT * FROM Club;


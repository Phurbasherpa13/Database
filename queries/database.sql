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
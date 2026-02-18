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

-- Clean up previous run to avoid errors
DROP DATABASE IF EXISTS club_db;
CREATE DATABASE club_db;
USE club_db;

-- STEP 1: RAW DATA (UNNORMALIZED)
CREATE TABLE RawData (
    StudentID INT,
    StudentName VARCHAR(100),
    Email VARCHAR(100),
    ClubName VARCHAR(100),
    ClubRoom VARCHAR(50),
    ClubMentor VARCHAR(100),
    JoinDate VARCHAR(20)
);

INSERT INTO RawData VALUES
(1, 'Asha', 'asha@email.com', 'Music Club', 'R101', 'Mr. Raman', '1/10/2024'),
(2, 'Bikash', 'bikash@email.com', 'Sports Club', 'R202', 'Ms. Sita', '1/12/2024'),
(1, 'Asha', 'asha@email.com', 'Sports Club', 'R202', 'Ms. Sita', '1/15/2024'),
(3, 'Nisha', 'nisha@email.com', 'Music Club', 'R101', 'Mr. Raman', '1/20/2024'),
(4, 'Rohan', 'rohan@email.com', 'Drama Club', 'R303', 'Mr. Kiran', '1/18/2024'),
(5, 'Suman', 'suman@email.com', 'Music Club', 'R101', 'Mr. Raman', '1/22/2024'),
(2, 'Bikash', 'bikash@email.com', 'Drama Club', 'R303', 'Mr. Kiran', '1/25/2024'),
(6, 'Pooja', 'pooja@email.com', 'Sports Club', 'R202', 'Ms. Sita', '1/27/2024'),
(3, 'Nisha', 'nisha@email.com', 'Coding Club', 'Lab1', 'Mr. Anil', '1/28/2024'),
(7, 'Aman', 'aman@email.com', 'Coding Club', 'Lab1', 'Mr. Anil', '1/30/2024');

-- STEP 2: SECOND NORMAL FORM (2NF)
-- Separate Students from Club details
CREATE TABLE Students_2NF AS 
SELECT DISTINCT StudentID, StudentName, Email FROM RawData;

-- Separate Club details (Mentor is still here in 2NF)
CREATE TABLE Clubs_2NF AS 
SELECT DISTINCT ClubName, ClubRoom, ClubMentor FROM RawData;

-- FIX: Create the missing Memberships_2NF table
-- This links Students to Clubs and converts the string date to a real DATE format
CREATE TABLE Memberships_2NF AS
SELECT 
    StudentID, 
    ClubName, 
    STR_TO_DATE(JoinDate, '%m/%d/%Y') as JoinDate 
FROM RawData;

-- STEP 3: THIRD NORMAL FORM (3NF)
-- Separate Mentors from Clubs to remove transitive dependency

CREATE TABLE Mentors_3NF (
    MentorID INT AUTO_INCREMENT PRIMARY KEY,
    MentorName VARCHAR(100) UNIQUE
);

INSERT INTO Mentors_3NF (MentorName) 
SELECT DISTINCT ClubMentor FROM Clubs_2NF;

CREATE TABLE Clubs_3NF (
    ClubID INT AUTO_INCREMENT PRIMARY KEY,
    ClubName VARCHAR(100),
    ClubRoom VARCHAR(50),
    MentorID INT,
    FOREIGN KEY (MentorID) REFERENCES Mentors_3NF(MentorID)
);

INSERT INTO Clubs_3NF (ClubName, ClubRoom, MentorID)
SELECT c.ClubName, c.ClubRoom, m.MentorID 
FROM Clubs_2NF c 
JOIN Mentors_3NF m ON c.ClubMentor = m.MentorName;

-- Create final Memberships table linking IDs
CREATE TABLE Memberships_3NF AS 
SELECT m.StudentID, c.ClubID, m.JoinDate
FROM Memberships_2NF m
JOIN Clubs_3NF c ON m.ClubName = c.ClubName;
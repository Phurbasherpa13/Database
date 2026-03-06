# College Club Membership Management

Normalized database schema for managing students, clubs, and memberships in 3rd Normal Form (3NF).

## Overview

- **STUDENT** (StudentID OK, StudentName, Email, CreatedAt)
- **CLUB**(ClubID PK, ClubName UNIQUE, ClubRoom, ClubMentor, CreatedAt)
- **MEMBERSHIP**(StudentID FK → STUDENT, ClubID FK → CLUB → JoinDate)
- **PK(StudentID, ClubID)**


**Relationships**
- Many-to-many between Student and Club, resolved by Membership (associative entity).
- `ON DELETE CASCADE`on both FKs to avoid orphaned memberships.

## Getting Started

### Requirements
- MySQL 8.0+ (InnoDB, foreign keys)
- Docker


## Normalization
``` bash
CREATE DATABASE IF NOT EXISTS club_db;
# and check wheather it is lissted
show databases;
```
- Expected result
<img src="/images/image.png" height="300" width="300">


- Create the table where every pirce of information is contained in a single table 
```bash
USE club_db;
 CREATE TABLE RawData (
    ->     StudentID INT,
    ->     StudentName VARCHAR(100),
    ->     Email VARCHAR(100),
    ->     ClubName VARCHAR(100),
    ->     ClubRoom VARCHAR(50),
    ->     ClubMentor VARCHAR(100),
    ->     JoinDate VARCHAR(20)
    -> );

#After creating the table now insert all the student info in it 
 INSERT INTO RawData VALUES
    -> (1, 'Asha', 'asha@email.com', 'Music Club', 'R101', 'Mr. Raman','1/10/2024'),
    -> (2, 'Bikash', 'bikash@email.com', 'Sports Club', 'R202', 'Ms. Sita', '1/12/2024'),
    -> (1, 'Asha', 'asha@email.com', 'Sports Club', 'R202', 'Ms. Sita', '1/15/2024'),
    -> (3, 'Nisha', 'nisha@email.com', 'Music Club', 'R101', 'Mr. Raman', '1/20/2024'),
    -> (4, 'Rohan', 'rohan@email.com', 'Drama Club', 'R303', 'Mr. Kiran', '1/18/2024'),
    -> (5, 'Suman', 'suman@email.com', 'Music Club', 'R101', 'Mr. Raman', '1/22/2024'),
    -> (2, 'Bikash', 'bikash@email.com', 'Drama Club', 'R303', 'Mr. Kiran', '1/25/2024'),
    -> (6, 'Pooja', 'pooja@email.com', 'Sports Club', 'R202', 'Ms. Sita', '1/27/2024'),
    -> (3, 'Nisha', 'nisha@email.com', 'Coding Club', 'Lab1', 'Mr. Anil', '1/28/2024'),
    -> (7, 'Aman', 'aman@email.com', 'Coding Club', 'Lab1', 'Mr. Anil', '1/30/2024');
```
- Result 
```bash
 SELECT * FROM RawData;
``` 
<img src="/images/image-1.png" height="300" width="400">

#### 2NF
Lets elimate the partial functinal dependencies to execute 2NF. Lets seprate the table for Memberships, Clubs and Students.
 - Memberships database
```bash
CREATE TABLE Memberships_2NF AS
    -> SELECT
    ->     StudentID,
    ->     ClubName,
    ->     STR_TO_DATE(JoinDate, '%m/%d/%Y') as JoinDate
    -> FROM RawData;
 # Too see the result
 SELECT * FROM Memberships_2NF;
 ```

 <img src="/images/image-2.png" height="300" width="400">

- Student database
```bash
CREATE TABLE Students_2NF AS
    -> SELECT DISTINCT StudentID, StudentName, Email FROM RawData;

#Result 
Select * FROM Students_2NF;
```
<img src="/images/image-3.png" height="300" width="300">

- Club database
```bash
CREATE TABLE Clubs_2NF AS
    -> SELECT DISTINCT ClubName, ClubRoom, ClubMentor FROM RawData; 

#Result 
Select * FROM Clubs_2NF;
```
<img src="/images/image-4.png" height="300" width="300">

#### 3NF
After the 2NF, the ClubRoom and ClubMentor are still tied to the CLubName. However, a Transitive Dependency exists if a mentor's details depend on the club rather than the student. In 3NF, we move the Mentor into their own table.
```bash 
-- STEP 3: THIRD NORMAL FORM (3NF)

-- 3a. Mentors Table (Separating Mentor from Club)
CREATE TABLE Mentors_3NF (
    MentorID INT AUTO_INCREMENT PRIMARY KEY,
    MentorName VARCHAR(100) UNIQUE
);

INSERT INTO Mentors_3NF (MentorName) 
SELECT DISTINCT ClubMentor FROM Clubs_2NF;

-- 3b. Final Clubs Table (Foreign key to Mentors)
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

-- 3c. Final Memberships (Linking Students and Clubs)
CREATE TABLE Memberships_3NF AS 
SELECT m.StudentID, c.ClubID, m.JoinDate
FROM Memberships_2NF m
JOIN Clubs_3NF c ON m.ClubName = c.ClubName;
```

- Database for mentors
```bash
#reuslt
SELECT * FROM Mentors_3NF;
```
<img src="/images/image-5.png" height="300" width="300">
- Database for Membership
```bash
#result 
SELECT * FROM Memberships_3NF;
```
<img src="/images/image-6.png" height="300" width="300">

- Database for Club
```bash
SELECT * FROM Clubs_3NF;
```
<img src="/images/image-7.png" height="300" width="300">

## ER diagram
It shows the relation of the database through ER diagram
<img src="/images/image-8.png" height="300" width="300">

#### Basic Operation
To verify the integrity of our 3NF schema, we perform standard CRUD (Create, Read, Update, Delete) operations.
**Lets insert a new student.**

```bash
# To insert a new student in 2NF
 INSERT INTO Students_2NF (StudentID, StudentName, Email) VALUES (9, 'Shreejan', 'shreejan_2@gmail.com');
``` 
- Result 
```bash
 SELECT * FROM Students_2NF;
```
<img src="/images/image-9.png" height="300" width="300">

As we can we we inserted a new student successfully and now lets add a new club.

**Inserting a new club**
```bash
 INSERT INTO Mentors_3NF (MentorID, MentorName)
    -> VALUES (5, 'Name of Mentor');
#after this insert 
INSERT INTO Clubs_3NF (ClubID, ClubName, ClubRoom, MentorID)
    -> VALUES (5, 'Dance Club', 'R105', 5);
```
- Result 
```bash
SELECT * FROM Clubs_3NF;
```
<img src="/images/image-10.png" height="300" width="300">
 
As we can see from the above, we have inserted sucessfully into students and also inserted a new club.

#### Join Operation
All three tables will be joined here, and only StudentName, ClubName, and JoinDate will be displayed. This table then looks like this:
<img src="/images/image-11.png" height="300" width="300">


# Quck Start
```bash 
#clone the repo of this git hub
git clone https://github.com/Phurbasherpa13/Database.git
cd Database
```
# Licence
This project is for education purpose. You can use it.
# Author 
- Phurba Sherpa

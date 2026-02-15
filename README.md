**College Club Membership Management (MySQL, 3NF)**

Normalized database schema for managing students, clubs, and memberships in 3rd Normal Form (3NF).

**Overview**

**STUDENT** (StudentID OK, StudentName, Email, CreatedAt)
**CLUB**(ClubID PK, ClubName UNIQUE, ClubRoom, ClubMentor, CreatedAt)
**MEMBERSHIP**(StudentID FK → STUDENT, ClubID FK → CLUB → JoinDate, **PK(StudentID, ClubID)**)

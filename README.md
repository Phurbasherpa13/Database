###****College Club Membership Management (MySQL, 3NF)****

Normalized database schema for managing students, clubs, and memberships in 3rd Normal Form (3NF).

###****Overview****

**STUDENT** (StudentID OK, StudentName, Email, CreatedAt)
**CLUB**(ClubID PK, ClubName UNIQUE, ClubRoom, ClubMentor, CreatedAt)
**MEMBERSHIP**(StudentID FK → STUDENT, ClubID FK → CLUB → JoinDate, **PK(StudentID, ClubID)**)


**Relationships**
- Many-to-many between Student and Club, resolved by Membership (associative entity).
- `ON DELETE CASCADE`on both FKs to avoid orphaned memberships.

## Getting Started

### Requirements
- MySQL 8.0+ (InnoDB, foreign keys)
- Docker


### Run with MySQL CLI
```bash
# 1) Create DB
mysql -u root -p < sql/01_create_database.sql

# 2) Create tables
mysql -u root -p college_clubs < sql/02_create_tables.sql

# 3) Insert sample data
mysql -u root -p college_clubs < sql/03_insert_sample_data.sql

# 4) Run verification queries (optional)
mysql -u root -p college_clubs < sql/04_verification_queries.sql

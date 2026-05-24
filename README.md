# ISC329(dbms)
DBMS class project: JobConnect is a robust relational database system designed to manage recruitment data within the United States market. While originally conceptualized to support a web-based platform, the core of this project is a backend architecture that manages the complex relationships between Employers, Recruiters, and Job Seekers. The system provides a structured environment for:  
● Company Management: Tracking employers and their assigned recruiters.

● Talent Profiling: Storing comprehensive seeker data, including education history, multi-version resumes, and specific technical skills.

● Recruitment Workflow: Facilitating job postings with granular requirements and tracking the lifecycle of every application from submission to hire.

Project Accomplishments
The project successfully progressed from a narrative problem statement to a high-performance relational model. Key achievements include:   
● Database Schema Design: We developed a sophisticated relational schema that handles the "one-to-many" and "many-to-many" relationships typical of a professional
hiring network.

● Advanced Normalization (BCNF): We moved beyond simple table structures to achieve Boyce-Codd Normal Form. By decomposing the original "User" and "JobListing" entities,
we eliminated data redundancy and update anomalies.

● SQL Logic Implementation: We successfully wrote and executed the DDL (Data Definition Language) to build the schema and developed complex queries to extract
business intelligence (e.g., matching applicant skills to job requirements).

● Data Integrity Enforcement: Through the use of primary keys, foreign keys, and unique constraints, the database ensures that no user can apply to the same job twice and that
all records remain linked to valid parent entities.

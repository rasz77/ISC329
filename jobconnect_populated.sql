PRAGMA foreign_keys = OFF;

-- Drop tables if they exist
DROP TABLE IF EXISTS resume;
DROP TABLE IF EXISTS application;
DROP TABLE IF EXISTS job_experience_required;
DROP TABLE IF EXISTS job_skill_required;
DROP TABLE IF EXISTS joblisting;
DROP TABLE IF EXISTS recruiter;
DROP TABLE IF EXISTS employer;
DROP TABLE IF EXISTS user_skill;
DROP TABLE IF EXISTS skill;
DROP TABLE IF EXISTS user_workexperience;
DROP TABLE IF EXISTS user_education;
DROP TABLE IF EXISTS user;

-- Create tables
CREATE TABLE user (
    userid INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE,
    fullname TEXT,
    email TEXT UNIQUE,
    phonenumber TEXT
);

CREATE TABLE user_education (
    educationid INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER NOT NULL,
    institution TEXT,
    degree TEXT,
    fieldofstudy TEXT,
    startdate TEXT,
    enddate TEXT,
    FOREIGN KEY (userid) REFERENCES user(userid)
);

CREATE TABLE user_workexperience (
    experienceid INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER NOT NULL,
    companyname TEXT,
    jobtitle TEXT,
    startdate TEXT,
    enddate TEXT,
    description TEXT,
    FOREIGN KEY (userid) REFERENCES user(userid)
);

CREATE TABLE skill (
    skillid INTEGER PRIMARY KEY AUTOINCREMENT,
    skillname TEXT UNIQUE
);

CREATE TABLE user_skill (
    userid INTEGER NOT NULL,
    skillid INTEGER NOT NULL,
    PRIMARY KEY (userid, skillid),
    FOREIGN KEY (userid) REFERENCES user(userid),
    FOREIGN KEY (skillid) REFERENCES skill(skillid)
);

CREATE TABLE employer (
    employerid INTEGER PRIMARY KEY AUTOINCREMENT,
    companyname TEXT,
    industry TEXT,
    companyemail TEXT UNIQUE,
    phonenumber TEXT,
    address TEXT
);

CREATE TABLE recruiter (
    recruiterid INTEGER PRIMARY KEY AUTOINCREMENT,
    employerid INTEGER NOT NULL,
    recruitername TEXT,
    recruiterphone TEXT,
    recruiteraddress TEXT,
    FOREIGN KEY (employerid) REFERENCES employer(employerid)
);

CREATE TABLE joblisting (
    jobid INTEGER PRIMARY KEY AUTOINCREMENT,
    recruiterid INTEGER NOT NULL,
    jobtitle TEXT,
    jobdescription TEXT,
    employmenttype TEXT,
    salary INTEGER,
    dateposted TEXT,
    applicationdeadline TEXT,
    listingstatus TEXT,
    FOREIGN KEY (recruiterid) REFERENCES recruiter(recruiterid)
);

CREATE TABLE job_skill_required (
    jobid INTEGER NOT NULL,
    skillid INTEGER NOT NULL,
    PRIMARY KEY (jobid, skillid),
    FOREIGN KEY (jobid) REFERENCES joblisting(jobid),
    FOREIGN KEY (skillid) REFERENCES skill(skillid)
);

CREATE TABLE job_experience_required (
    jobexpreqid INTEGER PRIMARY KEY AUTOINCREMENT,
    jobid INTEGER NOT NULL,
    requiredtitle TEXT,
    minyears INTEGER,
    description TEXT,
    FOREIGN KEY (jobid) REFERENCES joblisting(jobid)
);

CREATE TABLE application (
    applicationid INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER NOT NULL,
    jobid INTEGER NOT NULL,
    applicationdate TEXT,
    applicationstatus TEXT,
    FOREIGN KEY (userid) REFERENCES user(userid),
    FOREIGN KEY (jobid) REFERENCES joblisting(jobid),
    UNIQUE (userid, jobid)
);

CREATE TABLE resume (
    resumeid INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER NOT NULL,
    resumetitle TEXT,
    filepath TEXT,
    uploaddate TEXT,
    FOREIGN KEY (userid) REFERENCES user(userid)
);

-- =========================
-- POPULATE TABLES
-- =========================

-- Users
INSERT INTO user (username, fullname, email, phonenumber) VALUES
('jsmith', 'John Smith', 'john@email.com', '315-555-0101'),
('agarcia', 'Ana Garcia', 'ana@email.com', '315-555-0102'),
('mlee', 'Mike Lee', 'mike@email.com', '315-555-0103'),
('sjohnson', 'Sara Johnson', 'sara@email.com', '315-555-0104'),
('rkapoor', 'Raj Kapoor', 'raj@email.com', '315-555-0105');

-- Education
INSERT INTO user_education (userid, institution, degree, fieldofstudy, startdate, enddate) VALUES
(1, 'SUNY Oswego', 'BS', 'Computer Science', '2021-09-01', '2025-05-01'),
(2, 'Syracuse University', 'BS', 'Business Administration', '2020-09-01', '2024-05-01'),
(3, 'Cornell University', 'MS', 'Data Science', '2019-09-01', '2021-05-01'),
(4, 'Oswego State', 'BA', 'Communications', '2020-09-01', '2024-05-01'),
(5, 'RIT', 'BS', 'Electrical Engineering', '2018-09-01', '2022-05-01');

-- Work Experience
INSERT INTO user_workexperience (userid, companyname, jobtitle, startdate, enddate, description) VALUES
(1, 'StartupXYZ', 'Software Intern', '2024-06-01', '2024-08-31', 'Built REST APIs using Python and Flask'),
(2, 'GrowthCo', 'Sales Intern', '2023-06-01', '2023-08-31', 'Managed CRM and ran outbound campaigns'),
(3, 'DataFirm', 'Data Analyst', '2021-06-01', '2024-01-01', 'Built dashboards and ran SQL queries for clients'),
(4, 'MediaAgency', 'Content Intern', '2023-01-01', '2023-05-01', 'Managed social media and wrote blog posts'),
(5, 'EngineerCorp', 'EE Associate', '2022-06-01', '2024-12-01', 'Designed circuits and worked with AutoCAD');

-- Skills
INSERT INTO skill (skillname) VALUES
('Python'),
('SQL'),
('Java'),
('Marketing'),
('Excel'),
('CRM'),
('R'),
('Tableau'),
('Writing'),
('Social Media'),
('AutoCAD'),
('MATLAB'),
('JavaScript'),
('HTML');

-- User Skills
INSERT INTO user_skill (userid, skillid) VALUES
(1, 1), (1, 2), (1, 3),   -- John: Python, SQL, Java
(2, 4), (2, 5), (2, 6),   -- Ana: Marketing, Excel, CRM
(3, 2), (3, 7), (3, 8),   -- Mike: SQL, R, Tableau
(4, 9), (4, 10),           -- Sara: Writing, Social Media
(5, 11), (5, 12);          -- Raj: AutoCAD, MATLAB

-- Employers
INSERT INTO employer (companyname, industry, companyemail, phonenumber, address) VALUES
('TechCorp Inc', 'Technology', 'hr@techcorp.com', '212-555-0201', '100 Tech Ave, New York, NY'),
('GrowthAgency', 'Marketing', 'jobs@growthagency.com', '415-555-0202', '200 Market St, San Francisco, CA'),
('DataSolutions', 'Analytics', 'careers@datasol.com', '312-555-0203', '300 Data Blvd, Chicago, IL');

-- Recruiters
INSERT INTO recruiter (employerid, recruitername, recruiterphone, recruiteraddress) VALUES
(1, 'Lisa Turner', '212-555-0301', '100 Tech Ave, New York, NY'),
(2, 'Dan Brooks', '415-555-0302', '200 Market St, San Francisco, CA'),
(3, 'Nina Patel', '312-555-0303', '300 Data Blvd, Chicago, IL');

-- Job Listings
INSERT INTO joblisting (recruiterid, jobtitle, jobdescription, employmenttype, salary, dateposted, applicationdeadline, listingstatus) VALUES
(1, 'Software Engineer', 'Build and maintain backend systems', 'Full-time', 95000, '2025-01-10', '2025-02-10', 'Open'),
(2, 'GTM Specialist', 'Drive go-to-market strategy and campaigns', 'Full-time', 75000, '2025-01-15', '2025-02-15', 'Open'),
(3, 'Data Analyst', 'Analyze business data and build reports', 'Full-time', 80000, '2025-01-20', '2025-02-20', 'Open'),
(1, 'Junior Developer', 'Frontend development and UI work', 'Part-time', 50000, '2025-01-25', '2025-02-25', 'Open');

-- Job Skill Requirements
INSERT INTO job_skill_required (jobid, skillid) VALUES
(1, 1), (1, 2),    -- Software Engineer: Python, SQL
(2, 4), (2, 6),    -- GTM Specialist: Marketing, CRM
(3, 2), (3, 8),    -- Data Analyst: SQL, Tableau
(4, 13), (4, 14);  -- Junior Developer: JavaScript, HTML

-- Job Experience Requirements
INSERT INTO job_experience_required (jobid, requiredtitle, minyears, description) VALUES
(1, 'Software Developer', 2, 'Experience building backend systems'),
(2, 'Marketing or Sales', 1, 'Experience in B2B or growth marketing'),
(3, 'Data Analyst', 2, 'Experience with SQL and BI tools'),
(4, 'Frontend Developer', 0, 'Entry level, internship experience okay');

-- Applications
INSERT INTO application (userid, jobid, applicationdate, applicationstatus) VALUES
(1, 1, '2025-01-12', 'Under Review'),
(2, 2, '2025-01-16', 'Submitted'),
(3, 3, '2025-01-21', 'Interview Scheduled'),
(4, 2, '2025-01-17', 'Submitted'),
(5, 1, '2025-01-13', 'Rejected');

-- Resumes
INSERT INTO resume (userid, resumetitle, filepath, uploaddate) VALUES
(1, 'John Software Resume', '/resumes/john_smith.pdf', '2025-01-05'),
(2, 'Ana Marketing Resume', '/resumes/ana_garcia.pdf', '2025-01-06'),
(3, 'Mike Data Resume', '/resumes/mike_lee.pdf', '2025-01-07'),
(4, 'Sara Comms Resume', '/resumes/sara_johnson.pdf', '2025-01-08'),
(5, 'Raj Engineering Resume', '/resumes/raj_kapoor.pdf', '2025-01-09');

PRAGMA foreign_keys = ON;

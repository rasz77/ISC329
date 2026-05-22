PRAGMA foreign_keys = ON;

-- =========================
-- USER
-- =========================
CREATE TABLE user (
    userid INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    fullname TEXT,
    email TEXT,
    phonenumber TEXT,
    education TEXT,
    skills TEXT,
    workexperience TEXT
);

-- =========================
-- EMPLOYER
-- =========================
CREATE TABLE employer (
    employerid INTEGER PRIMARY KEY AUTOINCREMENT,
    companyname TEXT,
    industry TEXT,
    companyemail TEXT,
    phonenumber TEXT,
    address TEXT
);

-- =========================
-- RECRUITER
-- =========================
CREATE TABLE recruiter (
    recruiterid INTEGER PRIMARY KEY AUTOINCREMENT,
    employerid INTEGER,
    recruitername TEXT,
    recruiterphone TEXT,
    recruiteraddress TEXT,
    FOREIGN KEY (employerid) REFERENCES employer(employerid)
);

CREATE INDEX recruiter_employerid_idx ON recruiter(employerid);

-- =========================
-- JOB LISTING
-- =========================
CREATE TABLE joblisting (
    jobid INTEGER PRIMARY KEY AUTOINCREMENT,
    recruiterid INTEGER,
    jobtitle TEXT,
    jobdescription TEXT,
    employmenttype TEXT,
    salary INTEGER,
    skillreq TEXT,
    expreq TEXT,
    dateposted TEXT,
    applicationdeadline TEXT,
    listingstatus TEXT,
    FOREIGN KEY (recruiterid) REFERENCES recruiter(recruiterid)
);

CREATE INDEX joblisting_recruiterid_idx ON joblisting(recruiterid);

-- =========================
-- APPLICATION
-- =========================
CREATE TABLE application (
    applicationid INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER,
    jobid INTEGER,
    applicationdeadline TEXT,
    applicationstatus TEXT,
    FOREIGN KEY (userid) REFERENCES user(userid),
    FOREIGN KEY (jobid) REFERENCES joblisting(jobid)
);

CREATE INDEX application_userid_idx ON application(userid);
CREATE INDEX application_jobid_idx ON application(jobid);

-- =========================
-- RESUME
-- =========================
CREATE TABLE resume (
    resumeid INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER,
    resumetitle TEXT,
    filepath TEXT,
    uploaddate TEXT,
    FOREIGN KEY (userid) REFERENCES user(userid)
);

CREATE INDEX resume_userid_idx ON resume(userid);
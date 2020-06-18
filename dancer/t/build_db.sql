DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id          INTEGER PRIMARY KEY,
    login_name   TEXT    NOT NULL UNIQUE,
    first_name   TEXT    NOT NULL,
    last_name    TEXT    NOT NULL,
    email        TEXT    NOT NULL,
    is_admin     BOOLEAN NOT NULL
);
INSERT INTO users VALUES (NULL,"peter","Peter","Staab","pstaab@fitchburstate.edu",TRUE);
INSERT INTO users VALUES (NULL,"homer","Homer","Simpson","homer@msn.com",FALSE);
INSERT INTO users VALUES (NULL,"lisa","Lisa","Simpson","lisa@gmail.com",FALSE);
INSERT INTO users VALUES (NULL,"marge","Marge","Simpson","marge.s@gmail.com",FALSE);
INSERT INTO users VALUES (NULL,"bart","Bart","Simpson","bart@yahoo.com",FALSE);

DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
    course_id          INTEGER PRIMARY KEY,
    name   TEXT    NOT NULL,
    year    INTEGER    NOT NULL,
    semester        TEXT    NOT NULL
);

INSERT INTO courses VALUES (NULL,"Demo",2020,"Spring");
INSERT INTO courses VALUES (NULL,"Math 1500",2020,"Fall");


DROP TABLE IF EXISTS user_course;
CREATE TABLE user_course (
    user_course_id          INTEGER PRIMARY KEY,
    user_id   TEXT    NOT NULL,
    course_id    INTEGER    NOT NULL,
    role      TEXT NOT NULL,
    section   TEXT
);

INSERT INTO user_course VALUES (NULL,1,1,"student",1);
INSERT INTO user_course VALUES (NULL,2,1,"student",1);
INSERT INTO user_course VALUES (NULL,3,1,"instructor",NULL);
INSERT INTO user_course VALUES (NULL,2,2,"student",NULL);
INSERT INTO user_course VALUES (NULL,4,2,"student",NULL);

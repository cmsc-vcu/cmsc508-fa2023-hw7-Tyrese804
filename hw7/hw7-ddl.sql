# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS peopleroles;
# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

CREATE TABLE skills (
    id int NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL DEFAULT '(default)',
    tag varchar(255) NOT NULL,
    PRIMARY KEY(id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

INSERT INTO skills(id, name, tag) values
    (1, 'painting', 'Skill 1'),
    (2, 'rock climbing', 'Skill 2'),
    (3, 'photography', 'Skill 3'),
    (4, 'coding', 'Skill 4'),
    (5, 'cooking', 'Skill 5'),
    (6, 'multitasker', 'Skill 6'),
    (7, 'drawing', 'Skill 7'),
    (8, 'dancing', 'Skill 8');



# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

CREATE TABLE people (
    people_id int NOT NULL,
    people_first_name varchar(256) DEFAULT 'NULL',
    people_last_name varchar(256) NOT NULL,
    people_email varchar(256) DEFAULT 'NULL',
    people_linkedin_url varchar(256) DEFAULT 'NULL',
    people_headshot_url varchar(256) DEFAULT 'NULL',
    people_discord_handle varchar(256) DEFAULT 'NULL',
    people_brief_bio varchar(256) DEFAULT 'NULL',
    people_date_joined date NOT NULL DEFAULT '2023-11-10',
    PRIMARY KEY (people_id)
);

# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

INSERT INTO people (people_id, people_first_name, people_last_name) values 
    (1,'Bobby', 'Person 1'),
    (2, 'Ricky', 'Person 2'),
    (3, 'Tyrese', 'Person 3'),
    (4, 'Klaus', 'Person 4'),
    (5, 'Arnold', 'Person 5'),
    (6, 'Ryan', 'Person 6');

INSERT INTO people (people_id, people_first_name, people_last_name) values
    (7, 'Silas', 'Person 7'),
    (8, 'Patricia', 'Person 8'),
    (9, "Beth", 'Person 9'),
    (10, 'Samantha', 'Person 10');


# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

CREATE TABLE peopleskills (
    id int AUTO_INCREMENT NOT NULL,
    skills_id int NOT NULL,
    people_id int NOT NULL,
    date_acquired date NOT NULL DEFAULT (current_date),
    PRIMARY KEY (id),
    FOREIGN KEY (skills_id) REFERENCES skills (id),
    FOREIGN KEY (people_id) REFERENCES people (people_id)
);

# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.

ALTER TABLE peopleskills AUTO_INCREMENT=1;
SET FOREIGN_KEY_CHECKS=0;


INSERT INTO peopleskills (people_id, skills_id) values
    (1,1),
    (1,3),
    (1,6),
    (2,3),
    (2,4),
    (2,5),
    (3,1),
    (3,5),
    (5,3),
    (5,6),
    (6,2),
    (6,3),
    (6,4),
    (7,3),
    (7,5),
    (7,6),
    (8,1),
    (8,3),
    (8,5),
    (8,6),
    (9,2),
    (9,5),
    (9,6),
    (10,1),
    (10,4),
    (10,5);



# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

CREATE TABLE roles (
    id int,
    role_name varchar(256),
    sort_priority int,
    PRIMARY KEY (id)
);

# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles(id, role_name, sort_priority) values
    (1, 'Designer', 10),
    (2, 'Developer', 20),
    (3, 'Recruit', 30),
    (4, 'Team Lead', 40),
    (5, 'Boss', 50),
    (6, 'Mentor', 60);

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

CREATE TABLE peopleroles (
    id int AUTO_INCREMENT NOT NULL,
    people_id int NOT NULL,
    role_id int NOT NULL,
    date_assigned date NOT NULL DEFAULT '2023-11-10',
    PRIMARY KEY (id),
    FOREIGN KEY (people_id) REFERENCES people (people_id),
    FOREIGN KEY (role_id) REFERENCES roles (id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

INSERT INTO peopleroles(people_id, role_id) values
    (1,2),
    (2,5),
    (2,6),
    (3,2),
    (3,4),
    (4,3),
    (5,3),
    (6,1),
    (6,2),
    (7,1),
    (8,1),
    (8,4),
    (9,2),
    (10,2),
    (10,1);



-- TIP: @see psql's \i command to execute this DDL script (Data Definition Language)

-- DEPARTMENT TABLE (sequence, table, constraints and data)

CREATE SEQUENCE department_seq ;

CREATE TABLE IF NOT EXISTS department (
    id INT NOT NULL PRIMARY KEY DEFAULT(nextval('department_seq')),
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL
);

ALTER TABLE department
ADD CONSTRAINT department_name_city_unique_idx
UNIQUE (name, city);

INSERT INTO department (id, name, city) VALUES
    (nextval('department_seq'), 'Operations', 'Lyon'),
    (nextval('department_seq'), 'Administrative', 'Lyon'),
    (nextval('department_seq'), 'Staff', 'Lyon'),
    (nextval('department_seq'), 'Operations', 'Montpellier'),
    (nextval('department_seq'), 'Research and Development', 'Paris'),
    (nextval('department_seq'), 'Operations', 'Paris')
;

-- EMPLOYEE TABLE (sequence, table, constraints and data)

CREATE SEQUENCE employee_seq;

CREATE TABLE IF NOT EXISTS employee (
    id INT NOT NULL PRIMARY KEY DEFAULT(nextval('employee_seq')),
    department_id INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50)
);

ALTER TABLE employee
ADD CONSTRAINT employee_deptment_id_fk
FOREIGN KEY (department_id)
REFERENCES department (id);

INSERT INTO employee (id, department_id, lastname, firstname) VALUES
    (
        nextval('employee_seq'),
        (SELECT id FROM department WHERE name LIKE 'Operations' AND city LIKE 'Lyon'),
        'Doe',
        'John'
    ),
    (
        nextval('employee_seq'),
        (SELECT id FROM department WHERE name LIKE 'Operations' AND city LIKE 'Lyon'),
        'Georges',
        'Guy'
    )
;

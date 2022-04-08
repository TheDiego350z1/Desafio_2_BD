--Creción de base de datos
CREATE DATABASE recursos_humanos;

USE recursos_humanos;

--Creación de tablas
CREATE TABLE regions (
	region_id INT PRIMARY KEY,
	region_name VARCHAR(255)
);

CREATE TABLE countries (
	countries INT PRIMARY KEY,
	country_name VARCHAR(255),
	region_id INT FOREIGN KEY REFERENCES regions(region_id)
);

CREATE TABLE locations (
	location_id INT PRIMARY KEY,
	streed_address VARCHAR(255),
	POSTAL_CODE VARCHAR(10), --se toma referencia https://www.azcodigopostal.com/
	city VARCHAR(255),
	state_province VARCHAR(255),
	country_id INT FOREIGN KEY REFERENCES countries(countries) 
);

CREATE TABLE jobs(
	job_id INT PRIMARY KEY,
	job_title VARCHAR(255),
	min_salary MONEY,
	max_salary MONEY,
);

CREATE TABLE employess (
	employee_id INT PRIMARY KEY,
	frist_name varchar(30),
	last_name varchar(30),
	email VARCHAR(255) UNIQUE,
	phoNE VARCHAR(15),
	hire_number varchar(15),
	hire_date DATETIME,
	salary MONEY,
	commission_pct MONEY,
	departament_id INT,
	job_id INT FOREIGN KEY REFERENCES jobs(job_id),
	manager_id INT FOREIGN KEY REFERENCES employess(employee_id),
	--departament_id INT FOREIGN KEY REFERENCES departaments(departament_id),
);

CREATE TABLE departaments (
	departament_id INT PRIMARY KEY,
	departamen_name VARCHAR(255),
	manager_id INT FOREIGN KEY REFERENCES employess(employee_id),
	location_id INT FOREIGN KEY REFERENCES locations(location_id)
);

CREATE TABLE job_history (
	job_historiy_id INT PRIMARY KEY,
	start_date DATETIME NOT NULL,
	end_date DATETIME NOT NULL,
	job_id INT FOREIGN KEY REFERENCES jobs(job_id),
	departament_id INT FOREIGN KEY REFERENCES departaments(departament_id),
); 

ALTER TABLE employess ADD CONSTRAINT FK_EMPLOYESS_DEPARTAMENTS FOREIGN KEY (departament_id) REFERENCES departaments(departament_id);
--Creci�n de base de datos
CREATE DATABASE recursos_humanos;

USE recursos_humanos;

--Creaci�n de tablas
CREATE TABLE regions (
	region_id INT IDENTITY(1,1) PRIMARY KEY,
	region_name VARCHAR(255)
);

CREATE TABLE countries (
	countries INT IDENTITY(1,1) PRIMARY KEY,
	country_name VARCHAR(255),
	region_id INT FOREIGN KEY REFERENCES regions(region_id)
);

CREATE TABLE locations (
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	streed_address VARCHAR(255),
	postal_code VARCHAR(10), --se toma referencia https://www.azcodigopostal.com/
	city VARCHAR(255),
	state_province VARCHAR(255),
	country_id INT FOREIGN KEY REFERENCES countries(countries) 
);

CREATE TABLE jobs(
	job_id INT IDENTITY(1,1) PRIMARY KEY,
	job_title VARCHAR(255),
	min_salary MONEY,
	max_salary MONEY,
);

CREATE TABLE employess (
	employee_id INT IDENTITY(1,1) PRIMARY KEY,
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
	departament_id INT IDENTITY(1,1) PRIMARY KEY,
	departamen_name VARCHAR(255),
	manager_id INT FOREIGN KEY REFERENCES employess(employee_id),
	location_id INT FOREIGN KEY REFERENCES locations(location_id)
);

CREATE TABLE job_history (
	job_historiy_id INT IDENTITY(1,1) PRIMARY KEY,
	start_date DATETIME NOT NULL,
	end_date DATETIME NOT NULL,
	job_id INT FOREIGN KEY REFERENCES jobs(job_id),
	departament_id INT FOREIGN KEY REFERENCES departaments(departament_id),
); 

ALTER TABLE employess ADD CONSTRAINT FK_EMPLOYESS_DEPARTAMENTS FOREIGN KEY (departament_id) REFERENCES departaments(departament_id);

--Inserci�on de datos 

--Sentencia insert
--INSERT INTO tabla_nombre (id, name, ...) VALUES ('VALUE1' 'VALUE2' ...)

--Podemos reducir la sintaxis anterior de la manera siguiente:
--INSERT INTO tabla_nombre VALUES('VALUE1', 'VALUE2' ....).


--Los valores hacen referencias a las columnas de la tabla
--Tenemos definida la PK como AUTO INCREMENTABLE as� que
--omitimos


--Tabla de regions

INSERT INTO regions (region_name) 
VALUES
('SAN SALVADOR'), --id 1
('LA LIBERTAD'), --id 2
('CABAÑAS'), --id 3
('MORAZAN'), --id 4
('SAN MIGUEL'); --id 5

--Tabla countries

INSERT INTO countries (country_name, region_id) 
VALUES
('TONACATEPEQUE', '1'), --id 1
('ANTIGUO CUSCATLAN', '2'), --id 2
('SAN SALVADOR', '1'), --id 3
('DOLORES', '3'), --id 4
('SAN MIGUEL', '4'), --id 5
('SAN MARTIN', '1'); --id 6

--Tabla locations
--Referencia de los códigos postales https://www.correos.gob.sv/codigos-postales
INSERT INTO locations (streed_address, postal_code, city, state_province, country_id)
VALUES
('RES. ALTAVISTA #30', '01132', 'TONACATEPEQUE', 'SAN SALVADOR', '1'), --id 1
('PRIMERA CALLE. PNT #40', '01101', 'SAN SALVADOR', 'SAN SALVADOR', '1'), --id 2
('CENTRO COMERCIAL PLAZA MUNDO LOCAL #20', 'O1116', 'SOYAPANGO', 'SOYAPANGO', '1'), --id 3
('RES. VILLA GALICIA #102', '01117', 'ILOPANGO', 'ILOPANGO', '1'), --id 4
('RES. VILLA GALICIA #106', '01117', 'ILOPANGO', 'ILOPANGO', '1'); --id 5


--Tabla jobs
INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES
('RECEPCIONISTA', '365', '400'), --id 1
('ASISTENTE DE VENTA', '365', '400'), --id 2
('JEFE DE SUCURSAL', '500', '600'), --id 3
('MENSAJERO', '400', '450'), --id 4
('ASISTENTE DE BODEGA', '365', '400'), --id 5
('JEFE DE BODEGA', '450', '550'), --id 6
('CONTADOR', '800', '1000'), --id 7
('ASISTENTE CONTABLE', '600', '800'), --id 8
('AUDITOR', '1000', '1200'), --id 9
('DISEÑADOR GRAFICO', '800', '1000'), --id 10
('ASISTENTE DE DISEÑO', '500', '750'), --id 11
('GUARDIA DE SEGURIDAD', '400', '550'), --id 12
('COCINERO', '400', '600'), --id 13
('COMUNITY MANAGER', '600', '700'), --id 14
('ASISTENTE COMUNITY MANAGER', '400', '500'), --id 15
('CAJERO', '400', '500'), --id 16
('JEFE DE CAJA', '700', '1000'), --id 17
('GERENTE GENERAL', '1400', '1800'), --id 18
('FRONT END DEVELOPER', '500', '1200'), --id 19
('SOPORTE TECNICO', '400', '800'), --id 20
('BACK END DEVELOPER', '500', '1200'); --id 21
--Creción de base de datos
CREATE DATABASE recursos_humanos;

--Selección la base de datos creada
USE recursos_humanos;

--Creación de tablas
--DEFINIMOS TODAS LAS TABLAS COMO AUTO INCREMENTABLES
CREATE TABLE regions (
	region_id INT IDENTITY(1,1) PRIMARY KEY,
	region_name VARCHAR(255)
);

CREATE TABLE countries (
	country_id INT IDENTITY(1,1) PRIMARY KEY,
	country_name VARCHAR(255),
	region_id INT, --FK
);

CREATE TABLE locations (
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	streed_address VARCHAR(255),
	postal_code VARCHAR(10), --se toma referencia https://www.azcodigopostal.com/
	city VARCHAR(255),
	state_province VARCHAR(255),
	country_id INT, --FK
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
	email VARCHAR(255) UNIQUE, --dos empleados no pueden tener el mismo email
	phone_number VARCHAR(15),
	hire_date DATETIME,
	salary MONEY,
	commission_pct MONEY,
	job_id INT, --FK jobs(id)
	manager_id INT NULL,
);

CREATE TABLE departaments (
	departament_id INT IDENTITY(1,1) PRIMARY KEY,
	departamen_name VARCHAR(255),
	manager_id INT, --FK employess(employee_id)
	location_id INT,
);

CREATE TABLE job_history (
	job_historiy_id INT IDENTITY(1,1) PRIMARY KEY,
	start_date DATETIME NOT NULL,
	end_date DATETIME NULL, --PERMITIMOS CAMPOS NULOS YA QUE PODEMOS TENER EMPLEADOS QUE AUN NO RENUNCIEN
	job_id INT, --FK
	departament_id INT, --FK
	employee_id INT, --FK
); 

--INSTERCIÓN DE FK POR MEDIO DE ALTER TABLE
--las llaves forarenas se pueden crear al momento de crear la tabla
--con: 
ALTER TABLE countries
ADD CONSTRAINT FK_COUNTRIES_REGIONS
FOREIGN KEY (region_id)
REFERENCES regions(region_id);

ALTER TABLE locations
ADD CONSTRAINT FK_LOCATIONS_COUNTRIES
FOREIGN KEY (country_id)
REFERENCES countries(country_id);

ALTER TABLE employess
ADD CONSTRAINT FK_EMPLOYESS_JOBS
FOREIGN KEY (job_id)
REFERENCES jobs(job_id);

ALTER TABLE employess
ADD CONSTRAINT FK_EMPLOYESS_MANAGER
FOREIGN KEY (manager_id)
REFERENCES employess(employee_id);

ALTER TABLE departaments
ADD CONSTRAINT FK_DEPARTAMENTS_EMPLOYESS
FOREIGN KEY (manager_id)
REFERENCES employess(employee_id);

ALTER TABLE departaments
ADD CONSTRAINT FK_DEPARTAMENTS_LOCATIONS
FOREIGN KEY (location_id)
REFERENCES locations(location_id);

ALTER TABLE job_history
ADD CONSTRAINT FK_JOB_HISTORY_JOBS
FOREIGN KEY (job_id)
REFERENCES jobs(job_id);

ALTER TABLE job_history
ADD CONSTRAINT FK_JOB_HISTORY_DEPARTAMENTS
FOREIGN KEY (departament_id)
REFERENCES departaments(departament_id);

ALTER TABLE job_history
ADD CONSTRAINT FK_JOB_HISTORY_ENPLOYESS
FOREIGN KEY (employee_id)
REFERENCES employess(employee_id);

--Inserción de datos 

--Sentencia insert
--INSERT INTO tabla_nombre (id, name, ...) VALUES ('VALUE1' 'VALUE2' ...)

--Podemos reducir la sintaxis anterior de la manera siguiente:
--INSERT INTO tabla_nombre VALUES('VALUE1', 'VALUE2' ....).


--Los "VALUES" hacen referencias a las columnas de la tabla
--Tenemos definida la PK como AUTO INCREMENTABLE así que
--omitimos el campo de la inserción de PK


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

SET DATEFORMAT dmy; --SETEAMOS EL FORMATO DE LA FECHA PARA QUE SEA DIA-MES-AÑO

--Tabla
INSERT INTO employess (frist_name, last_name, email, phone_number, hire_date, salary, commission_pct, job_id, manager_id)
VALUES
('DIEGO', 'CARGIA', 'DIEGO@GMAIL.COM', '73707733', '05-06-2010', '1000', '0', '21', '1'), --id 1 bk dev(job)
('ANTONIO', 'RIVAS', 'ANTONIO@GMAIL.COM', '76882983', '02-02-2016', '600', '100', '3', '2'), --id 2 (JE- SCURISAL id(job) 3)
('HERNESTO', 'HERNANDEZ', 'HERNANDEZ@GMAIL.COM', '79378530', '28-08-2010', '400', '0', '6', '3'), --id 3 JEFE DE BODEGA job(id) 6
('JUAN', 'MONTE ROSA', 'MONTE_ROSAJUAN@GMAIL.COM', '76879083', '05-05-2013', '400', '0', '5', '3'), --id 4 ASISTENTE DE BODEGA job(id) 5
('HERNESTO', 'SOSA', 'SOSA@GMAIL.COM', '76998835', '10-10-2020', '750', '0', '17', '5'), --id 5 JEFE DE CAJA job(id) 17
('ANA', 'IBARRA', 'IBARRAANA@GMAIL.COM', '74857083', '05-06-2021', '400', '50', '16', '5'), --id 6 CAJA job(id) 17
('EVA', 'ROSALES', 'EVA@GMAIL.COM', '73996801', '17-07-2017', '900', '0', '7', '7'), --id 7 CONTADOR job(id) 7
('LUZ', 'SARAVIA', 'SARAVIA@GMAIL.COM', '74931788', '05-08-2013', '600', '0', '8', '7'), --id 8 ASISTENTE DE BODEGA job(id) 5
('RAUL', 'HERNANDEZ', 'RAUL_HERNANDEZ@GMAIL.COM', '79895083', '15-03-2020', '500', '0', '3', '9'), --id 9 JEFE DE SUCURSAL job(id) 3
('KAREN', 'MARTINEZ', 'MARTINEZKAREN@GMAIL.COM', '74883457', '06-08-2014', '400', '0', '2', '9'), --id 10 ASISTENTE DE VENTA job(id) 2
('ALBA', 'ALBARADO', 'ALBARADO@GMAIL.COM', '72998576', '05-06-2013', '400', '0', '2', '9'), --id 11 ASISTENTE DE VENTA job(id) 2
('MANUEL', 'LOPEZ', 'LOPEZMANUEL@GMAIL.COM', '79004567', '08-05-2018', '500', '0', '3', '12'), --id 12 JEFE DE SUCURSAL job(id) 3
('JORGE', 'ROSALES', 'JORGE_ROSALES@GMAIL.COM', '73289977', '07-08-2014', '400', '0', '2', '12'), --id 13 ASISTENTE DE VENTA job(id) 2
('LUCIA', 'RIVAS', 'RIVAS_LUCIA@GMAIL.COM', '73887965', '19-08-2013', '400', '0', '2', '12'), --id 14 ASISTENTE DE VENTA job(id) 2
('MOISES', 'LEMUEL', 'LLEMUEL@GMAIL.COM', '71586242', '07-01-2011', '400', '0', '2', '12'), --id 15 ASISTENTE DE VENTA job(id) 2
('JOSE', 'MARTINEZ', 'JOSEMARTINEZ@GMAIL.COM', '71229977', '03-03-2013', '400', '0', '2', '12'), --id 16 ASISTENTE DE VENTA job(id) 2
('ANTONIO', 'GARCIA', 'ANTON@GMAIL.COM', '76134789', '05-05-2013', '1200', '0', '19', '17'), --id 17 FRONT END DEVELOPER job(id) 19
('EDGARDO', 'OSORIO', 'OSORIOEDGAR@GMAIL.COM', '75688212', '08-01-2015', '700', '0', '20', '18'), --id 18 SOPORTE TECNICO job(id) 20
('CARLOS', 'MEJIA', 'MEJIA_CARLOS@GMAIL.COM', '73276561', '05-05-2013', '400', '0', '5', '3'), --id 19 ASISTENTE DE BODEGA job(id) 5
('FATIMA', 'PERMA', 'PERLA@GMAIL.COM', '79882214', '05-05-2013', '400', '0', '2', '12');


INSERT INTO departaments (departamen_name, manager_id, location_id)
VALUES
('TI', '1', '1'),
('BODEGA', '3', '2'), 
('SALA DE VENTAS', '2', '3'),
('CAJA', '5', '3'),
('CONTABILIDAD', '7', '1'),
('SALA DE VENTAS', '9', '2'),
('SALA DE VENTAS', '12', '3'),
('TI', '18', '4');

--Selección de tablas para muestra de data

SELECT * FROM regions;
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM jobs;
SELECT * FROM employess;
SELECT * FROM departaments;
SELECT * FROM job_history;
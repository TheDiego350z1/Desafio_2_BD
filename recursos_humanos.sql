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
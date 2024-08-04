CREATE DATABASE IF NOT EXISTS Empresa;

CREATE TABLE IF NOT EXISTS Area (
	cod_area INT NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (cod_area)
);
CREATE TABLE IF NOT EXISTS Especialidad (
	cod_esp INT NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY (cod_esp)
);
CREATE TABLE IF NOT EXISTS Empleado (
	nro_emp INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    cod_esp INT NOT NULL,
    nro_jefe INT NOT NULL,
    sueldo INT NOT NULL,
    f_ingreso DATE NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (nro_emp),
    CONSTRAINT FK1 FOREIGN KEY (cod_esp) REFERENCES Especialidad (cod_esp),
    CONSTRAINT FK2 FOREIGN KEY (nro_jefe) REFERENCES Empleado (nro_emp)
);
CREATE TABLE IF NOT EXISTS Trabaja (
	nro_emp INT NOT NULL,
    cod_area INT NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (nro_emp, cod_area),
    CONSTRAINT FK3 FOREIGN KEY (nro_emp) REFERENCES Empleado (nro_emp),
	CONSTRAINT FK4 FOREIGN KEY (cod_area) REFERENCES Area (cod_area)
);

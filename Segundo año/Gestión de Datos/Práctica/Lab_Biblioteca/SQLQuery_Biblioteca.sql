IF NOT EXISTS(SELECT * FROM sys.databases WHERE NAME = 'Biblioteca')
CREATE DATABASE Biblioteca

-- 1) Scripts de creación de todas las tablas. 
-- a. En estas sentencias de creación son importantes los tipos de datos, primary key y foreign key.

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Provincia' AND TYPE = 'U')
CREATE TABLE Provincia (
	ID_Provincia INT NOT NULL,
	Descripcion VARCHAR(50),
	CONSTRAINT PK_Provincia PRIMARY KEY (ID_Provincia)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Localidad' AND TYPE = 'U')
CREATE TABLE Localidad (
	ID_Localidad INT NOT NULL,
	Descripcion VARCHAR(50),
	ID_Provincia INT NOT NULL,
	CONSTRAINT PK_Localidad PRIMARY KEY (ID_Localidad),
	CONSTRAINT FK_Localidad_Provincia FOREIGN KEY (ID_Provincia) REFERENCES Provincia(ID_Provincia)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Categoria' AND TYPE = 'U')
CREATE TABLE Categoria (
	ID_Categoria INT NOT NULL,
	Descripcion VARCHAR(50),
	CONSTRAINT PK_Categoria PRIMARY KEY (ID_Categoria)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Editorial' AND TYPE = 'U')
CREATE TABLE Editorial (
	ID_Editorial INT NOT NULL,
	Nombre VARCHAR(50),
	Direccion VARCHAR(50),
	Telefono INT,
	ID_Localidad INT NOT NULL,
	CONSTRAINT PK_Editorial PRIMARY KEY (ID_Editorial),
	CONSTRAINT FK_Editorial_Localidad FOREIGN KEY (ID_Localidad) REFERENCES Localidad(ID_Localidad)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Libro' AND TYPE = 'U')
CREATE TABLE Libro (
	ID_Libro INT NOT NULL,
	Titulo VARCHAR(50),
	Descripcion VARCHAR(50),
	ID_Editorial INT NOT NULL,
	ID_Categoria INT NOT NULL,
	CONSTRAINT PK_Libro PRIMARY KEY (ID_Libro),
	CONSTRAINT FK_Libro_Editorial FOREIGN KEY (ID_Editorial) REFERENCES Editorial(ID_Editorial),
	CONSTRAINT FK_Libro_Categoria FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Persona' AND TYPE = 'U')
CREATE TABLE Persona (
	ID_Persona INT NOT NULL,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Direccion VARCHAR(50),
	Telefono INT,
	ID_Localidad INT NOT NULL,
	CONSTRAINT PK_Persona PRIMARY KEY (ID_Persona),
	CONSTRAINT FK_Persona_Localidad FOREIGN KEY (ID_Localidad) REFERENCES Localidad(ID_Localidad)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Autor' AND TYPE = 'U')
CREATE TABLE Autor (
	ID_Persona INT NOT NULL,
	Referencia VARCHAR(50),
	CONSTRAINT PK_Autor PRIMARY KEY (ID_Persona)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Alumno' AND TYPE = 'U')
CREATE TABLE Alumno (
	ID_Persona INT NOT NULL,
	Anio_Ingreso INT,
	Anio_Cursa INT,
	Turno VARCHAR(1),
	Division VARCHAR(3),
	CONSTRAINT PK_Alumno PRIMARY KEY (ID_Persona)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Docente' AND TYPE = 'U')
CREATE TABLE Docente (
	ID_Persona INT NOT NULL,
	Anio_Ingreso INT,
	Titulo VARCHAR(50),
	CONSTRAINT PK_Docente PRIMARY KEY (ID_Persona)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Autor_Libro' AND TYPE = 'U')
CREATE TABLE Autor_Libro (
	ID_Persona INT NOT NULL,
	ID_Libro INT NOT NULL, 
	CONSTRAINT FK_Autor_Libro_Persona FOREIGN KEY (ID_Persona) REFERENCES Autor(ID_Persona),
	CONSTRAINT FK_Autor_Libro_Libro FOREIGN KEY (ID_Libro) REFERENCES Libro(ID_Libro)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Prestamo' AND TYPE = 'U')
CREATE TABLE Prestamo (
	ID_Persona INT NOT NULL,
	ID_Libro INT NOT NULL, 
	Fecha_Prestamo DATE,
	Fecha_Devolucion DATE,
	CONSTRAINT FK_Prestamo_Persona FOREIGN KEY (ID_Persona) REFERENCES Persona(ID_Persona),
	CONSTRAINT FK_Prestamo_Libro FOREIGN KEY (ID_Libro) REFERENCES Libro(ID_Libro)
);


--


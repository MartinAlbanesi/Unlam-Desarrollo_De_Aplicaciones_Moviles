USE Northwind

ALTER TABLE dbo.Employees
ADD CONSTRAINT BirthDate CHECK (BirthDate <= '1-1-1900');

if not exists(SELECT * FROM sys.objects WHERE name = 'Tabla')

IF NOT EXISTS(SELECT * FROM sys.schemas WHERE NAME = N'Compras')
EXEC('CREATE SCHEMA Compras')
GO;

ALTER TABLE Empleados ADD CONSTRAINT PK_Empleados PRIMARY KEY CLUSTERED (Legajo);

ALTER TABLE Empleados ADD CONSTRAINT DF_FhIngreso DEFAULT GetDate() FOR FhIngresoEmpresa;

CREATE TABLE Empleados(
	ID INT NOT NULL,
	FhIngresoEmpresa DATE NOT NULL,
	id_trabajo INT,
	edad INT,
	CONSTRAINT PK_EmpleadosID PRIMARY KEY (ID),
	CONSTRAINT DF_EmpleadosFhIngresoEmpresa DEFAULT (GetDate()) FOR FhIngresoEmpresa,
	CONSTRAINT Check_Empleados CHECK (FhIngresoEmpresa >= '1-1-1900')
)

ALTER TABLE Empleados ADD CONSTRAINT FK_Empleados_Trabajo FOREIGN KEY (id_trabajo) REFERENCES Trabajo (id_trabajo)

ALTER TABLE Empleados ADD CONSTRAINT DF_Empleados DEFAULT (0) FOR edad

CREATE DATABASE Prueba 
ON 
(NAME = 'Prueba_Datos',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Prueba.mdf', --(en los 3 puntitos va la ruta del archivo)
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 3MB)
LOG ON
(NAME = 'Prueba_Log',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Prueba.ldf', --(en los 3 puntitos va la ruta del archivo)
SIZE = 5MB,
MAXSIZE = 15MB,
FILEGROWTH = 10%);



ALTER VIEW Vista1
AS
(SELECT DATEDIFF(YEAR,e.BirthDate,GETDATE()) AS Edad, e.FirstName, e.LastName
FROM Employees e
WHERE DATEDIFF(YEAR,e.BirthDate,GETDATE()) >= 25
GROUP BY e.BirthDate, e.FirstName, e.LastName
);

SELECT * FROM Vista1

CREATE VIEW Vista2
AS
(SELECT CONCAT(e.FirstName, ' ', e.LastName) AS Empleado, DATEDIFF(YEAR,e.BirthDate,GETDATE()) AS Edad
FROM Employees e
);

SELECT v.Empleado, v.Edad
FROM Vista2 v
WHERE v.Edad > 25
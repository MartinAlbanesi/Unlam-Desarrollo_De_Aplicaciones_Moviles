CREATE TABLE Especialidad
(
idEsp INT PRIMARY KEY,
descripcion VARCHAR(20),
)
CREATE TABLE Medico
(
Legajo INT PRIMARY KEY,
Nombre VARCHAR(30),
Apellido VARCHAR (30),
Telefono BIGINT,
valor_Consulta INT,
IdEsp INT,
CONSTRAINT FkMedico FOREIGN KEY (IdEsp) REFERENCES Especialidad (IdEsp)
)

CREATE TABLE Localidad
(
idLocalidad INT PRIMARY KEY,
descripcion VARCHAR(40)
)
CREATE TABLE Paciente
(
Legajo VARCHAR(4),
Nombre VARCHAR(30),
Apellido VARCHAR (30),
Telefono BIGINT,
idLocalidad INT,
CONSTRAINT FkPaciente FOREIGN KEY (idLocalidad) REFERENCES Localidad (IdLocalidad)
)
CREATE TABLE Consulta
(
Id INT PRIMARY KEY,
LegMedico INT,
LegPaciente VARCHAR(4),
Fecha DATETIME,
nroConsultorio INT,
CONSTRAINT FkConsulta1 FOREIGN KEY (LegMedico) REFERENCES Medico (Legajo),
CONSTRAINT FkConsulta2 FOREIGN KEY (LegPaciente) REFERENCES Paciente (Legajo)
)

INSERT INTO Medico VALUES
(111,'Andres','Gomez',1122334455,1500,1),
(222,'Mariana','Lopez',2233445566,1850,2),
(333,'Andrea','Ramirez',1133221122,1450,4),
(444,'Marcelo','Suearez',null,1550,1),
(555,'Fernando','Gomez',null,1600,2),
(666,'Andrea','Ramirez',1133221122,1450,4)

INSERT INTO Especialidad VALUES
(1,'Cardiologia'),
(2,'Clinica'),
(3,'Dermatologia'),
(4,'Nutricionista')
SELECT * FROM Medico

INSERT INTO Localidad VALUES
(1,'Moron'),
(2,'San Justo'),
(3,'Villa Luzuriaga')

INSERT INTO Paciente VALUES
('A1','Juana','Martinez',1122334455,1),
('A2','Sebastian','Gomez',1122334455,2),
('B3','Guillermo','Ramirez',1122334455,2),
('B5','Fernanda','Sola',null,2)

INSERT INTO Consulta VALUES
(1,111,'A1','20210102',1),
(2,333,'A1','20210202',1),
(3,111,'B3','20210503',2),
(4,444,'B5','20210609',1),
(5,555,'B3','20210506',2)

--1 OK
--2 OK
--3 MAL
--4 OK
--5 OK
--6 1/2
--7 MAL
--8 MAL
--9 MAL
--10 MAL
--11 MAL

--1 Escribir el script de creación de tabla de Medico con sus restricciones
CREATE TABLE Medico
(
Legajo INT PRIMARY KEY,
Nombre VARCHAR(30),
Apellido VARCHAR (30),
Telefono INT,
Valor_Consulta INT,
IdEsp INT
CONSTRAINT FkMedico FOREIGN KEY (IdEsp) REFERENCES Especialidad (IdEsp)
)
--2 Obtenerlos datos de todos los médicos, ordenados por especialidad y legajo
SELECT * FROM Medico M
JOIN Especialidad E
ON M.IdEsp = E.iDEsp
ORDER BY E.IdEsp, Legajo

--3 Para cada especialidad, informar la cantidad de médicos, y el valor máximo de la consulta  
SELECT E.descripcion, COUNT(M.Legajo) AS Cantidad_Medicos , MAX(Valor_Consulta) AS Valor_Maximo
FROM Medico M
JOIN Especialidad E
ON M.IdEsp = E.idEsp
GROUP BY E.descripcion


--4 informar: Legajo, Nombre y apellido del paciente, Legajo del médico, nombre y apellido del médico, fecha de consulta, importe comisión de la clínica (20%del
--importe abonado por consulta) y nro de consultorio, de todas las consultas registradas en el mes de febrero
SELECT P.nombre, P.apellido, M.legajo, M.nombre, M.apellido, C.Fecha,(M.Valor_consulta*0.20) AS Comision_clinica
FROM Paciente P
JOIN Consulta C
ON P.legajo = C.Legpaciente
JOIN Medico M
ON M.Legajo = C.Legmedico--5 Escribir el script para agregar el siguiente Médico: 1234, Juan,Perez,01154545454, 1250, 9
INSERT INTO Medico VALUES
(1234, 'Juan', 'Perez',01154545454, 1250, 9)--6 Considera que podría tener algún inconveniente al insertar el registro del punto anterior?  Justifique su respuesta./*Si alguno de los registros superase el tamaño definido por el tipo definido al crear la tabla
tendria un problema, si el nro de legajo ya estuviese registrado no se podria registrar ya que
es primary key (ACA LA RESPUESTA QUE CALCULO BUSCABA LA PROFE ESTA ANTES, NO SE PUEDEN REGISTRAR MEDICOS SIN HABER REGISTRADO ANTES ESPECIALIDADES, YA QUE ES FK DE MEDICO)*/--7 Escribir la sentencia para modificar las consultas registradas, cambiando el consultorio 1 por consultorio 3UPDATE ConsultaSET nroConsultorio = 3WHERE nroConsultorio = 1-- 8 Informar los médicos que tienen el mayor valor de consulta
SELECT nombre, apellido, valor_Consulta
FROM Medico
WHERE valor_Consulta >=
						(SELECT MAX(valor_consulta) AS Maximo
						FROM Medico)

--9 Mostrar los datos de los pacientes que han realizado alguna consulta de Cardiología pero nunca han consultado a un nutricionista 

SELECT * FROM Paciente P
JOIN Consulta C
ON P.Legajo = C.LegPaciente
JOIN Medico M
ON M.Legajo = C.LegMedico
JOIN Especialidad E
ON E.idEsp = M.IdEsp
WHERE E.descripcion = 'Cardiologia' and P.Legajo not in(SELECT P.Legajo FROM Paciente P
															JOIN Consulta C
															ON P.Legajo = C.LegPaciente
															JOIN Medico M
															ON M.Legajo = C.LegMedico
															JOIN Especialidad E
															ON E.idEsp = M.IdEsp
															WHERE E.descripcion = 'Nutricionista')
																													   															 														  





--10 Mostrarlos datos de los pacientes que se han atenido por todos los médicos 


SELECT P.nombre, P.Apellido, P.Telefono, P.Legajo, COUNT(C.Legmedico) AS Medicos_que_lo_atendieron FROM Consulta C	
JOIN Paciente P
ON C.LegPaciente = P.Legajo
WHERE C.LegPaciente =P.Legajo
GROUP BY P.nombre, P.Apellido, P.Telefono, P.Legajo
HAVING COUNT(C.Legmedico) = (SELECT COUNT(Legajo) Cantidad_De_Medicos FROM Medico)

--AGREGE VALORES A LA TABLA PACIENTE PARA QUE EL PACIENTE A1 HAYA SIDO ATENDIDO POR TODOS LOS MEDICOS
INSERT INTO Consulta VALUES
(6,222,'A1','20210102',1),
(7,444,'A1','20210102',1),
(8,555,'A1','20210102',1),
(9,666,'A1','20210102',1)


 --11 Informar los datos de los pacientes que han abonado mas de 1000 en total en el último trimestre (enero, febrero y marzo 2021) 
 				

SELECT P.legajo, P.nombre, P.apellido, SUM(M.valor_Consulta) AS 'Total'
FROM Paciente P
JOIN Consulta C
ON P.legajo = C.legPaciente
JOIN Medico M
ON C.legMedico = M.legajo
WHERE C.fecha BETWEEN '20210101' AND '20210331'
GROUP BY P.legajo, P.nombre, P.apellido

 SELECT * FROM Consulta
 
 SELECT * FROM Consulta C
 ORDER BY C.LegPaciente


 --Fernanda = 1550
 --Guillermo = 3100
 --Juana = 9400




-- 1.Escribir el script de creación de tabla de Medico con sus restricciones.
CREATE TABLE IF NOT EXISTS Medico (
	legajo INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
	telefono INT NULL,
    valor_consulta DECIMAL (10,2) NOT NULL,
    id_esp INT NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (legajo),
    CONSTRAINT FK1 FOREIGN KEY (id_esp) REFERENCES Especialidad (id_esp)
);

-- 2.Obtener los datos de todos los médicos, ordenados por especialidad y legajo.
SELECT *
FROM Medico AS med
INNER JOIN Especialidad AS esp
ORDER BY esp.id_esp, med_legajo;

-- 3.Para cada especialidad, informar la cantidad de médicos, y el valor máximo de la consulta. 
SELECT esp.id_esp, COUNT(med.legajo), MAX(med.valor_consulta)
FROM Medico AS med
INNER JOIN Especialidad AS med
ORDER BY esp.id_esp;


-- 4.Informar: Legajo, Nombre y apellido del paciente, Legajo del médico, nombre y apellido del médico, fecha de consulta, importe comisión de la clínica (20%del importe abonado por consulta) y nro de consultorio, de todas las consultas registradas en el mes de febrero
SELECT pac.legajo, pac.nombre, pac.apellido, med.legajo, med.nombre, med.apellido, con.fecha_consulta, 	con.valor_consulta*1.2, con.nro_consultorio
FROM Consulta AS con
INNER JOIN Paciente AS pac
ON con.legpaciente = pac.legajo
INNER JOIN Medico AS med
ON con.legmedico = med.legajo
WHERE con.fecha_consulta >= '20210201' AND fecha_alta < '20210301';

-- 5.Escribir el script para agregar el siguiente Médico: 1234, Juan, Perez,01154545454, 1250, 9 
INSERT INTO Medico(legajo,nombre,apellido,telefono,valor_consulta,id_esp) values
(1234,'Juan','Perez',01154545454, 1250,9);

-- 6.¿Considera que podría tener algún inconveniente al insertar el registro del punto anterior? Justifique su respuesta.
-- No existe la especialidad 9

-- 7.Escribir la sentencia para modificar las consultas registradas, cambiando el consultorio 1 por consultorio 3Texto de varias líneas. 
UPDATE Consulta
SET nroconsultorio = 3
WHERE nroconsultorio = 1;

-- 8.Informar los médicos que tienen el mayor valor de consulta.
SELECT *
FROM Medico AS med
WHERE med.valor_consulta = (SELECT MAX(valor_consulta)
							FROM Medico);

-- 9.Mostrar los datos de los pacientes que han realizado alguna consulta de Cardiología pero nunca han consultado a un nutricionista
SELECT * 
FROM Paciente P
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
															WHERE E.descripcion = 'Nutricionista');


-- 10.Mostrarlos datos de los pacientes que se han atenido por todos los médico
SELECT *
FROM Paciente P
WHERE NOT EXISTS(SELECT 1
				 FROM Medico M
                 WHERE NOT EXISTS(SELECT 1
								  FROM Consulta C
                                  WHERE C.legpaciente = P.legajo
                                  AND COUNT(legmedico) >= 1);

-- 11.Informar los datos de los pacientes que han abonado mas de 1000 en total en el último trimestre (enero, febrero y marzo 2021)
SELECT *
FROM Paciente AS legajo
WHERE EXISTS(SELECT 1
			 FROM Consulta
             WHERE EXISTS (SELECT 1
						   FROM Medico
                           WHERE valor_consulta > 1000)
AND  

-- O TAMBIEN
SELECT P.legajo, P.nombre, P.apellido, SUM(M.valor_Consulta) AS 'Total'
FROM Paciente P
JOIN Consulta C
ON P.legajo = C.legPaciente
JOIN Medico M
ON C.legMedico = M.legajo
WHERE C.fecha BETWEEN '20210101' AND '20210331'
GROUP BY P.legajo, P.nombre, P.apellido








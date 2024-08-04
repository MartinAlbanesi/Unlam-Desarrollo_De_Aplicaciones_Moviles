CREATE DATABASE IF NOT EXISTS VideoClub;

CREATE TABLE IF NOT EXISTS Cliente (
    tipo_doc VARCHAR(40) NOT NULL,
    nro_doc INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    telefono INT NULL,
    domicilio VARCHAR(40) NOT NULL,
    edad INT NOT NULL,
    cod_localidad INT NOT NULL,
    t_doc_tit VARCHAR(40) NULL,
    n_doc_tit INT NULL,
    CONSTRAINT PK1 PRIMARY KEY (tipo_doc , nro_doc),
    CONSTRAINT FK1 FOREIGN KEY (t_doc_tit , n_doc_tit)
        REFERENCES Cliente (tipo_doc , nro_doc)
);
CREATE TABLE IF NOT EXISTS Proveedor (
	CUIT BIGINT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    domicilio VARCHAR(40) NULL,
    telefono INT NULL,
    mail VARCHAR(40) NULL,
    CONSTRAINT PK2 PRIMARY KEY (CUIT)
);
CREATE TABLE IF NOT EXISTS Pelicula (
	cod_pel VARCHAR(40) NOT NULL,
    titulo VARCHAR(40) NOT NULL,
    cod_genero INT NOT NULL,
    CUIT_prov BIGINT NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (cod_pel),
    CONSTRAINT FK2 FOREIGN KEY (CUIT_prov) REFERENCES Proveedor (CUIT)
);
CREATE TABLE IF NOT EXISTS Alquiler (
	cod_pel VARCHAR(40) NOT NULL,
    tipo_doc VARCHAR(40) NOT NULL,
    nro_doc INT NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (cod_pel, tipo_doc, nro_doc),
    CONSTRAINT FK3 FOREIGN KEY (cod_pel) references Pelicula (cod_pel),
    CONSTRAINT FK4 FOREIGN KEY (tipo_doc, nro_doc) references Cliente (tipo_doc, nro_doc)
);
CREATE TABLE IF NOT EXISTS Localidad (
	id_localidad INT NOT NULL,
    cod_postal INT NOT NULL,
    descripcion VARCHAR(40) NULL,
    CONSTRAINT PK5 PRIMARY KEY (id_localidad)
);
CREATE TABLE IF NOT EXISTS GeneroPelicula (
	id_genero INT NOT NULL,
    abreviatura VARCHAR(5) NULL,
    descripcion VARCHAR(40) NULL,
    CONSTRAINT PK6 PRIMARY KEY (id_genero)
);


ALTER TABLE Cliente DROP COLUMN domicilio;
ALTER TABLE Cliente ADD direccion_calle VARCHAR(40) NULL;
ALTER TABLE Cliente ADD direccion_numero INT NOT NULL;
ALTER TABLE Cliente ADD direccion_depto VARCHAR(40) NULL;
ALTER TABLE Cliente ADD direccion_piso INT NULL;
ALTER TABLE Cliente DROP COLUMN edad;
ALTER TABLE Cliente ADD fecha_nac DATE NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT FK5 FOREIGN KEY (cod_localidad) REFERENCES Localidad (id_localidad);
ALTER TABLE Pelicula ADD CONSTRAINT FK6 FOREIGN KEY (cod_genero) REFERENCES GeneroPelicula (id_genero);
ALTER TABLE Alquiler ADD fecha_devolucion DATE NOT NULL;
ALTER TABLE Alquiler ADD importe_alq DECIMAL (10,2) NOT NULL;

INSERT INTO Localidad VALUES
(1,'1753','villa luzuriaga'),
(2,'1752','Lomas Del Mirador'),
(3,'1754','San Justo'),
(4,'1778','Ciudad Evita'),
(5,'1785','Aldo Bonzi'),
(6,'1768','Ciudad Madero'),
(7,'1704','Ramos Mejia');

INSERT INTO Cliente (tipo_doc,nro_doc,nombre,telefono,direccion_calle,direccion_numero,direccion_piso,direccion_depto,cod_localidad,fecha_nac,t_doc_tit,n_doc_tit) VALUES
('DNI',1111,'Juan',111223344,'Arieta',1522,1,'A',1,19950501,null,null),
('DNI',2222,'Andres',111234556,'Arieta',3522,null,null,3,19851218,'DNI',1111),
('DNI',3333,'Marcela',111223355,'Avenida de mayo',522,4,'C',7,19990603,'DNI',1111),
('DNI',4444,'José',111234577,'Bolivar',650,6,41,7,19970204,null,null),
('DNI',5555,'Diego',111223399,'Rosales',322,1,'A',7,19790908,null,null),
('DNI',6666,'Mauro',null,'República de chile',3052,null,null,3,19961105,null,null),
('DNI',7777,'Karina',null,'Jujuy',3501,null,null,3,19990810,'DNI',6666),
('DNI',8888,'Valeria',111234556,'Alsina',155,3,'C',7,19870405,null,null),
('DNI',9999,'Lara',111234556,'República de chile',155,null,null,1,19990910,null,null);

INSERT INTO Proveedor VALUES
(23252221117,'Distribuidora1','Arieta 1555',54662200,'hola@hotmail.com'),
(45254544571,'Juan Perez',null,23523256,null),
(33665465410,'Andres Gonzalez',null,33665544,'hola@hotmail.com');

INSERT INTO GeneroPelicula VALUES
(1,'COM','Comedia'),
(2,'COMR','Comedia Romantica'),
(3,'ACC','Accion'),
(4,'AVE','Aventura'),
(5,'DRA','Drama'),
(6,'TER','Terror'),
(7,'MUS','Musical'),
(8,'CFIC','Ciencia Ficcion'),
(9,'BEL','Belica'),
(10,'INF','Infantil'),
(11,'SUSP','Suspenso');

INSERT INTO Pelicula VALUES
('A1','El Padrino',5,'23252221117'),
('A2','Cinema Paradiso',5,'23252221117'),
('A3','Forrest Gump',5,'23252221117'),
('A4','El Club De La Pelea',5,'33665465410'),
('A5','Mago De Oz',7,'45254544571'),
('A6','Cantando Bajo La lluvia',7,'45254544571'),
('A7','Dirty Dancing',7,'45254544571'),
('A8','Mouling Rouge',7,'45254544571'),
('A9','Toy Story 1',10,'33665465410'),
('A10','Ratatouille',10,'33665465410'),
('A11','Up',10,'23252221117'),
('A12','La Mascara',1,'23252221117'),
('A13','Loco Por Mary',1,'33665465410'),
('A14','Scary Movie',1,'33665465410'),
('A15','2001: Odisea del espacio',8,'23252221117'),
('A16','E.T El Extraterrestre',8,'23252221117'),
('A17','Matrix',8,'23252221117'),
('A18','Indiana Jones: En busca del arca perdida',4,'33665465410'),
('A19','Cuenta Conmigo',4,'33665465410'),
('A20','Naufrago',4,'33665465410'),
('A21','Senderos De Gloria',9,'23252221117'),
('A22','La Vida Es Bella',9,'23252221117');

INSERT INTO Alquiler VALUES
('A5','DNI',2222,'2021/05/02','2021/05/03',150),
('A6','DNI',2222,'2021/02/23','2021/02/24',300),
('A12','DNI',3333,'2021/05/09','2021/05/12',300),
('A17','DNI',4444,'2021/01/04','2021/01/05',150),
('A20','DNI',3333,'2021/05/05','2021/05/06',150),
('A17','DNI',3333,'2021/05/05','2021/05/06',150),
('A20','DNI',7777,'2021/02/24','2021/02/25',150),
('A12','DNI',8888,'2021/04/19','2021/04/21',250),
('A19','DNI',3333,'2021/02/03','2021/02/05',250),
('A7','DNI',7777,'2021/01/19','2021/01/22',300),
('A8','DNI',2222,'2021/04/19','2021/04/20',150),
('A20','DNI',2222,'2021/01/29','2021/01/30',150),
('A12','DNI',7777,'2021/01/18','2021/01/19',150),
('A7','DNI',8888,'2021/04/08','2021/04/09',150),
('A6','DNI',9999,'2021/02/24','2021/02/25',150),
('A5','DNI',7777,'2021/03/29','2021/03/31',250);


-- 1. Informar los géneros que no tuvieron películas alquiladas
SELECT *
FROM GeneroPelicula AS gen
WHERE id_genero NOT IN (SELECT pel.cod_genero
						FROM Pelicula AS pel
						INNER JOIN Alquiler AS alq
						ON pel.cod_pel = alq.cod_pel);
                        
/*Otra forma de hacerlo (NOT EXISTS)*/
SELECT *
FROM GeneroPelicula AS gen
WHERE NOT EXISTS (SELECT 1
				  FROM Pelicula AS pel
				  INNER JOIN Alquiler AS alq
				  ON pel.cod_pel = alq.cod_pel
				  WHERE gen.id_genero = pel.cod_genero);

-- 2. Informar los géneros que tienen películas pero que no registran alquileres
SELECT *
FROM GeneroPelicula AS gen
WHERE NOT EXISTS (SELECT 1
				  FROM Pelicula AS pel
				  INNER JOIN Alquiler AS alq
				  ON pel.cod_pel = alq.cod_pel
				  WHERE gen.id_genero = pel.cod_genero)
AND 	  EXISTS (SELECT 1
				  FROM Pelicula AS pel1
                  WHERE pel1.cod_genero = gen.id_genero);

-- 3. Se desea conocer los clientes que devolvieron la película con una demora mayor al promedio de los alquileres.
SELECT DISTINCT cli.tipo_doc, cli.nro_doc, cli.nombre
FROM Cliente AS cli
INNER JOIN Alquiler AS alq
ON cli.nro_doc = alq.nro_doc
WHERE DATEDIFF(fecha_devolucion,fecha) >= 	(SELECT AVG (DATEDIFF(fecha_devolucion,fecha))
											FROM Alquiler);

-- 4. Informar las películas que no fueron alquiladas por el cliente con DNI 2222
SELECT *
FROM Pelicula AS pel
WHERE pel.cod_pel NOT IN (SELECT alq.cod_pel
						  FROM Alquiler AS alq
                          WHERE nro_doc = 2222);

-- 5. Informar el género con mayor recaudación
SELECT gen1.id_genero, gen1.descripcion, SUM(alq1.importe_alq)
FROM GeneroPelicula AS gen1
INNER JOIN Pelicula AS pel1
ON gen1.id_genero = pel1.cod_genero
INNER JOIN Alquiler AS alq1
ON pel1.cod_pel = alq1.cod_pel
GROUP BY gen1.id_genero, gen1.descripcion
HAVING SUM(alq1.importe_alq) >= ALL (SELECT SUM(alq.importe_alq)
									FROM Alquiler AS alq
									INNER JOIN Pelicula AS pel
									ON pel.cod_pel = alq.cod_pel
									GROUP BY pel.cod_genero);

-- 6. Se desea conocer el detalle de las películas que nunca se alquilaron
SELECT *
FROM Pelicula AS pel
WHERE pel.cod_pel NOT IN (SELECT alq.cod_pel
					  	  FROM Alquiler AS alq);

-- 7. Se desea conocer el detalle de los clientes que nunca han realizado alquileres.
SELECT *
FROM Cliente AS cli
WHERE cli.nro_doc NOT IN (SELECT alq.nro_doc
						  FROM Alquiler AS alq);
                          
/*Otra forma de hacerlo (NOT EXISTS)*/
SELECT *
FROM Cliente AS cli
WHERE NOT EXISTS 	(SELECT 1
					FROM Alquiler AS alq
					WHERE cli.nro_doc = alq.nro_doc 
					AND cli.tipo_doc = alq.tipo_doc);

-- 8. Informar los códigos de películas coincidentes entre el cliente con DNI 2222 y DNI 3333
SELECT alq.cod_pel
FROM Alquiler AS alq
WHERE alq.nro_doc = 3333 and alq.cod_pel IN (SELECT alq1.cod_pel
											FROM Alquiler AS alq1
											WHERE alq1.nro_doc = 2222);

-- 9. Informar los clientes que realizaron mas del promedio de alquileres
SELECT tipo_doc, nro_doc, COUNT(*)
FROM Alquiler
GROUP BY tipo_doc, nro_doc
HAVING COUNT(*) >= (SELECT COUNT(*) / COUNT(DISTINCT tipo_doc + nro_doc)
					FROM Alquiler);


-- INTERSECCION (NO ES PARTE DEL TP)
SELECT a.cod_pel
FROM (SELECT cod_pel
	  FROM Alquiler
      WHERE nro_doc = 2222) A (cod_pel)
INNER JOIN
	  (SELECT cod_pel
       FROM Alquiler
       WHERE nro_doc = 3333) B (cod_pel)
ON a.cod_pel = b.cod_pel;
       
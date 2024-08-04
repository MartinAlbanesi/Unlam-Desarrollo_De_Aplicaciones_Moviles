CREATE DATABASE IF NOT EXISTS AlmacenEj1;

CREATE TABLE IF NOT EXISTS Almacen (
    nro_alm INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    responsable VARCHAR(40) NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY (nro_alm)
);
CREATE TABLE IF NOT EXISTS Articulo (
	cod_art INT NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    precio DECIMAL (10,2) NOT NULL,	
    CONSTRAINT PK2 PRIMARY KEY (cod_art)
);
CREATE TABLE IF NOT EXISTS Material (
	cod_mat INT NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY (cod_mat)
);
CREATE TABLE IF NOT EXISTS Ciudad (
	cod_ciu INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (cod_ciu)
);
CREATE TABLE IF NOT EXISTS Proveedor (
	cod_prov INT NOT NULL,
    nombre VARCHAR(40) NULL,
    domicilio VARCHAR(40) NULL,
	cod_ciu INT NOT NULL,
    fecha_alta DATE NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (cod_prov),
    CONSTRAINT FK1 FOREIGN KEY (cod_ciu) REFERENCES Ciudad (cod_ciu)
);
CREATE TABLE IF NOT EXISTS Contiene (
	nro_alm INT NOT NULL,
    cod_art INT NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY (nro_alm, cod_art),
    CONSTRAINT FK2 FOREIGN KEY (nro_alm) REFERENCES Almacen (nro_alm),
    CONSTRAINT FK3 FOREIGN KEY (cod_art) REFERENCES Articulo (cod_art)
);
CREATE TABLE IF NOT EXISTS Compuesto_por (
	cod_art INT NOT NULL,
    cod_mat INT NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY (cod_art, cod_mat),
    CONSTRAINT FK4 FOREIGN KEY (cod_art) REFERENCES Articulo (cod_art),
    CONSTRAINT FK5 FOREIGN KEY (cod_mat) REFERENCES Material (cod_mat)
);
CREATE TABLE IF NOT EXISTS Provisto_por (
	cod_mat INT NOT NULL,
    cod_prov INT NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY (cod_mat, cod_prov),
    CONSTRAINT FK6 FOREIGN KEY (cod_mat) REFERENCES Material (cod_mat),
    CONSTRAINT FK7 FOREIGN KEY (cod_prov) REFERENCES Proveedor (cod_prov)
);



-- 1. Listar los números de artículos cuyo precio se encuentre entre $100 y $1000 y su descripción comience con la letra A.
SELECT cod_art, precio
FROM Articulo
WHERE precio BETWEEN 100 AND 1000
AND descripcion LIKE('A%');

-- 2. Listar todos los datos de todos los proveedores
SELECT *
FROM Proveedor;

-- 3. Listar la descripción de los materiales de código 1, 3, 6, 9 y 18.
SELECT descripcion
FROM Material
WHERE cod_mat IN (1, 3, 6, 9, 18);

-- 4. Listar código y nombre de proveedores de la calle Suipacha, que hayan sido dados de alta en el año 2001.
SELECT cod_prov, nombre
FROM Proveedor
WHERE domicilio = 'Suipacha' 
AND fecha_alta >= '20010101' AND fecha_alta < '20020101';

-- 5. Listar nombre de todos los proveedores y de su ciudad.
SELECT prov.nombre, ciu.nombre
FROM Proveedor AS prov
INNER JOIN Ciudad AS ciu
ON prov.cod_ciu = ciu.cod_ciu;

-- 6. Listar los nombres de los proveedores de la ciudad de La Plata.
SELECT prov.nombre
FROM Proveedor AS prov
INNER JOIN Ciudad AS ciu
ON prov.cod_ciu = ciu.cod_ciu
WHERE ciu.nombre = 'La Plata';

-- 7. Listar los números de almacenes que almacenan el artículo de descripción A.
SELECT nro_alm
FROM Almacen AS alm
INNER JOIN Contiene AS cont
ON alm.nro_alm = cont.nro_alm
INNER JOIN Articulo AS art
ON cont.cod_art = art.cod_art
WHERE art.descripcion = 'A';

-- 8. Listar los materiales (código y descripción) provistos por proveedores de la ciudad de Rosario.
SELECT mat.cod_mat, mat.descripcion
FROM Material AS mat
INNER JOIN Provisto_por AS por
ON mat.cod_mat = por.cod_mat
INNER JOIN Proveedor AS prov
ON por.cod_prov = prov.cod_prov
INNER JOIN Ciudad AS ciu
ON prov.cod_ciu = ciu.cod_ciu
WHERE ciu.nombre = 'Rosario';

-- 9. Listar los nombres de los proveedores que proveen materiales para artículos ubicados en almacenes que Martín Gómez tiene a su cargo
/*
SELECT prov.nombre
FROM Proveedor AS prov
WHERE prov.cod_prov IN (SELECT por.cod_prov 
						FROM Provisto_por AS por
						WHERE prov.cod_prov = por.cod_prov )
                        AND por.cod_mat IN (SELECT mat.cod_mat
											FROM Material AS mat
                                            WHERE por.cod_mat = mat.cod_mat)
                                            AND mat.cod_mat IN (SELECT comp.cod_mat
																FROM Compuesto_por AS comp
																WHERE mat.cod_mat = comp.cod_mat)
                                                                AND comp.cod_art IN (SELECT art.cod_art
																					 FROM Articulo AS art
                                                                                     WHERE comp.cod_art = art.cod_art)
                                                                                     AND art.cod_art IN (SELECT cont.cod_art
																										 FROM Contiene AS cont
																										 WHERE art.cod_art = cont.cod_art)
                                                                                                         AND cont.nro_alm IN (SELECT alm.nro_alm
																															  FROM Almacen AS alm
                                                                                                                              WHERE cont.nro_alm = alm.nro_alm
                                                                                                                              AND responsable = 'Martin Gomez');

SELECT responsable
FROM Almacen
WHERE responsable = 'Martin Gomez';
*/

-- 10. Mover los artículos almacenados en el almacén de número 10 al de número 20


-- 11. Eliminar a los proveedores que contengan la palabra ABC en su nombre
DELETE FROM Proveedor 
WHERE nombre LIKE '%ABC%';

-- 12. Indicar la cantidad de proveedores que comienzan con la letra F.
SELECT COUNT(cod_prov)
FROM Proveedor
WHERE nombre LIKE '%F';

-- 13. Listar el promedio de precios de los artículos por cada almacén (nombre)
SELECT AVG (art.precio) AS Promedio, alm.nombre
FROM Articulo AS art
INNER JOIN Contiene AS cont
ON art.cod_art = cont.cod_art
INNER JOIN Almacen AS alm
ON cont.nro_alm = alm.nro_alm
GROUP BY alm.nombre;

-- 14. Listar la descripción de artículos compuestos por al menos 2 materiales.
SELECT art.descripcion, COUNT(*) AS Materiales
FROM Compuesto_por AS comp
INNER JOIN Articulo AS art
ON comp.cod_art = art.cod_art
GROUP BY comp.cod_art, descripcion
HAVING COUNT(*) >= 2;

-- 15. Listar cantidad de materiales que provee cada proveedor (código, nombre y domicilio)
SELECT prov.cod_prov, prov.nombre, prov.domicilio, COUNT(*) AS Cant_Provee
FROM Proveedor AS prov
INNER JOIN Provisto_por AS por
ON prov.cod_prov = por.cod_prov
GROUP BY prov.cod_prov, prov.nombre, prov.domicilio;

-- 16. Cuál es el precio máximo de los artículos que proveen los proveedores de la ciudad de Zárate.
SELECT prov.cod_prov, prov.nombre, prov.domicilio, MAX(precio) AS Precio_Maximo
FROM Proveedor AS prov
INNER JOIN Provisto_por AS por
ON prov.cod_prov = por.cod_prov
INNER JOIN Compuesto_por AS comp
ON por.cod_mat = comp.cod_mat
INNER JOIN Articulo AS art
ON comp.cod_art = art.cod_art
INNER JOIN Ciudad AS ciu
ON ciu.cod_ciu = prov.cod_ciu
WHERE ciu.nombre = 'Zarate'
GROUP BY prov.cod_prov, prov.nombre, prov.domicilio;


-- 17. Listar los nombres de aquellos proveedores que no proveen ningún material.
SELECT prov.nombre
FROM Proveedor AS prov
WHERE NOT EXISTS (SELECT *
				  FROM Provisto_por AS por
                  WHERE por.cod_prov = prov.cod_prov);

-- 18. Listar los códigos de los materiales que provea el proveedor 10 y no los provea el proveedor 15.
SELECT cod_mat
FROM Material AS mat
WHERE EXISTS (SELECT 1
			  FROM Provisto_por AS por
			  WHERE mat.cod_mat = por.cod_mat AND por.cod_prov = 10)
              AND NOT EXISTS (SELECT 1
							  FROM Provisto_por AS por2
                              WHERE por2.cod_mat = mat.cod_mat AND por2.cod_prov = 15);

-- 19. Listar número y nombre de almacenes que contienen los artículos de descripción A y los de descripción B (ambos).
SELECT alm.nro_alm, alm.nombre
FROM Contiene AS cont
INNER JOIN Almacen AS alm
ON cont.nro_alm = alm.nro_alm
INNER JOIN Articulo AS art
ON cont.cod_art = art.cod_art
WHERE art.descripcion LIKE '%A%';

-- 21. Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo cuyo precio es mayor a $100.
select p.nombre, p.cod_prov
from proveedor p
inner join provisto_por pp
on pp.cod_prov = p.cod_prov
inner join compuesto_por cp
on cp.cod_mat=pp.cod_mat
inner join articulo a
on cp.cod_art=a.cod_art
where a.precio > 100;

-- 22. Listar la descripción de los artículos de mayor precio
Select descripcion 
from articulo
where precio >=  (select avg(precio)
from articulo) 
or
Select descripcion 
from articulo
where precio in (select max(precio)
from articulo) ;

-- 23. Listar los nombres de proveedores de Capital Federal que sean únicos proveedores de algún material.
select p.nombre 
from proveedor p
inner join ciudad c
on p.cod_ciu =c.cod_ciu
where c.nombre="ramos" and cod_prov in(select p.cod_prov
                                       from provisto_por pp
                                       inner join proveedor p
                                       on p.cod_prov=pp.cod_prov
                                       group by cod_prov
                                       having count(cod_mat)=1);

-- 26. Listar los números de almacenes que tienen todos los artículos que incluyen el material con código 123.
select nro_alm , COUNT(*) AS Cantidad_Almacenes
from Contiene AS cont
INNER JOIN (SELECT cod_art
			FROM Compuesto_por
            WHERE cod_mat = 2) AS a (cod_art)
ON cont.cod_art = a.cod_art
GROUP BY nro_alm
HAVING COUNT(*) = (SELECT COUNT(DISTINCT cod_art)
				   FROM Compuesto_por
                   WHERE cod_mat = 2);



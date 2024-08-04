/*Select2.sql*/

/*1. Listar todas las películas y la descripción del género de cada una*/
SELECT 
    pel.cod_pel, pel.id_genero, gen.descripcion
FROM
    pelicula AS pel
        JOIN
    generopelicula AS gen ON pel.id_genero = gen.idgenero;
    
/*2. Informar Nombre, Fecha de Nacimiento y Descripción de la localidad, de todos los clientes de San Justo 
y Ramos Mejía*/

SELECT 
    cli.nombre, cli.f_nacimiento, loc.descripcion
FROM
    cliente AS cli
        INNER JOIN
    localidad AS loc ON cli.localidad = loc.id
WHERE
    loc.descripcion LIKE 'San Justo'
        OR loc.descripcion LIKE 'Ramos Mejia'; 

/*3. Listar el Nombre y género de las películas que fueron alquiladas en algún momento, ordenadas por 
descripción del género y fecha de alquiler*/

SELECT 
    alq.cod_pel, pel.titulo, gen.descripcion
FROM
    alquiler AS alq
        INNER JOIN
    pelicula AS pel ON alq.cod_pel = pel.cod_pel JOIN 
    generopelicula AS gen ON gen.idgenero = pel.id_genero
ORDER BY alq.fecha , gen.descripcion; 


/*4. Listar el Nombre y género de las películas que nunca fueron alquiladas*/
SELECT 
    alq.cod_pel, pel.titulo
FROM
    alquiler AS alq
        RIGHT JOIN
    pelicula AS pel ON alq.cod_pel = pel.cod_pel JOIN 
    generopelicula AS gen ON gen.idgenero = pel.id_genero
    where alq.cod_pel IS NULL
ORDER BY alq.fecha , gen.descripcion; 


/*5. Listar el nombre de los clientes que tardaron mas de un día en devolver alguna película alquilada*/
SELECT 
    cli.nombre
FROM
    alquiler AS alq
        INNER JOIN
    cliente AS cli ON alq.nro_doc = cli.nro_doc
WHERE
    DATEDIFF(alq.fecha_devolucion, alq.fecha) > 1;
   
/*6. Listar el nombre de la película, y el nombre del proveedor que la provee, ordenado por nombre del 
proveedor.*/
select pel.titulo as p_nombre , pro.nombre  
FROM pelicula as pel inner join proveedor as pro 
on pel.CUIT_prov = pro.CUIT 
ORDER BY pro.nombre;

/*7. Listar el tipo y número de documento, de los clientes que alquilaron alguna comedia*/
SELECT 
    alq.tipo_doc, alq.nro_doc, gen.descripcion
FROM
    alquiler AS alq
        INNER JOIN
    pelicula AS pel ON alq.cod_pel = pel.cod_pel
        JOIN
    generopelicula AS gen ON gen.idgenero = pel.id_genero
WHERE
    gen.descripcion LIKE 'Comedia' ;
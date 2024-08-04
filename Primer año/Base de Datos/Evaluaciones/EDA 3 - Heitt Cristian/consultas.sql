-- A. Listar el número y fecha de inicio, de aquellos proyectos sin empleados asignados
select nro numero, fecha_inicio "Fecha de inicio"
from proyecto p
where not exists(select 1
				 from proyecto_empleado pe
                 where pe.nro_proyecto = p.nro);
-- B. Mostrar el nombre de empleados que trabajan en todos los proyectos
select e.nombre
from empleado e join proyecto_empleado pe
				on pe.legajo_empleado = e.legajo
group by e.legajo
having count(1) = (select count(1) from proyecto);
-- C. Cuántos proyectos se realizaron para el cliente ‘Juan Lopez’ durante enero de 2020?
select count(1) "Proyectos realizados"
from proyecto
where cod_cli = (select cod_cli
				 from cliente
				where nombre = 'Juan Lopez');
-- D. Luis Suarez comienza a trabajar hoy en la empresa, con un sueldo de $50000. Su legajo será el 9467. Agregar el nuevo empleado a la base de datos
insert into empleado(legajo,nombre,sueldo) values (9467,'Luis Suarez',50000);
-- E. Listar el nombre y sueldo de aquellos empleados que comienzan con la letra ‘A’, ganan entre $50000 y $100000 (ambos inclusive) y trabajan en algún proyecto iniciado en el año 2019
select nombre,sueldo
from empleado e
where nombre like 'A%'
	and sueldo between 50000 and 100000
    and exists (select 1
				from proyecto_empleado pe join proyecto p on p.nro = pe.nro_proyecto
                where p.fecha_inicio between '2019-01-01' and '2019-12-31'
					and pe.legajo_empleado = e.legajo);
-- F. Aumentar un 10% el sueldo de los empleados que trabajan en 2 proyectos o más
update empleado 
set sueldo = sueldo * 1.1 
where legajo in (select legajo_empleado
				 from proyecto_empleado
				 group by legajo_empleado
				 having count(1) >= 2);
-- G. Indicar el importe promedio de proyectos, por cada localidad del mismo (descripción). Sólo mostrar aquellos donde el promedio sea superior a 200000
select l.descripcion localidad, avg(importe) promedio
from proyecto p join localidad l on p.cod_loc = l.cod_loc
group by p.cod_loc
having avg(importe) > 200000;
-- H. Eliminar a todos los proyectos de la localidad de Ramos Mejía.
begin;
delete from proyecto_empleado where nro_proyecto in (select nro
								   from proyecto
								   where cod_loc = (select cod_loc 
													 from localidad
													 where descripcion = 'Ramos Mejia')
									);
delete from proyecto where cod_loc = (select cod_loc 
									  from localidad
									  where descripcion = 'Ramos Mejia');
commit;
-- I. Listar la descripción e importe de aquellos proyectos ubicados en la misma localidad que el cliente contratante. Ordenarlos por importe, de mayor a
-- menor. Si hubiera 2 clientes con el mismo importe, ordenarlos por descripción alfabéticamente
select p.descripcion,p.importe
from proyecto p join cliente c on c.cod_cli = p.cod_cli
where p.cod_loc = c.cod_loc
order by importe desc, descripcion;
-- J. Se requiere registrar por cada cliente, su fecha de nacimiento. Realizar una sentencia SQL para hacer los cambios correspondientes a la estructura de base de datos
alter table cliente add column fecha_nac date;
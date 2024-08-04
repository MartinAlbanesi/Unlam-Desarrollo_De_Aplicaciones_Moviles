insert into localidad(cod_loc,descripcion) values (1,'San Justo'),
												  (2,'Ramos Mejia'),
                                                  (3,'Moron'),
                                                  (4,'Castelar'),
                                                  (5,'Haedo');
											
insert into empleado(legajo,nombre,sueldo) values (10,'Juan',75000.00),
												  (11,'Raul',65000.00),
												  (12,'Mr. Bean', 100000.00),
                                                  (13,'Esclavo1',30000.00),
                                                  (14,'Esclavo2',45000.00),
                                                  (15,'Agustin',50000.00);

insert into cliente(cod_cli,nombre,domicilio,cod_loc) values (205,'Cliente1','Cuenca 123',2),
															 (485,'Cliente2','Pozo 435',4),
                                                             (123,'Cliente3','Paso 1234',1),
                                                             (546,'Cliente4','Rivadavia 26000',3),
                                                             (999,'Cliente5','Rivadavia 20000',5),
                                                             (100,'Juan Lopez','Av. Siempre viva 123',1);
                                                             
insert into proyecto(nro,fecha_inicio,descripcion,importe,domicilio,cod_loc,cod_cli) values (150,'2020-01-20','Proyecto1',100000,'Av. proyecto1',1,100),
																							(151,'2020-01-25','Proyecto2',150000,'Av. proyecto2',2,100),
                                                                                            (175,'2020-03-20','Proyecto3',200000,'Av. proyecto3',2,205),
                                                                                            (176,'2020-06-20','Proyecto4',600000,'Av. proyecto4',4,123),
                                                                                            (177,'2020-07-20','Proyecto5',300000,'Av. proyecto5',5,999),
                                                                                            (100,'2019-01-20','Test',100000,'Empedrado',1,100);
                                                                                            

insert into proyecto_empleado(nro_proyecto,legajo_empleado) values (150,12),
																   (151,12),
																   (175,12),
                                                                   (176,12),
                                                                   (177,12),
                                                                   (176,10),
                                                                   (150,14),
                                                                   (151,13),
                                                                   (151,14),
																   (175,14),
                                                                   (176,14),
                                                                   (177,14),
                                                                   (100,15);
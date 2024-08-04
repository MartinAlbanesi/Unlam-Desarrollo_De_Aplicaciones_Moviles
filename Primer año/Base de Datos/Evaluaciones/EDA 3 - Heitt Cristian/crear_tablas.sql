create table localidad (cod_loc int,
						descripcion varchar(50) not null,
                        constraint primary key (cod_loc)
                        );

create table empleado (legajo int,
						nombre varchar(50),
						sueldo decimal(8,2),
                        constraint primary key (legajo)
                        );

create table cliente (cod_cli int,
					  nombre varchar(50) not null,
                      domicilio varchar(50) not null,
                      cod_loc int,
                      constraint primary key (cod_cli),
                      constraint foreign key (cod_loc) references localidad(cod_loc)
                      );

create table proyecto (nro int,
						fecha_inicio date not null,
                        descripcion varchar(50) not null,
                        importe decimal(10,2) not null,
                        domicilio varchar(75) not null,
                        cod_loc int,
                        cod_cli int,
                        constraint primary key (nro),
                        constraint foreign key (cod_loc) references localidad(cod_loc),
                        constraint foreign key (cod_cli) references cliente(cod_cli)
						);
                        
create table proyecto_empleado (nro_proyecto int,
								legajo_empleado int,
                                constraint primary key (nro_proyecto, legajo_empleado),
                                constraint foreign key (nro_proyecto) references proyecto(nro),
                                constraint foreign key (legajo_empleado) references empleado(legajo)
								);
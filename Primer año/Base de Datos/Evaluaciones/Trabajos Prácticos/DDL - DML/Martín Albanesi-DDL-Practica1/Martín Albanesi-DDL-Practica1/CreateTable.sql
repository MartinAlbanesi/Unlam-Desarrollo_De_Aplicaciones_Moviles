CREATE DATABASE if not exists VideoClub;
CREATE TABLE if not exists Cliente (
	tipo_doc varchar(40) not null,
	nro_doc int not null,
	nombre varchar(40) not null,
	telefono int not null,
	domicilio varchar(40) not null,
	edad int not null,
	t_doc_tit varchar(40) not null,
	n_doc_tit int not null,
    constraint PK1 primary key (tipo_doc, nro_doc),
	constraint FK1 foreign key (t_doc_tit, n_doc_tit) references Cliente (tipo_doc,nro_doc)
);
CREATE TABLE if not exists Proveedor (
	CUIT int not null,
    nombre varchar(40) not null,
    domicilio varchar(40) not null,
    telefono int not null,
    mail varchar(40) not null,
    constraint PK2 primary key (CUIT)
);
CREATE TABLE if not exists Pelicula (
	cod_pel int not null,
    titulo varchar(40) not null,
    genero varchar(40) not null,
    CUIT_prov int not null,
    constraint PK3 primary key (cod_pel),
    constraint FK2 foreign key (CUIT_prov) references Proveedor (CUIT)
);
CREATE TABLE if not exists Alquiler (
	cod_pel int not null,
    tipo_doc varchar(40) not null,
    nro_doc int not null,
    fecha date not null,
    constraint PK4 primary key (cod_pel, tipo_doc, nro_doc),
    constraint FK3 foreign key (cod_pel) references Pelicula (cod_pel),
    constraint FK4 foreign key (tipo_doc, nro_doc) references Cliente (tipo_doc, nro_doc)
);
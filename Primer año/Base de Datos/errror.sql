CREATE SCHEMA `videoclub` ;

USE videoclub;
CREATE TABLE Cliente (
    tipo_doc VARCHAR(3),
    nro_doc BIGINT,
    nombre VARCHAR(40),
    domicilio VARCHAR(40),
    edad INT,
    t_doc_tit VARCHAR(3),
    n_doc_tit BIGINT,
    CONSTRAINT cliente_pk PRIMARY KEY (tipo_doc , nro_doc),
    CONSTRAINT FK1 FOREIGN KEY (t_doc_tit , n_doc_tit)
        REFERENCES Cliente (tipo_doc , nro_doc)
);

CREATE TABLE Proveedor (
    CUIT BIGINT,
    nombre VARCHAR(40),
    domicilio VARCHAR(40),
    telefono VARCHAR(40),
    mail VARCHAR(40),
    CONSTRAINT fk_proveedor PRIMARY KEY (CUIT)
);

CREATE TABLE Pelicula (
    cod_pel varchar(3),
    titulo VARCHAR(40),
    id_genero INT,
    CUIT_prov BIGINT,
    CONSTRAINT pk_pelicula PRIMARY KEY (cod_pel),
    CONSTRAINT fk_pelicula FOREIGN KEY (CUIT_prov)
        REFERENCES Proveedor (CUIT)
);

CREATE TABLE Alquiler (
    cod_pel VARCHAR(3),
    tipo_doc VARCHAR(3),
    nro_doc BIGINT,
    fecha DATE,
    CONSTRAINT pk_alquiler PRIMARY KEY (cod_pel , tipo_doc , nro_doc , fecha));
    
ALTER TABLE alquiler ADD FOREIGN KEY (tipo_doc,nro_doc) references pelicula(cod_pel);
ALTER TABLE alquiler ADD FOREIGN KEY (tipo_doc,nro_doc) references cliente(tipo_doc,nro_doc);


/*alter sql2*/
CREATE TABLE Localidad (
    id INT PRIMARY KEY,
    cod_postal INT,
    descripcion VARCHAR(40)
);

CREATE TABLE GeneroPelicula (
    idGenero INT PRIMARY KEY,
    abreviatura VARCHAR(5),
    descripcion VARCHAR(40)
);

/*alter table sql*/
ALTER TABLE cliente DROP COLUMN domicilio;
ALTER TABLE cliente DROP COLUMN edad;
ALTER TABLE cliente ADD d_calle varchar(20);
ALTER TABLE cliente ADD d_numero smallint;
ALTER TABLE cliente ADD d_dto VARCHAR(3);
ALTER TABLE cliente ADD d_piso tinyint;
ALTER TABLE cliente ADD localidad int;
ALTER TABLE cliente add telefono bigint ;
ALTER TABLE cliente ADD FOREIGN KEY (localidad) references localidad(id);
ALTER TABLE pelicula ADD id_genero int;
ALTER TABLE pelicula ADD FOREIGN KEY (id_genero) references generopelicula(idGenero);
ALTER TABLE alquiler ADD importe decimal(10,2);
ALTER TABLE alquiler ADD fecha_devolucion DATE;

/*CARGA DE DATOS*/
INSERT INTO localidad (id,cod_postal,descripcion) VALUES
(1,1753,"Villa Luzuriaga") , (2,1752, "Lomas del Mirador"),
(3,1754,"San Justo"), (4,1778,"Ciudad Evita"), 
(5,1785,"Aldo Bonzi") , (6,1768,"Ciudad Madero") ,(7,1704, "Ramos Mejia");

INSERT INTO proveedor (CUIT,nombre,domicilio,telefono,mail) VALUES 
(23252221117,"Distribuidora1","Arieta 1555",54662200,"hola@hotmail.com"),
(45254544571,"Juan Perez", null, 23523256, null),
(33665465410,"Andres Gonzalez",null,33665544,"andres@gmail.com") ;

INSERT INTO cliente (tipo_doc, nro_doc, nombre, telefono, d_calle, d_numero, d_piso,d_dto ,localidad, f_nacimiento, t_doc_tit, n_doc_tit) VALUES
("DNI",1111,"Juan",111223344,"Arieta",1522,1,"A",1,'19950501',NULL,NULL),
("DNI",2222,"Andres",111234556,"Arieta",3522,NULL,NULL,3,'19851218',"DNI",1111),
("DNI",3333,"Marcela",111223355,"Avenida de mayo",522,4,"C",7,'19990603',"DNI",1111),
("DNI",4444,"José",111234577,"Bolivar",650,6,41,7,'19770204',NULL,NULL),
("DNI",5555,"Diego",111223399,"Rosales",322,1,"A",7,'19790908',NULL,NULL),
("DNI",6666,"Mauro",NULL,"Republica de Chile",3052,NULL,NULL,3,'19961105',NULL,NULL),
("DNI",7777,"Karina",NULL,"Jujuy",3501,NULL,NULL,3,'19990810',"DNI",6666),
("DNI",8888,"Valeria",111234556,"Alsina",155,3,"C",7,'19870405',NULL,NULL),
("DNI",9999,"Lara",111234556,"Republica de Chile",155,NULL,NULL,1,'19990910',NULL,NULL); 

INSERT INTO generopelicula (idgenero, abreviatura, descripcion) VALUES
(1,"COM","Comedia") , (2,"COMR","Comedia Romantica") , (3,"ACC","Accion"), (4,"AVE","Aventura"), (5,"DRA","Drama"), (6,"TER","Terror"),
(7,"MUS","Musical"), (8,"CIFC","Ciencia Ficcion"), (9,"BEL","Bélica"), (10,"INF","Infantil"), (11,"SUSP","Suspenso");         


INSERT INTO pelicula (cod_pel, titulo, id_genero, CUIT_prov) VALUES
("A1","El padrino",5,23252221117),("A2","Cinema Paradiso",5,23252221117), ("A3","Forrest Gump",5,33665465410), ("A6","Cantando bajo la lluvia",7,45254544571),
("A8","Moulin Rouge",7,45254544571), ("A9","Toy Story 1",10,33665465410), ("A10","Ratatuille",10,33665465410), 
("A11", "Up", 10 , 33665465410), ("A12","La máscara",1,	23252221117), ("A13", "Loco por Mary",1,"33665465410"),
("A14","Scary Movie",1,33665465410), ("A15","2001:Odisea del espacio",8, 23252221117 ),
("A16","E.T. el extraterrestre",8,23252221117), ("A17","Matrix",8,23252221117),
("A18","Indiana Jones: en busca del arca perdida",4,33665465410), 
("A19","Cuenta conmigo",4,23252221117), ("A20","Naufrago",4,33665465410),
("A21","Senderos de gloria",9,23252221117), ("A22","La vida es bella",9,23252221117);




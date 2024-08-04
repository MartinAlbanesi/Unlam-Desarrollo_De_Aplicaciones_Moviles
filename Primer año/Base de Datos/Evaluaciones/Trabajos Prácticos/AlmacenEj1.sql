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
CREATE TABLE IF NOT EXISTS Proveedor (
	cod_prov INT NOT NULL,
    nombre VARCHAR(40) NULL,
    domicilio VARCHAR(40) NULL,
	cod_ciu INT NOT NULL,
    fecha_alta DATE NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY (cod_prov),
    CONSTRAINT FK1 FOREIGN KEY (cod_ciu) REFERENCES Ciudad (cod_ciu)
);
CREATE TABLE IF NOT EXISTS Ciudad (
	cod_ciu INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (cod_ciu)
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
    CONSTRAINT FK2 FOREIGN KEY (cod_mat) REFERENCES Material (cod_mat),
    CONSTRAINT FK3 FOREIGN KEY (cod_prov) REFERENCES Proveedor (cod_prov)
);


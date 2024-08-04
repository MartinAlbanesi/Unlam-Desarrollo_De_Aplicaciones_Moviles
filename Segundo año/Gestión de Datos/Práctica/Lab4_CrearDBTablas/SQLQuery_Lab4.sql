-- 1.
IF NOT EXISTS(SELECT * FROM sys.databases WHERE NAME = 'MusicaDB')
CREATE DATABASE MusicaDB ON PRIMARY
( NAME = 'Musica',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Musica.mdf' ,
SIZE = 4096KB ,
MAXSIZE = 20480KB ,
FILEGROWTH = 1024KB
)
 LOG ON
( NAME = 'Musica_log',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Musica_log.ldf' ,
SIZE = 2048KB ,
MAXSIZE = 10240KB ,
FILEGROWTH = 10%
);

-- 2.1. ?
-- 2.2. Si, se crean estadísticas automáticamente
-- 2.3. No
-- 2.4. Modern_Spanish_CI_AS : provee propiedades para los datos de reglas de ordenamiento, mayúsculas y acentuación.

-- 3.
IF NOT EXISTS(SELECT * FROM sys.schemas WHERE NAME = N'Discos')
EXEC('CREATE SCHEMA Discos')
GO;

-- 4.
IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Artista' AND TYPE = 'U')
CREATE TABLE Discos.Artista(
 artno SMALLINT NOT NULL,
 nombre VARCHAR(50) NULL,
 clasificacion CHAR(1) NULL,
 bio TEXT NULL,
 foto VARBINARY(MAX) null,
 CONSTRAINT PK_Artista PRIMARY KEY CLUSTERED (artno)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Album' AND TYPE = 'U')
CREATE TABLE Discos.Album(
 itemno SMALLINT,
 titulo VARCHAR(50),
 artno SMALLINT,
 CONSTRAINT PK_Album PRIMARY KEY CLUSTERED (itemno),
 CONSTRAINT FK_Album_Artista FOREIGN KEY (artno) REFERENCES Discos.Artista (artno)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Stock' AND TYPE = 'U')
CREATE TABLE Discos.Stock(
 itemno SMALLINT,
 tipo CHAR(1),
 precio DECIMAL(5,2),
 cantidad INT,
 itemnoAlbum SMALLINT UNIQUE,
 CONSTRAINT PK_Stock PRIMARY KEY CLUSTERED (itemno,itemnoAlbum),
 CONSTRAINT FK_Stock_Album FOREIGN KEY (itemnoAlbum) REFERENCES Discos.Album (itemno)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Orden' AND TYPE = 'U')
CREATE TABLE Discos.Orden(
 itemno SMALLINT,
 timestamp TIMESTAMP,
 itemnoStock SMALLINT,
 itemnoAlbum SMALLINT,
 CONSTRAINT PK_Orden PRIMARY KEY CLUSTERED (itemno),
 CONSTRAINT FK_Orden_Stock FOREIGN KEY (itemnoStock,itemnoAlbum) REFERENCES Discos.Stock (itemno,itemnoAlbum)
);

IF NOT EXISTS(SELECT * FROM sys.objects WHERE NAME = 'Concierto' AND TYPE = 'U')
CREATE TABLE Discos.Concierto(
 artno SMALLINT,
 fecha DATETIME,
 ciudad VARCHAR(25),
 CONSTRAINT PK_Concierto PRIMARY KEY CLUSTERED (artno,fecha),
 CONSTRAINT FK_Concierto_Artista FOREIGN KEY (artno) REFERENCES Discos.Artista (artno)
);

-- 6.1.
ALTER TABLE Discos.Concierto ALTER COLUMN ciudad VARCHAR (30);
-- 6.2.
ALTER TABLE Discos.Stock ADD CONSTRAINT df_precioDefault DEFAULT (0) FOR precio;
-- 6.3
ALTER TABLE Discos.Album ADD CONSTRAINT ch_nombreNoNulo CHECK (titulo is not null);

-- 7.
-- Cambio el tipo de dato deprecado 'IMAGE' al tipo de dato 'VARBINARY(MAX)'
ALTER TABLE Discos.Artista ALTER COLUMN foto VARBINARY(MAX)

-- Declaro variables para cada una de las imagenes de los artistas
DECLARE @ArtistImage1 AS VARBINARY(MAX)
SET @ArtistImage1 = (select * from openrowset (bulk  N'F:\Desktop\Mis cosas\Materias\Tecnicatura de Desarrollo Movil\Segundo año\Gestión de Datos\Práctica\Lab4_CrearDBTablas\images\gustavo-cerati.jpg', single_blob) as image); 

DECLARE @ArtistImage2 AS VARBINARY(MAX)
SET @ArtistImage2 = (select * from openrowset (bulk  N'F:\Desktop\Mis cosas\Materias\Tecnicatura de Desarrollo Movil\Segundo año\Gestión de Datos\Práctica\Lab4_CrearDBTablas\images\freddie-mercury.jpg', single_blob) as image); 

DECLARE @ArtistImage3 AS VARBINARY(MAX)
SET @ArtistImage3 = (select * from openrowset (bulk  N'F:\Desktop\Mis cosas\Materias\Tecnicatura de Desarrollo Movil\Segundo año\Gestión de Datos\Práctica\Lab4_CrearDBTablas\images\david-bowie.jpg', single_blob) as image); 

-- Inserto los nuevos registros en la tabla Discos.Artista
INSERT INTO Discos.Artista VALUES (1, 'Gustavo Cerati', 'A', 'Un cantante fenomenal', @ArtistImage1);
INSERT INTO Discos.Artista VALUES (2, 'Freddie Mercury', 'B', 'Un pionero en la música', @ArtistImage2);
INSERT INTO Discos.Artista VALUES (3, 'David Bowie', 'C', 'Un artista muy creativo', @ArtistImage3);

-- Inserto 2 conciertos por cada artista en la tabla Discos.Concierto
INSERT INTO Discos.Concierto VALUES (1,'2009-12-20','Ciudad de Buenos Aires');
INSERT INTO Discos.Concierto VALUES (2,'1990-12-22','Ciudad de Buenos Aires');
INSERT INTO Discos.Concierto VALUES (3,'1985-07-13','Londres');
INSERT INTO Discos.Concierto VALUES (4,'1981-11-24','Montreal');
INSERT INTO Discos.Concierto VALUES (5,'1972-11-22','Cleveland');
INSERT INTO Discos.Concierto VALUES (6,'1972-11-28','Nueva York');

-- Inserto 2 álbumes por cada artista en la tabla Discos.Album
INSERT INTO Discos.Album VALUES (1,'Fuerza Natural',1);
INSERT INTO Discos.Album VALUES (2,'Amor Amarillo',1);
INSERT INTO Discos.Album VALUES (3,'A Night at the Opera',2);
INSERT INTO Discos.Album VALUES (4,'Mr. Bad Guy',2);
INSERT INTO Discos.Album VALUES (5,'Let''s Dance',3);
INSERT INTO Discos.Album VALUES (6,'Blackstar',3);

-- Inserto stock solo de 2 álbumes de los artistas en la tabla Discos.Stock
INSERT INTO Discos.Stock VALUES (1,'A',349.0,20);
INSERT INTO Discos.Stock VALUES (2,'B',599.0,35);
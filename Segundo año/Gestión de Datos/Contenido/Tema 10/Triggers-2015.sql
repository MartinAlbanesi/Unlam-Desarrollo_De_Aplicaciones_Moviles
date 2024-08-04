
/****** Object:  Table [dbo].[EMPLEADO]    Script Date: 05/30/2013 17:23:18 ******/
DROP TABLE [dbo].EMPLEADO
GO
DROP TABLE [dbo].[PROYECTO]
GO
CREATE TABLE [dbo].[PROYECTO](
	[Id]  [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DESCRIPCION] [varchar](100) NULL,
	[FECALT] [datetime] NULL,
	[FECMOD] [datetime] NULL,
	[ULTOPR] [char](1) NULL,
	[DEBAJA] [char](1) NULL,
	[USERID] [varchar](256) NULL,
 CONSTRAINT [PK_PROYECTO] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[EMPLEADO](
	[ID] NUMERIC(18, 0) NOT NULL, 
	[NOMBRE] VARCHAR(100) NOT NULL, 
	[APELLIDO] VARCHAR(100) NOT NULL, 
	[FECHA_NAC] DATETIME NOT NULL, 
	[EDAD] SMALLINT NOT NULL, 
	[DNI] INT NOT NULL, 
	[IDPROYECTO] [numeric](18, 0) NULL,
	[FECALT] [datetime] NULL,
	[FECMOD] [datetime] NULL,
	[ULTOPR] [char](1) NULL, -- ABM
	[DEBAJA] [char](1) NULL, --S o N
	[USERID] [varchar](256) NULL, --user realiza la accion
 CONSTRAINT [PK_EMPLEADO] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EMPLEADO]  WITH CHECK ADD  CONSTRAINT [FK_EMPLEADO_PROYECTO] FOREIGN KEY([IDPROYECTO])
REFERENCES [dbo].[PROYECTO] ([ID])
GO

ALTER TABLE [dbo].[EMPLEADO] CHECK CONSTRAINT [FK_EMPLEADO_PROYECTO]
GO
DROP TABLE [dbo].[LOGERRORES]
GO
CREATE TABLE [dbo].[LOGERRORES](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DESCRIPCION] [varchar](max) NULL,
	[ERROR] [int] NULL,
	[FILA] [int] NULL,
	[ERROR_LINE] [int] NULL,
	[ERROR_MESSAGE] [nvarchar](2048) NULL,
	[ERROR_PROCEDURE] [nvarchar](126) NULL,
	[ERROR_NUMBER] [int] NULL,
	[ERROR_SEVERITY] [int] NULL,
	[ERROR_STATE] [int] NULL,
	[FECALT] [datetime] NULL,
	[USERID] [varchar](255) NULL
 CONSTRAINT [PK_LOGERRORES] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[RDOEXECSP]    Script Date: 05/30/2013 17:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RDOEXECSP](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[IDTABLA] [numeric](18, 0) NOT NULL,
	[IDREGISTRO] [numeric](18, 0) NOT NULL,
	[DESCRIPCION] [varchar](max) NULL,
	[RESULTADO] [varchar](max) NULL,
	[ERROR] [int] NULL,
	[FILA] [int] NULL,
	[ERROR_LINE] [int] NULL,
	[ERROR_MESSAGE] [nvarchar](2048) NULL,
	[ERROR_PROCEDURE] [nvarchar](126) NULL,
	[ERROR_NUMBER] [int] NULL,
	[ERROR_SEVERITY] [int] NULL,
	[ERROR_STATE] [int] NULL,
	[FECALT] [datetime] NULL,
	[FECMOD] [datetime] NULL,
	[USERID] [varchar](50) NULL,
	[ULTOPR] [char](1) NULL,
	[DEBAJA] [char](1) NULL,
 CONSTRAINT [PK_RDOEXECSP] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
CREATE TRIGGER [dbo].[TR_EMPLEADO_AM] 
   ON  [dbo].[EMPLEADO] 
   AFTER INSERT, UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @Operation CHAR(1)

	IF EXISTS(SELECT 1 FROM DELETED) --DIFERENCIAR EN QUE ACCION ESTOY
	SET @Operation = 'M'
		ELSE 
	SET @Operation = 'A'


	IF @Operation ='M'
	BEGIN
		/* Si valor anterior a la modificación era DEBAJA en 'S' en algún registro 
		  se hace ROLLBACK, no se pueden eliminar registros ya eliminados lógicamente*/
		IF EXISTS (SELECT 1 FROM DELETED WHERE DEBAJA = 'S') --elimina la recursividad cuandoel delete se reemplza por update en baja lógica
		BEGIN
			ROLLBACK TRAN
			RAISERROR('Tabla empleado - No se puede eliminar/modificar registros con baja lógica',16,1)
		END
		ELSE
		BEGIN
				
		/*Actualiza datos de auditoria de modificación de los registros */

		UPDATE dbo.EMPLEADO	
			SET FECMOD = GETDATE(),
				USERID = SYSTEM_USER,	
				ULTOPR = 'M'	
			WHERE ID  IN (SELECT ID FROM INSERTED WHERE DEBAJA = 'N' OR DEBAJA IS NULL) --condicion del where de mas
		
		IF @@ERROR <> 0
			BEGIN
					ROLLBACK TRAN
					THROW 50000,'Tabla empleado - Error al actualizar datos de auditoría',1
			END
		END
	END
	ELSE
	BEGIN


			/*Actualiza datos de auditoria de modificación de los registros */
			UPDATE dbo.EMPLEADO	
				SET FECALT = GETDATE(),
					FECMOD = GETDATE(),
					USERID = SYSTEM_USER,	
					ULTOPR = 'A',
					DEBAJA = 'N'
				WHERE ID  IN (SELECT ID FROM INSERTED) 
		
			IF @@ERROR <> 0
				BEGIN
						ROLLBACK TRAN
						THROW 50000,'Tabla EMPLEADO - Error al insertar datos de auditoría',1
				END
	END
END

GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_EMPLEADO_B] 
   ON  [dbo].[EMPLEADO] 
   INSTEAD OF DELETE
AS 
BEGIN
	
	SET NOCOUNT ON;
	
	--NO DAR DE BAJA ALGO YA ELIMINADO
	IF EXISTS (SELECT 1 FROM DELETED WHERE DEBAJA = 'S')
		BEGIN
			ROLLBACK TRAN
			THROW 50000,'Tabla empleado - No se puede eliminar registros con baja lógica',1
	END

	UPDATE dbo.EMPLEADO
		SET DEBAJA = 'S', 
		FECMOD = GETDATE(),
		USERID = SYSTEM_USER, 
		ULTOPR = 'B'
	WHERE ID IN (SELECT ID FROM DELETED)
	
	IF @@ERROR <> 0
	BEGIN
			ROLLBACK TRAN
			THROW 50000,'Tabla EMPLEADO - Error al marcar registros con baja lógica',1
	END	
END

--EJEMPLO DE LLAMADAS

select * from empleado
select * from proyecto

INSERT INTO EMPLEADO (id, nombre, apellido, fecha_nac, edad, dni, idproyecto, fecalt,USERID) --va dar error porque intenta actualizar explicitamente el campo feclat
VALUES (45, 'Carina', 'Perez', '19800101', 37, 32425351,1, getdate(),'hola')

INSERT INTO EMPLEADO (id, nombre, apellido, fecha_nac, edad, dni, idproyecto, fecalt,USERID) --va dar error porque intenta actualizar explicitamente el campo feclat
VALUES (46, 'Carina', 'Perez', '19800101', 37, 32425351,1,'20000101','chau')


INSERT INTO EMPLEADO (id, nombre, apellido, fecha_nac, edad, dni, idproyecto ) --va dar error porque intenta actualizar explicitamente el campo feclat
VALUES (47, 'ttttt', 'ererer', '19800101', 37, 32425351,2)


UPDATE EMPLEADO
SET nombre='pepito'  --va dar error porque intenta actualizar explicitamente el campo feclat
WHERE ID = 45

UPDATE EMPLEADO
SET USERID='pepito'  --va dar error porque intenta actualizar explicitamente el campo feclat
WHERE ID = 45


delete from EMPLEADO 
WHERE ID = 45
/*

DECLARE @SALIDA VARCHAR(MAX),@RDO SMALLINT 
EXEC [dbo].[SP_EMPLEADO_ABM] 'A', 1,'cintia','gioia',1, @SALIDA OUTPUT, @RDO OUTPUT
SELECT @SALIDA
SELECT @RDO


DECLARE @SALIDA VARCHAR(MAX),@RDO SMALLINT 
EXEC [dbo].[SP_EMPLEADO_ABM] 'A', 1,'cintia','gioia',1, @SALIDA OUTPUT, @RDO OUTPUT
SELECT @SALIDA
SELECT @RDO

DECLARE @SALIDA VARCHAR(MAX),@RDO SMALLINT 
EXEC [dbo].[SP_EMPLEADO_ABM] 'M', 1,'cintia veronica g','gioia',1, @SALIDA OUTPUT, @RDO OUTPUT
SELECT @SALIDA
SELECT @RDO

DECLARE @SALIDA VARCHAR(MAX),@RDO SMALLINT 
EXEC [dbo].[SP_EMPLEADO_ABM] 'A', 2,'cintia','gioia',1, @SALIDA OUTPUT, @RDO OUTPUT
SELECT @SALIDA
SELECT @RDO

DECLARE @SALIDA VARCHAR(MAX),@RDO SMALLINT 
EXEC [dbo].[SP_EMPLEADO_ABM] 'M', 2,'cintia','gioia',1, @SALIDA OUTPUT, @RDO OUTPUT
SELECT @SALIDA
SELECT @RDO

DECLARE @SALIDA VARCHAR(MAX),@RDO SMALLINT 
EXEC [dbo].[SP_EMPLEADO_ABM] 'B', 2,'cintia','gioia',1, @SALIDA OUTPUT, @RDO OUTPUT
SELECT @SALIDA
SELECT @RDO

SELECT * FROM EMPLEADO
SELECT * FROM PROYECTO
SELECT * FROM RDOEXECSP ORDER BY ID DESC
*/

--HACER TRIGGERS PARA PROYECTO CON IGUAL CRITERIO A EMPLEDO

--BORRADO EN CASCADA

BEGIN TRAN
	delete from EMPLEADO where IDPROYECTO=1 and DEBAJA = 'N'
	IF (@@ERROR <>0)
	begin
		rollback tran 
	end
		
	delete from PROYECTO where id=1
	IF (@@ERROR <>0)
	begin
		rollback tran 
	end
	
COMMIT TRAN


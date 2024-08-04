USE AdventureWorks2014
GO

/*
1. p_InsCulture(id,name,date): Este sp debe permitir dar de alta un nuevo
registro en la tabla Production.Culture. Los tipos de datos de los par�metros
deben corresponderse con la tabla. Para ayudarse, se podr� ejecutar el
procedimiento sp_help�<esquema.objeto>�
*/

SELECT * FROM Production.Culture c;

EXEC sp_help'Production.Culture';

--Definici�n
CREATE PROCEDURE p_InsCulture (
@id NCHAR(12),
@name NAME,
@date DATETIME
)AS
INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
VALUES(@id, @name, @date);

--Ejecuci�n
EXEC p_InsCulture 'br', 'Brasilero', '2008-04-30 00:00:00.000';


/*
2. p_SelCulture(id): Este sp devolver� el registro completo seg�n el id
enviado
*/

--Definici�n
CREATE PROCEDURE p_SelCulture(
@id NCHAR(12)
)AS
SELECT *
FROM Production.Culture
WHERE CultureID = @id;

--Ejecuci�n
EXEC p_SelCulture 'br';


/*
3. p_DelCulture(id): Este sp debe borrar el id enviado por par�metro de la
tabla Production.Culture
*/

--Definici�n
CREATE PROCEDURE p_DelCulture(
@id NCHAR(12)
)AS
DELETE FROM Production.Culture
WHERE CultureID = @id;

--Ejecuci�n
EXEC p_DelCulture 'br';


/*
4. p_UpdCulture(id): Dado un id debe permitirme cambiar el campo name
del registro
*/

--Definici�n
CREATE PROCEDURE p_UpdCulture(
@id NCHAR(12)
)AS
UPDATE Production.Culture
SET Name = 'Brazilian'
WHERE CultureID = @id;

--Ejecuci�n
EXEC p_UpdCulture 'br';


/*
5. sp_CantCulture (cant out): Realizar un sp que devuelva la cantidad de
registros en Culture. El resultado deber� colocarlo en una variable de salida.
*/

--Definici�n
CREATE PROCEDURE sp_CantCulture(
@cantOut INT OUTPUT
) AS
BEGIN
	SET @cantOut = (
	SELECT COUNT(*)
	FROM Production.Culture
	);
END;

--Ejecuci�n
BEGIN
	DECLARE @CantCulture int;
	EXEC sp_CantCulture @CantCulture OUTPUT;
	SELECT @CantCulture
END

/*
6. sp_CultureAsignadas : Realizar un sp que devuelva solamente las
Culture�s que est�n siendo utilizadas en las tablas (Verificar qu� tabla/s la
est�n referenciando). S�lo debemos devolver id y nombre de la Cultura
*/

--Definicion
CREATE PROCEDURE sp_CultureAsignadas
AS
SELECT c.CultureID, c.Name
FROM Production.Culture c
INNER JOIN Production.ProductModelProductDescriptionCulture dc
ON c.CultureID = dc.CultureID
GROUP BY c.CultureID, c.Name;

--Ejecuci�n
EXEC sp_CultureAsignadas


/*
7. p_ValCulture(id,name,date,operaci�n, valida out): Este sp permitir�
validar los datos enviados por par�metro. En el caso que el registro sea
v�lido devolver� un 1 en el par�metro de salida valida � 0 en caso contrario.
El par�metro operaci�n puede ser �U� (Update), �I� (Insert) � �D� (Delete).
Lo que se debe validar es:
	- Si se est� insertando no se podr� agregar un registro con un id
	existente, ya que arrojar� un error.
	- Tampoco se puede agregar dos registros Cultura con el mismo Name,
	ya que el campo Name es un unique index.
	- Ninguno de los campos deber�a estar vac�o.
	- La fecha ingresada no puede ser menor a la fecha actual.
*/

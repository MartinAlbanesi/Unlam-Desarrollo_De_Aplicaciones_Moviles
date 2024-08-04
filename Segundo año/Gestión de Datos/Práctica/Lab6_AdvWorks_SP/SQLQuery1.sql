USE AdventureWorks2014
GO

/*
1. p_InsCulture(id,name,date): Este sp debe permitir dar de alta un nuevo
registro en la tabla Production.Culture. Los tipos de datos de los parámetros
deben corresponderse con la tabla. Para ayudarse, se podrá ejecutar el
procedimiento sp_help“<esquema.objeto>”
*/

SELECT * FROM Production.Culture c;

EXEC sp_help'Production.Culture';

--Definición
CREATE PROCEDURE p_InsCulture (
@id NCHAR(12),
@name NAME,
@date DATETIME
)AS
INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
VALUES(@id, @name, @date);

--Ejecución
EXEC p_InsCulture 'br', 'Brasilero', '2008-04-30 00:00:00.000';


/*
2. p_SelCulture(id): Este sp devolverá el registro completo según el id
enviado
*/

--Definición
CREATE PROCEDURE p_SelCulture(
@id NCHAR(12)
)AS
SELECT *
FROM Production.Culture
WHERE CultureID = @id;

--Ejecución
EXEC p_SelCulture 'br';


/*
3. p_DelCulture(id): Este sp debe borrar el id enviado por parámetro de la
tabla Production.Culture
*/

--Definición
CREATE PROCEDURE p_DelCulture(
@id NCHAR(12)
)AS
DELETE FROM Production.Culture
WHERE CultureID = @id;

--Ejecución
EXEC p_DelCulture 'br';


/*
4. p_UpdCulture(id): Dado un id debe permitirme cambiar el campo name
del registro
*/

--Definición
CREATE PROCEDURE p_UpdCulture(
@id NCHAR(12)
)AS
UPDATE Production.Culture
SET Name = 'Brazilian'
WHERE CultureID = @id;

--Ejecución
EXEC p_UpdCulture 'br';


/*
5. sp_CantCulture (cant out): Realizar un sp que devuelva la cantidad de
registros en Culture. El resultado deberá colocarlo en una variable de salida.
*/

--Definición
CREATE PROCEDURE sp_CantCulture(
@cantOut INT OUTPUT
) AS
BEGIN
	SET @cantOut = (
	SELECT COUNT(*)
	FROM Production.Culture
	);
END;

--Ejecución
BEGIN
	DECLARE @CantCulture int;
	EXEC sp_CantCulture @CantCulture OUTPUT;
	SELECT @CantCulture
END

/*
6. sp_CultureAsignadas : Realizar un sp que devuelva solamente las
Culture’s que estén siendo utilizadas en las tablas (Verificar qué tabla/s la
están referenciando). Sólo debemos devolver id y nombre de la Cultura
*/

--Definicion
CREATE PROCEDURE sp_CultureAsignadas
AS
SELECT c.CultureID, c.Name
FROM Production.Culture c
INNER JOIN Production.ProductModelProductDescriptionCulture dc
ON c.CultureID = dc.CultureID
GROUP BY c.CultureID, c.Name;

--Ejecución
EXEC sp_CultureAsignadas


/*
7. p_ValCulture(id,name,date,operación, valida out): Este sp permitirá
validar los datos enviados por parámetro. En el caso que el registro sea
válido devolverá un 1 en el parámetro de salida valida ó 0 en caso contrario.
El parámetro operación puede ser “U” (Update), “I” (Insert) ó “D” (Delete).
Lo que se debe validar es:
	- Si se está insertando no se podrá agregar un registro con un id
	existente, ya que arrojará un error.
	- Tampoco se puede agregar dos registros Cultura con el mismo Name,
	ya que el campo Name es un unique index.
	- Ninguno de los campos debería estar vacío.
	- La fecha ingresada no puede ser menor a la fecha actual.
*/

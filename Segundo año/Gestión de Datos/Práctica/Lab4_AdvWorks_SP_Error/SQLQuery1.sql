USE AdventureWorks2014
GO

/*
1. p_InsertaDatos(): Realizar un sp que permita insertar números pares del
2 al 20 en una tabla con el nombre dbo.NumeroPar (nro smallint), excepto
los números 10 y 16. La tabla debe ser creada fuera del procedimiento.
Controlar los errores que pudieran sucederse.
*/

CREATE TABLE dbo.NumeroPar (
	Numero SMALLINT
);

DROP PROCEDURE p_InsertaDatos

DECLARE @Transaction1 VARCHAR(20) = 'Transaction1';  

DECLARE @ErrorMsg VARCHAR(50);

--Definición
CREATE PROCEDURE p_InsertaDatos(
	@nro SMALLINT OUTPUT
)AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		IF @nro % 2 = 0 AND @nro >= 2 AND @nro <= 20 AND @nro <> 10 AND @nro <> 16
			BEGIN
				INSERT INTO dbo.NumeroPar(Numero)
				VALUES(@nro);
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END;

--Ejecución
EXEC p_InsertaDatos 2;

SELECT * FROM dbo.NumeroPar

/*
2. p_InsertaDatos2(nro): Realiza un sp que inserte a la tabla
dbo.NumeroPar el número ingresado por parámetro, pero sólo se deberá
insertar si el número es par. De lo contrario lanzar una excepción.
*/

CREATE PROCEDURE p_InsertaDatos2(
	@nro SMALLINT
)AS
BEGIN
	IF @nro % 2 = 0
		BEGIN
			INSERT INTO dbo.NumeroPar(Numero)
			VALUES(@nro);
		END
	ELSE
		BEGIN
			THROW 50000, 'No se pudo agregar el numero', 1
		END
END;

EXEC p_InsertaDatos2 1

/*
3. p_MuestraNroPares(): Realizar un sp que devuelva los registros
insertados en los ítems anteriores. En el caso de que la tabla esté vacía
lanzar una excepción indicando dicho error.
*/

DROP PROCEDURE p_MuestraNroPares

CREATE PROCEDURE p_MuestraNroPares
AS
BEGIN
	IF (SELECT count(*)  from dbo.NumeroPar) > 0
		BEGIN
			SELECT * FROM dbo.NumeroPar
		END
	ELSE
		BEGIN
			THROW 50000, 'La tabla esta vacía', 1
		END
END;

EXEC p_MuestraNroPares

/*
4. p_ActualizaBonus(): Se actualizará el bonus de todas las personas que se
encuentran en la tabla Sales.SalesPerson, teniendo en cuenta las siguientes
condiciones: Se calculará el bonus tomando como % el valor CommissionPct
(%) de su valor SalesQuota. Si el valor de SalesQuota es NULL se colocará 0
(cero) como bonus. Si el bonus resultante quedó a menos de 3000, se
dejará 3000 como mínimo valor de bonus (siempre y cuando tenga algún
dato en SalesQuota). Controlar errores y manejar todo el ejercicio como una
única transacción.*/
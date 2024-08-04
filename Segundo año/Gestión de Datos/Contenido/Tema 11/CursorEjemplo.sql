USE [AdventureWorks]
GO

/****** Object:  StoredProcedure [dbo].[p_GenerarProductoxColor]    Script Date: 06/15/2012 20:38:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[p_GenerarProductoxColor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[p_GenerarProductoxColor]
GO

USE [AdventureWorks]
GO

/****** Object:  StoredProcedure [dbo].[p_GenerarProductoxColor]    Script Date: 06/15/2012 20:38:14 ******/
/*
p_GenerarProductoxColor(): Generar un procedimiento que divida los
productos según el color que poseen. Los mismos deben ser insertados en
diferentes tablas según el color del producto. Por ejemplo, las tablas podrían
ser Product_Black, Product_Silver, etc… Estas tablas deben ser generadas
dinámicamente según los colores que existan en los productos, es decir, si
genero un nuevo producto con un nuevo color, al ejecutar el procedimiento
debe generar dicho color. Cada vez que se ejecute este procedimiento se
recrearán las tablas de colores. Los productos que no posean color
asignados, no se tendrán en cuenta para la generación de tablas y no se
insertarán en ninguna tabla de color.
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[p_GenerarProductoxColor]
as
	declare @query varchar (max) = '',@color nvarchar(15)
	
	DECLARE ProdInfo CURSOR FOR SELECT distinct Color FROM [Production].[Product] where isnull(color,'') <> ''
	OPEN ProdInfo
	FETCH NEXT FROM ProdInfo INTO @color
	WHILE @@fetch_status = 0
	BEGIN
		
		SET @query = '
			IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[Production].[Product_'+@color+']'') AND type in (N''U''))
			DROP TABLE [Production].[Product_'+@color+']'
		
		exec(@query)
		
		SET @query = '	
			CREATE TABLE [Production].[Product_'+@color+'](
				[ProductID] [int] NOT NULL,
				[Name] [dbo].[Name] NOT NULL,
				[ProductNumber] [nvarchar](25) NOT NULL,
				[MakeFlag] [dbo].[Flag] NOT NULL,
				[FinishedGoodsFlag] [dbo].[Flag] NOT NULL,
				[Color] [nvarchar](15) NULL,
				[SafetyStockLevel] [smallint] NOT NULL,
				[ReorderPoint] [smallint] NOT NULL,
				[StandardCost] [money] NOT NULL,
				[ListPrice] [money] NOT NULL,
				[Size] [nvarchar](5) NULL,
				[SizeUnitMeasureCode] [nchar](3) NULL,
				[WeightUnitMeasureCode] [nchar](3) NULL,
				[Weight] [decimal](8, 2) NULL,
				[DaysToManufacture] [int] NOT NULL,
				[ProductLine] [nchar](2) NULL,
				[Class] [nchar](2) NULL,
				[Style] [nchar](2) NULL,
				[ProductSubcategoryID] [int] NULL,
				[ProductModelID] [int] NULL,
				[SellStartDate] [datetime] NOT NULL,
				[SellEndDate] [datetime] NULL,
				[DiscontinuedDate] [datetime] NULL,
				[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
				[ModifiedDate] [datetime] NOT NULL,
			 CONSTRAINT [PK_Product_ProductID_'+@color+'] PRIMARY KEY CLUSTERED 
			(
				[ProductID] ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
			) ON [PRIMARY]

			
		'
		exec(@query)
		--insert into Production.Product select * from Production.Product where Color = ''
		SET @query = 'insert into Production.[Product_'+@color+'] select * from Production.Product where Color = '''+@color+''''
		exec(@query)
		FETCH NEXT FROM ProdInfo INTO @color
	END
	CLOSE ProdInfo
	DEALLOCATE ProdInfo
	
	
GO



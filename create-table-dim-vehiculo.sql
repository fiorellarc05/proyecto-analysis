USE [CuboParqueo]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimVehiculo]') AND type in (N'U'))
DROP TABLE [dbo].[DimVehiculo]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimVehiculo](
	[Ano] [numeric](10, 0) NULL,
	[EstratoAnoFabricacion] [varchar](50) NULL,
	[NombreTipoVehiculo] [varchar](50) NULL,
	[NombreFabricante] [varchar](50) NULL
) ON [PRIMARY]
GO



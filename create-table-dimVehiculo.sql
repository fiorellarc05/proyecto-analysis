/*Vehiculo*/
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
	[IDVehiculo] [int] NULL,
	[Placa] [int] NULL,
	[Ano] [int] NULL,
	[NombreTipoVehiculo] [nvarchar](50) NULL,
	[NombreFabricante] [nvarchar](50)  NULL,
	[NombrePais] [nvarchar](50)  NULL,
	[AbreviaturaPais] [nvarchar](5)  NULL,
	[NombreRegionContinente] [nvarchar](50)  NULL,
	[NombreContinente] [nvarchar](50)  NULL,
	[EstratoAnoFabricacion] [varchar](50) NULL
) ON [PRIMARY]
GO
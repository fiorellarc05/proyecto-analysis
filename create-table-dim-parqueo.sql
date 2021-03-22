USE [CuboParqueo]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimParqueo]') AND type in (N'U'))
DROP TABLE [dbo].[DimParqueo]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimParqueo](
	[IDParqueo] [numeric](10, 0) NOT NULL,
	[NombreDistrito] [varchar](50) NULL,
	[NombreCanton] [varchar](50) NULL,
	[Provincia] [varchar](50) NULL
) ON [PRIMARY]
GO



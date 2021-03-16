/*Parqueo*/
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
	[IDParqueo] [int] NULL,
	[NombreDistrito] [nvarchar](50) NULL,
	[NombreCanton] [nvarchar](50) NULL,
	[NombreProvincia] [nvarchar](50) NULL,

) ON [PRIMARY]
GO
/*Estacionamiento*/
USE [CuboParqueo]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactEstacionamiento]') AND type in (N'U'))
DROP TABLE [dbo].[FactEstacionamiento]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactEstacionamiento](
	[IDParqueo] [int]  NOT NULL,
	[IDVehiculo] [int] NULL,
	[TarifaBase] [money] NULL,
	[Ganancia] [money] NULL,
	[Mantenimiento] [money] NULL,
	[ImpVentas] [money] NULL,
	[TotalACobrar] [money] NULL,
	[HoraEntrada] [int] NULL,
	[HoraSalida] [int] NULL,
	[DiaEntrada] [varchar](50) NULL,
	[DiaSalida] [varchar](50) NULL,
	[CantidadMinutos] [int] NULL,
	[EstratoDiaRestriccion] [varchar](50) NULL,
	[EstratoCantidadNumeros] [varchar](50) NULL,
	[EstratoHoraEntrada] [varchar](50) NULL,
	[EstratoHoraSalida] [varchar](50) NULL,
	[EstratoGanancia] [varchar](50) NULL
) ON [PRIMARY]
GO
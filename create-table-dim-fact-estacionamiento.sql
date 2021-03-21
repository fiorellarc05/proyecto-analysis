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
	[IDParqueo] [numeric](10, 0) NOT NULL,
	[IDVehiculo] [numeric](10, 0) NOT NULL,
	[TarifaBase] [numeric](10, 2) NULL,
	[Mantenimiento] [numeric](10, 2) NULL,
	[ImpVentas] [numeric](10, 2) NULL,
	[FechaHoraIngreso] [datetime] NOT NULL,
	[HoraEntrada] [int] NULL,
	[EstratoHoraEntrada] [varchar](50) NULL,
	[IndicativoHoraEntrada] [varchar](10) NULL,
	[DiaEntrada] [int] NULL,
	[DiaSemanaEntrada] [int] NULL,
	[EntradaRestriccion] [varchar](50) NULL,
	[DiaEntradaFeriado] [varchar](25) NULL,
	[FechaHoraSalida] [datetime] NULL,
	[HoraSalida] [int] NULL,
	[EstratoHoraSalida] [varchar](50) NULL,
	[IndicativoHoraSalida] [varchar](10) NULL,
	[DiaSalida] [int] NULL,
	[DiaSemanaSalida] [int] NULL,
	[SalidaRestriccion] [varchar](50) NULL,
	[DiaSalidaFeriado] [varchar](25) NULL,
	[CantMinutos] [int] NULL,
	[EstratoCantMinutos] [varchar](50) NULL,
	[TotalACobrar] [numeric](10, 2) NULL,
	[Ganancia] [numeric](10, 2) NULL,
	[EstratoGanancia] [varchar](50) NULL
) ON [PRIMARY]
GO



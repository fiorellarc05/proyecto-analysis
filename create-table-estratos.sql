USE [CuboParqueo]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ParqueoEstratos]') AND type in (N'U'))
DROP TABLE [dbo].ParqueoEstratos
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create table ParqueoEstratos
(
	IdEstrato int primary key,
	TipoEstrato varchar (50),
	LimiteInferior float,
	LimiteSuperior float,
	Descripcion varchar (50)
);

begin tran
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1, 'AnoFabricacion', 1, 1984, 'Antes de 1985');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(2, 'AnoFabricacion', 1985, 1993, 'De 1985 a antes de 1994');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(3, 'AnoFabricacion', 1994, 2002, 'De 1994 a antes de 2003');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(4, 'AnoFabricacion', 2003, 2009, 'De 2003 a antes de 2010');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(5, 'AnoFabricacion', 2010, 99999999999, 'De 2010 en adelante');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(100, 'DiaRestriccion', 0, 3, 'Lunes Placas 0 a 3');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(200, 'DiaRestriccion', 0, 3, 'Martes Placas 4 a 7');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(300, 'DiaRestriccion', 8, 1, 'Miércoles Placas 8 a 1');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(400, 'DiaRestriccion', 2, 5, 'Jueves Placas 2 a 5');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(500, 'DiaRestriccion', 6, 9, 'Viernes Placas 6 a 9');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1100, 'CantMinutos', -999999999, 0, 'Inválido valor negativo');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1200, 'CantMinutos', 0, 29, 'De 0 a menos de 30 minutos');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1300, 'CantMinutos', 30, 89, 'De 30 a menos de 90 minutos');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1400, 'CantMinutos', 90, 244, 'De 90 a menos de 245 minutos');	
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1500, 'CantMinutos', 245, 599, 'De 245 a menos de 600 minutos');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(1600, 'CantMinutos', 600, 99999999999, 'Más de 600 minutos');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(11100, 'HoraEntrada', 0, 5, 'Madrugada:  12 am hasta antes de las 5 am.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(11200, 'HoraEntrada', 5, 12, 'Mañana:  desde las 5 am hasta antes de las 12 pm.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(11300, 'HoraEntrada', 12, 14, 'Mediodía: desde las 12 hasta antes de las 2 pm.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(11400, 'HoraEntrada', 14, 17, 'Tarde: desde las 2 pm hasta antes de las 7 pm.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(11500, 'HoraEntrada', 17, 24, 'Noche: desde las 7 pm hasta antes de las 12 am.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(511100, 'HoraSalida', 0, 5, 'Madrugada: 12 am hasta antes de las 5 am.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(511200, 'HoraSalida', 5, 12, 'Mañana: desde las 5 am hasta antes de las 12 pm.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(511300, 'HoraSalida', 12, 14, 'Mediodía: desde las 12 hasta antes de las 2 pm.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(511400, 'HoraSalida', 14, 17, 'Tarde: desde las 2 pm hasta antes de las 7 pm.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(511500, 'HoraSalida', 17, 24, 'Noche: desde las 7 pm hasta antes de las 12 am.');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(111100, 'Ganancia', -99999999999, 0, 'Inválido valor negativo');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(111200, 'Ganancia', 0, 999, 'De 0 a menos de 1000 colones');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(111300, 'Ganancia', 1000, 2999, 'De 1000 a menos de 3000 colones');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(111400, 'Ganancia', 3000, 7499, 'De 3000 a menos de 7500 colones');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(111500, 'Ganancia', 7500, 9999, 'De 7500 a menos de 10000 colones');
	insert into ParqueoEstratos (IdEstrato, TipoEstrato, LimiteInferior, LimiteSuperior, Descripcion) values
		(111600, 'Ganancia', 10000, 99999999999, 'Más de 10000 colones');

commit;
use CuboParqueo
if
	(OBJECT_ID ('dbo.FactEstacionamiento', 'U') > 0) drop table FactEstacionamiento; 
GO

SELECT 
	IDParqueo,IDVehiculo,TarifaBase, Mantenimiento, ImpVentas, FechaHoraIngreso,
	DATEPART(HOUR, FechaHoraIngreso) as HoraEntrada, CONVERT(varchar(50), FechaHoraIngreso) as EstratoHoraEntrada,
	CONVERT(varchar(10), DATEPART(HOUR, FechaHoraIngreso)) as IndicativoHoraEntrada,
	DATEPART(DAY,FechaHoraIngreso) as DiaEntrada, 
	DATEPART(WEEKDAY,FechaHoraIngreso) as DiaSemanaEntrada,
	CONVERT(varchar(50),DATEPART(WEEKDAY,FechaHoraIngreso)) as EntradaRestriccion,
	CONVERT(varchar(25),DATEPART(DAY, FechaHoraIngreso),DATEPART(MONTH, FechaHoraIngreso)) as DiaEntradaFeriado,
	FechaHoraSalida,
	DATEPART(HOUR, FechaHoraSalida) as HoraSalida, CONVERT(varchar(50), FechaHoraSalida) as EstratoHoraSalida,
	CONVERT(varchar(10), DATEPART(HOUR, FechaHoraSalida)) as IndicativoHoraSalida,
	DATEPART(DAY,FechaHoraSalida) as DiaSalida, DATEPART(WEEKDAY,FechaHoraSalida) as DiaSemanaSalida,
	CONVERT(varchar(50),DATEPART(WEEKDAY,FechaHoraSalida)) as SalidaRestriccion,
	CONVERT(varchar(25),DATEPART(DAY, FechaHoraSalida)) as DiaSalidaFeriado,
	DATEDIFF(MINUTE,FechaHoraIngreso,FechaHoraSalida) as CantMinutos, 
	CONVERT(VARCHAR(50),DATEDIFF(MINUTE,FechaHoraSalida,FechaHoraIngreso)) as EstratoCantMinutos,
	TotalACobrar,
	Ganancia, CONVERT(varchar(50),Ganancia) as EstratoGanancia
	into FactEstacionamiento
	FROM ExamenAnalisis.dbo.Estacionamiento


/*indicador entrada*/
begin tran
	update FactEstacionamiento
		set IndicativoHoraEntrada = case
                  when HoraEntrada >=0 and HoraEntrada <12 then 'Mañana'
                  else 'Tarde'
                 end
commit;

/*indicador salida*/
begin tran
	update FactEstacionamiento
		set IndicativoHoraSalida = case
                  when HoraSalida >=0 and HoraSalida <12 then 'Mañana'
                  else 'Tarde'
                 end
commit;

/*Indicador Dia Entrada Feriado */
begin tran
		IF  EXISTS
		(SELECT d.DiaFeriado, d.MesFeriado, d.NombreFeriado FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales] d, 
			[ExamenAnalisis].dbo.Estacionamiento e
			WHERE d.DiaFeriado = DATEPART(DAY,e.FechaHoraIngreso) AND d.MesFeriado = DATEPART(MONTH, e.FechaHoraIngreso))
			update FactEstacionamiento SET SalidaRestriccion = 'Feriado'
		SELECT isnull(d.NombreFeriado, '') FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales] d,
			[ExamenAnalisis].dbo.Estacionamiento e
			where d.MesFeriado = DATEPART(MONTH,e.FechaHoraIngreso) AND d.DiaFeriado = DATEPART(DAY, e.FechaHoraIngreso)
			update FactEstacionamiento SET EntradaRestriccion = 'No Feriado'
commit;

/*Indicador Dia Salida Feriado */
begin tran
		IF  EXISTS
		(SELECT d.DiaFeriado, d.MesFeriado, d.NombreFeriado FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales] d, 
			[ExamenAnalisis].dbo.Estacionamiento e
			WHERE d.DiaFeriado = DATEPART(DAY,e.FechaHoraSalida) AND d.MesFeriado = DATEPART(MONTH, e.FechaHoraSalida))
			update FactEstacionamiento SET SalidaRestriccion = 'Feriado'
		SELECT isnull(d.NombreFeriado, '') FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales] d,
			[ExamenAnalisis].dbo.Estacionamiento e
			where d.MesFeriado = DATEPART(MONTH,e.FechaHoraSalida) AND d.DiaFeriado = DATEPART(DAY, e.FechaHoraSalida)
			update FactEstacionamiento SET SalidaRestriccion = 'No Feriado'
commit;

/*Indicador Dia Resctriccion Entrada*/
/*begin tran
	select RIGHT(Placa, 1) AS UltimoDigitoPlaca FROM ExamenAnalisis.dbo.Vehiculo
		Update FactEstacionamiento set EntradaRestriccion = case 
					  when UltimoDigitoPlaca >=0 AND UltimoDigitoPlaca <=3 AND DiaSemanaEntrada =2 
					  then 'Restriccion'
					  when UltimoDigitoPlaca >=4 AND UltimoDigitoPlaca <=7 AND DiaSemanaEntrada =3  then 'Restriccion'
					  when UltimoDigitoPlaca >=8 AND UltimoDigitoPlaca <=1 AND DiaSemanaEntrada =4  then 'Restriccion'
					  when UltimoDigitoPlaca >=2 AND UltimoDigitoPlaca <=5 AND DiaSemanaEntrada =5  then 'Restriccion'
					  when UltimoDigitoPlaca >=6 AND UltimoDigitoPlaca <=9 AND DiaSemanaEntrada =6  then 'Restriccion'
		else 'NO Restriccion'
		end 
commit;*/

/*Indicador Dia Resctriccion Salida*/
/*begin tran
	update FactEstacionamiento
		set SalidaRestriccion = case
                  when UltimoDigitoPlaca >=0 AND <=3 AND DiaSemanaSalida =2  then 'Restriccion'
                  when UltimoDigitoPlaca >=4 AND <=7 AND DiaSemanaSalida =3  then 'Restriccion'
				  when UltimoDigitoPlaca >=8 AND <=1 AND DiaSemanaSalida =4  then 'Restriccion'
				  when UltimoDigitoPlaca >=2 AND <=5 AND DiaSemanaSalida =5  then 'Restriccion'
				  when UltimoDigitoPlaca >=6 AND <=9 AND DiaSemanaSalida =6  then 'Restriccion'
                  else 'NO Restriccion'
                 end
commit;*/


/*estrato Hora Entrada*/
begin tran 
	update FactEstacionamiento set EstratoHoraEntrada =
	( select e.Descripcion from ParqueoEstratos e 
		where HoraEntrada > = e.LimiteInferior and HoraEntrada < e.LimiteSuperior 
		and e.TipoEstrato = 'HoraEntrada' );   
commit;

/*estrato Hora Salida*/
begin tran 
	update FactEstacionamiento set EstratoHoraSalida =
	( select e.Descripcion from ParqueoEstratos e 
		where HoraSalida > = e.LimiteInferior and HoraSalida < e.LimiteSuperior 
		and e.TipoEstrato = 'HoraSalida' );   
commit;

/*estrato cantidad de minutos*/
begin tran 
	update FactEstacionamiento set EstratoCantMinutos =
	( select e.Descripcion from ParqueoEstratos e 
		where CantMinutos >= e.LimiteInferior and CantMinutos < e.LimiteSuperior 
		and e.TipoEstrato = 'CantMinutos' );   
commit;

/*estrato ganancia*/
begin tran
	update FactEstacionamiento set EstratoGanancia =
	( select e.Descripcion from  [dbo].[ParqueoEstratos] e 
		where Ganancia >= e.LimiteInferior and Ganancia < e.LimiteSuperior
		and e.TipoEstrato = 'Ganancia'
		);
commit;
use CuboParqueo
if
	(OBJECT_ID ('dbo.FactEstacionamiento', 'U') > 0) drop table FactEstacionamiento; 
GO

SELECT 
TarifaBase, Mantenimiento, ImpVentas, FechaHoraIngreso,
DATEPART(HOUR, FechaHoraIngreso) as HoraEntrada, CONVERT(varchar(50), FechaHoraIngreso) as EstratoHoraEntrada,
CONVERT(varchar(10), DATEPART(HOUR, FechaHoraIngreso)) as IndicativoHoraEntrada,
DATEPART(DAY,FechaHoraIngreso) as DiaEntrada,
CONVERT(varchar(25),DATEPART(DAY, FechaHoraIngreso),DATEPART(MONTH, FechaHoraIngreso)) as DiaEntradaFeriado,
CONVERT(varchar(10), DATEPART(DAY, FechaHoraIngreso)) as RestriccionEntrada,
FechaHoraSalida,
DATEPART(HOUR, FechaHoraSalida) as HoraSalida, CONVERT(varchar(50), FechaHoraSalida) as EstratoHoraSalida,
CONVERT(varchar(10), DATEPART(HOUR, FechaHoraSalida)) as IndicativoHoraSalida,
DATEPART(DAY,FechaHoraSalida) as DiaSalida,
CONVERT(varchar(25),DATEPART(DAY, FechaHoraSalida)) as DiaSalidaFeriado,
CONVERT(varchar(10), DATEPART(DAY, FechaHoraSalida)) as RestriccionSalida,
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
                  when HoraEntrada >=0 and HoraEntrada <12 then 'Ma�ana'
                  else 'Tarde'
                 end
commit;

/*indicador salida*/
begin tran
	update FactEstacionamiento
		set IndicativoHoraSalida = case
                  when HoraSalida >=0 and HoraSalida <12 then 'Ma�ana'
                  else 'Tarde'
                 end
commit;

/*Indicador Feriado FALTA POCO*/
/*begin tran
	update FactEstacionamiento set DiaEntradaFeriado =
	if (select COUNT(*) FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales] d, [ExamenAnalisis].dbo.Estacionamiento e
		where d.DiaFeriado = DATEPART(DAY,e.FechaHoraIngreso) AND d.MesFeriado = DATEPART(MONTH, e.FechaHoraIngreso) ) >0
	select ISNULL(d.NombreFeriado, 'Dia no feriado') FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales] d, [ExamenAnalisis].dbo.Estacionamiento e
		where d.DiaFeriado = DATEPART(DAY,e.FechaHoraIngreso) AND d.MesFeriado = DATEPART(MONTH, e.FechaHoraIngreso)
	else
	select 'Dia no feriado'
commit;*/

/*BEGIN TRAN 
UPDATE FactEstacionamiento
	IF (SELECT count(*) FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales]
		where [MesFeriado] = DATEPART(MONTH,@fecha) AND [DiaFeriado] = DATEPART(DAY, @fecha) ) >0
	SELECT isnull([NombreFeriado], 'hola') FROM [ExamenAnalisis].dbo.[DiasFeriadosAnuales]
		where [MesFeriado] = DATEPART(MONTH,@fecha) AND [DiaFeriado] = DATEPART(DAY, @fecha)
ELSE 
SELECT 'hello'
COMMIT;*/

/*Indicador Dia Resctriccion CASE PARA PLACA*/
/*begin tran
	update FactEstacionamiento
		set RestriccionEntrada = 
				(Select v.Placa FROM [ExamenAnalisis].[dbo].[Vehiculo] v
				case
                  when v.Placa =   then 'Ma�ana'
                  else 'Tarde'
                 end
				 );
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
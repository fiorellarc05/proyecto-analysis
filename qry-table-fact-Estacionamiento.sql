use CuboParqueo
if
	(OBJECT_ID ('dbo.FactEstacionamiento', 'U') > 0) drop table FactEstacionamiento; 
GO

SELECT 
TarifaBase, Mantenimiento, ImpVentas, TotalACobrar, FechaHoraIngreso,
DATEPART(HOUR, FechaHoraIngreso) as HoraEntrada, CONVERT(varchar(50), FechaHoraIngreso) as EstratoHoraEntrada,
CONVERT(varchar(10), DATEPART(HOUR, FechaHoraIngreso)) as IndicativoHoraEntrada,
CONVERT(varchar(25),DATEPART(DAY, FechaHoraIngreso),DATEPART(MONTH, FechaHoraIngreso)) as DiaEntradaFeriado,
FechaHoraSalida,
DATEPART(HOUR, FechaHoraSalida) as HoraSalida, CONVERT(varchar(50), FechaHoraSalida) as EstratoHoraSalida,
CONVERT(varchar(10), DATEPART(HOUR, FechaHoraSalida)) as IndicativoHoraSalida,
CONVERT(varchar(25),DATEPART(DAY, FechaHoraSalida)) as DiaSalidaFeriado,
DATEDIFF(MINUTE,FechaHoraIngreso,FechaHoraSalida) as CantMinutos, 
CONVERT(VARCHAR(50),DATEDIFF(MINUTE,FechaHoraSalida,FechaHoraIngreso)) as EstratoCantMinutos,
Ganancia, CONVERT(varchar(50),Ganancia) as EstratoGanancia
into FactEstacionamiento
FROM ExamenAnalisis.dbo.Estacionamiento

begin tran
	update FactEstacionamiento
		set IndicativoHoraEntrada = case
                  when HoraEntrada >=0 and HoraEntrada <12 then 'Mañana'
                  else 'Tarde'
                 end
commit;

begin tran
	update FactEstacionamiento
		set IndicativoHoraSalida = case
                  when HoraSalida >=0 and HoraSalida <12 then 'Mañana'
                  else 'Tarde'
                 end
commit;

/*FALTA POCO
begin tran
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

/*CASE PARA PLACA
begin tran
	update FactEstacionamiento
		set IndicativoHoraSalida = case
                  when HoraSalida >=0 and HoraSalida <12 then 'Mañana'
                  else 'Tarde'
                 end
commit;*/

begin tran
	update FactEstacionamiento set EstratoGanancia =
	( select e.Descripcion from  [dbo].[ParqueoEstratos] e 
		where Ganancia >= e.LimiteInferior and Ganancia < e.LimiteSuperior
		and e.TipoEstrato = 'Ganancia'
		);
commit;

begin tran 
	update FactEstacionamiento set EstratoHoraEntrada =
	( select e.Descripcion from ParqueoEstratos e 
		where HoraEntrada > = e.LimiteInferior and HoraEntrada < e.LimiteSuperior 
		and e.TipoEstrato = 'HoraEntrada' );   
commit;

begin tran 
	update FactEstacionamiento set EstratoHoraSalida =
	( select e.Descripcion from ParqueoEstratos e 
		where HoraSalida > = e.LimiteInferior and HoraSalida < e.LimiteSuperior 
		and e.TipoEstrato = 'HoraSalida' );   
commit;

begin tran 
	update FactEstacionamiento set EstratoCantMinutos =
	( select e.Descripcion from ParqueoEstratos e 
		where CantMinutos >= e.LimiteInferior and CantMinutos < e.LimiteSuperior 
		and e.TipoEstrato = 'CantMinutos' );   
commit;





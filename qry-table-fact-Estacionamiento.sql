use CuboParqueo
if
	(OBJECT_ID ('dbo.FactEstacionamiento', 'U') > 0) drop table FactEstacionamiento; 
GO

SELECT 
TarifaBase, Ganancia, Mantenimiento, ImpVentas, TotalACobrar,
DATEPART(HOUR, FechaHoraIngreso) as HoraEntrada, CONVERT(varchar(50), FechaHoraIngreso) as EstratoHoraEntrada,
FORMAT(FechaHoraIngreso,'dd/MM') as DiaEntrada,  CONVERT(varchar(50),FORMAT(FechaHoraIngreso,'dd/MM')) as Feriado1,
DATEPART(HOUR, FechaHoraSalida) as HoraSalida, CONVERT(varchar(50), FechaHoraSalida) as EstratoHoraSalida,
FORMAT(FechaHoraSalida,'dd/MM') as DiaSalida, CONVERT(varchar(50),FORMAT(FechaHoraIngreso,'dd/MM')) as Feriado2,
DATEDIFF(MINUTE,FechaHoraIngreso,FechaHoraSalida) as CantMinutos, CONVERT(VARCHAR(50),DATEDIFF(MINUTE,FechaHoraSalida,FechaHoraIngreso)) as EstratoCantMinutos,
Ganancia as EstratoGanacia 
into FactEstacionamiento
FROM ExamenAnalisis.dbo.Estacionamiento

/*begin tran
UPDATE FactEstacionamiento set Feriado1 =
(SELECT f.DiaEntrada, d.NombreFeriado FROM CuboParqueo.dbo.FactEstacionamiento f
	LEFT JOIN ExamenAnalisis.dbo.DiasFeriadosAnuales d ON f.DiaEntrada = d.NombreFeriado
	WHERE NombreFeriado is NULL 
	);
commit;
*/

begin tran 
	update FactEstacionamiento set EstratoGanacia =
	( select e.Descripcion from ParqueoEstratos e 
		where Ganancia >= e.LimiteInferior and Ganancia < e.LimiteSuperior 
		and e.TipoEstrato = 'Ganacia' );   
commit;

begin tran 
	update FactEstacionamiento set EstratoHoraEntrada = 
	( select e.Descripcion from ParqueoEstratos e 
		where HoraEntrada >= e.LimiteInferior and HoraEntrada < e.LimiteSuperior 
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
		where CantMinutos	>= e.LimiteInferior and CantMinutos < e.LimiteSuperior 
		and e.TipoEstrato = 'CantMinutos' );   
commit;





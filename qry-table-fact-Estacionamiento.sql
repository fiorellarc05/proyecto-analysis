
use CuboParqueo
if
	(OBJECT_ID ('dbo.FactEstacionamiento', 'U') > 0) drop table FactEstacionamiento; 
GO


SELECT TarifaBase, Ganancia, Mantenimiento, ImpVentas, TotalACobrar, 
DATEPART(HOUR, FechaHoraIngreso) as HoraEntrada, DATEPART(DAY, FechaHoraIngreso) as DiaEntrada, 
DATEPART(HOUR, FechaHoraSalida) as HoraSalida, DATEPART(DAY, FechaHoraSalida) as DiaSalida,  
DATEDIFF(mi,FechaHoraSalida,FechaHoraIngreso) as CantidadMinutos,
DATEPART(HOUR, FechaHoraIngreso), convert(varchar(50),datepart(HOUR, FechaHoraIngreso)) as EstratoHoraEntrada,
DATEPART(HOUR, FechaHoraSalida) as EstratoHoraSalida,
DATEPART(DAY, FechaHoraIngreso) as EstratoDiaEntrada,
DATEPART(DAY, FechaHoraSalida) as EstratoDiaSalida,
DATEDIFF(mi,FechaHoraSalida,FechaHoraIngreso) as EstratoCantMinutos,
Ganancia as EstratoGanacia 

into FactEstacionamiento FROM ExamenAnalisis.dbo.Estacionamiento



begin tran 
update FactEstacionamiento set EstratoGanacia = ( select e.Descripcion from ParqueoEstratos e 
where Ganancia >= e.LimiteInferior and Ganancia < e.LimiteSuperior and e.TipoEstrato = 'Ganacia' );   
commit;

begin tran 
update FactEstacionamiento set EstratoHoraEntrada = ( select e.Descripcion from ParqueoEstratos e 
where HoraEntrada	>= e.LimiteInferior and HoraEntrada < e.LimiteSuperior and e.TipoEstrato = 'HoraEntrada' );   
commit;

begin tran 
update FactEstacionamiento set EstratoHoraSalida = ( select e.Descripcion from ParqueoEstratos e 
where HoraSalida	>= e.LimiteInferior and HoraSalida < e.LimiteSuperior and e.TipoEstrato = 'HoraSalida' );   
commit;

begin tran 
update FactEstacionamiento set EstratoDiaEntrada = ( select e.Descripcion from ParqueoEstratos e 
where DiaEntrada	>= e.LimiteInferior and DiaEntrada < e.LimiteSuperior and e.TipoEstrato = 'DiaRestriccion' );   
commit;

begin tran 
update FactEstacionamiento set EstratoDiaSalida = ( select e.Descripcion from ParqueoEstratos e 
where DiaSalida	>= e.LimiteInferior and DiaSalida < e.LimiteSuperior and e.TipoEstrato = 'DiaRestriccion' );   
commit;

begin tran 
update FactEstacionamiento set EstratoCantMinutos = ( select e.Descripcion from ParqueoEstratos e 
where CantidadMinutos	>= e.LimiteInferior and CantidadMinutos < e.LimiteSuperior and e.TipoEstrato = 'CantMinutos' );   
commit;





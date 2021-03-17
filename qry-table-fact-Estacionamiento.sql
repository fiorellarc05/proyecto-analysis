use CuboParqueo
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactEstacionamiento]') AND type in (N'U'))
DROP TABLE [dbo].[FactEstacionamiento]
GO

SELECT TarifaBase, Ganancia, Mantenimiento, ImpVentas, TotalACobrar, 
DATEPART(HOUR, FechaHoraIngreso) as HoraEntrada, DATEPART(DAY, FechaHoraIngreso) as DiaEntrada,
DATEPART(HOUR, FechaHoraSalida) as HoraSalida, DATEPART(DAY, FechaHoraSalida) as DiaSalida, 
DATEDIFF(mi,FechaHoraSalida,FechaHoraIngreso) as CantidadMinutos,
HoraEntrada as EstratoHoraEntrada,
HoraSalida as EstratoHoraSalida,
DiaEntrada as EstratoDiaEntrada,
DiaSalida as EstratoDiaSalida,
Ganancia as EstratoGancia
into FactEstacionamiento FROM  ExamenAnalisis.dbo.Estacionamiento ;
 

begin tran 
update FactEstacionamiento set EstratoGancia = ( select e.Descripcion from ParqueoEstratos e 
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





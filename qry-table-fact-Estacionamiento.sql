use CuboParqueo   if (OBJECT_ID ('dbo.FactEstacionamiento', 'U') > 0) drop table FactEstacionamiento;


SELECT CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, Freight, ShipName, ShipCity,
isnull(ShipRegion,'N/A') as ShipRegion, ShipCountry, convert (varchar(50), ' ') EstratoFlete 
into FactEstacionamiento FROM ExamenAnalisis.dbo.Estacionamiento ;


begin tran update FactEstacionamiento set EstratoHoraEntrada = ( select e.Descripcion from ParqueoEstratos e 
where HoraEntrada >= e.LimiteInferior and HoraEntrada < e.LimiteSuperior and e.TipoEstrato = 'HoraEntrada' );   commit;


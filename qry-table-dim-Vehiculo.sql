use CuboParqueo   if
	(OBJECT_ID ('dbo.DimVehiculo', 'U') > 0) drop table DimVehiculo; 

use ExamenAnalisis  
	SELECT v.IDVehiculo, 
	v.Placa +' - '+ v.NombreTipoVehiculo as ParqueoInfo,
	v.NombreFabricante +' - '+ v.AbreviaturaPais as InfoFabricante,
	v.NombrePais +' - '+ v.NombreRegionContinente +' - '+ v.NombreContinente as InfoProcedencia,
	v.Ano as EstratoAnoFabricacion
  into CuboParqueo.dbo.DimVehiculo FROM Vehiculo v 


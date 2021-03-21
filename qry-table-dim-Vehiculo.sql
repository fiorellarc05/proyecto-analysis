use CuboParqueo  
	if
	(OBJECT_ID ('dbo.DimVehiculo', 'U') > 0) drop table DimVehiculo; 
	GO

use ExamenAnalisis  

	SELECT [ExamenAnalisis].dbo.Vehiculo.Ano, CONVERT(varchar(50),Ano) as EstratoAnoFabricacion,
	[ExamenAnalisis].dbo.TipoVehiculo.Descripcion as NombreTipoVehiculo,[ExamenAnalisis].dbo.Fabricante.NombreFabricante
	into CuboParqueo.dbo.DimVehiculo
	FROM [ExamenAnalisis].dbo.Vehiculo, [ExamenAnalisis].dbo.TipoVehiculo,  [ExamenAnalisis].dbo.Fabricante
	
	
	/*
	[ExamenAnalisis].dbo.Pais.NombrePais as PaisFabricante, [ExamenAnalisis].dbo.Pais.AbreviaturaPais as AbrevPaisFabricante,
	[ExamenAnalisis].dbo.RegionContinente.Descripcion as NombreRegionContinenteFabricante, 
	[ExamenAnalisis].dbo.Continente.Descripcion as NombreContinenteFabricante*/
	
	 /*, [ExamenAnalisis].dbo.Fabricante, [ExamenAnalisis].dbo.Pais,
	[ExamenAnalisis].dbo.RegionContinente, [ExamenAnalisis].dbo.Continente*/

	/*estrato año de fabricacion*/
	/*begin tran 
		update DimVehiculo set EstratoAnoFabricacion =
		( select e.Descripcion from ParqueoEstratos e 
			where Ano >= e.LimiteInferior and Ano < e.LimiteSuperior 
			and e.TipoEstrato = 'AnoFabricacion' );   
	commit;*/
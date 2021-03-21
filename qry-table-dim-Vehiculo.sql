use CuboParqueo   if
	(OBJECT_ID ('dbo.DimVehiculo', 'U') > 0) drop table DimVehiculo; 
	GO

use ExamenAnalisis  

	SELECT [ExamenAnalisis].dbo.Vehiculo.IDVehiculo, [ExamenAnalisis].dbo.Vehiculo.Ano, [ExamenAnalisis].dbo.Vehiculo.Placa,
	[ExamenAnalisis].dbo.TipoVehiculo.Descripcion as NombreTipoVehiculo, [ExamenAnalisis].dbo.Fabricante.NombreFabricante,
	[ExamenAnalisis].dbo.Pais.NombrePais as PaisFabricante, [ExamenAnalisis].dbo.Pais.AbreviaturaPais as AbrevPaisFabricante,
	[ExamenAnalisis].dbo.RegionContinente.Descripcion as NombreRegionContinenteFabricante, 
	[ExamenAnalisis].dbo.Continente.Descripcion as NombreContinenteFabricante
	
	FROM [ExamenAnalisis].dbo.Vehiculo, [ExamenAnalisis].dbo.TipoVehiculo, [ExamenAnalisis].dbo.Fabricante, [ExamenAnalisis].dbo.Pais,
	[ExamenAnalisis].dbo.RegionContinente, [ExamenAnalisis].dbo.Continente

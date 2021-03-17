use CuboParqueo   if
	(OBJECT_ID ('dbo.DimVehiculo', 'U') > 0) drop table DimVehiculo; 
	GO

use ExamenAnalisis  
	SELECT v.IDVehiculo, v.Placa, v.Ano,
	t.Descripcion as NombreTipoVehìculo,
	f.NombreFabricante as NombreFabricante,
	p.NombrePais as NombrePaisFabricante,
	p.AbreviaturaPais as AbreviaturaPaisFabricante,
	r.Descripcion as NombreRegionContinenteFabricante,
	c.Descripcion as NombreContinenteFabricante,
	v.Ano as EstratoAnoFabricacion
  into CuboParqueo.dbo.DimVehiculo FROM Vehiculo v, TipoVehiculo t, Fabricante f, Pais p, RegionContinente r, Continente c


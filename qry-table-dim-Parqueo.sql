use CuboParqueo   
if
	(OBJECT_ID ('dbo.DimParqueo', 'U') > 0) drop table DimParqueo; 

use ExamenAnalisis
  
	SELECT [ExamenAnalisis].dbo.Parqueo.IDParqueo,
	[ExamenAnalisis].dbo.Distrito.Descripcion as NombreDistrito, 
	[ExamenAnalisis].dbo.Canton.Descripcion as NombreCanton, 
	CONVERT(varchar(50),Canton.IDProvincia) as Provincia
	into CuboParqueo.dbo.DimParqueo
	FROM [ExamenAnalisis].dbo.Parqueo,[ExamenAnalisis].dbo.Distrito, [ExamenAnalisis].dbo.Canton


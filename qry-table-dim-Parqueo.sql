use CuboParqueo   
if
	(OBJECT_ID ('dbo.DimParqueo', 'U') > 0) drop table DimParqueo; 

use ExamenAnalisis
  
	SELECT [ExamenAnalisis].dbo.Distrito.Descripcion as NombreDistrito, 
	[ExamenAnalisis].dbo.Canton.Descripcion AS NombreCanton,  [ExamenAnalisis].dbo.Provincia.Descripcion as NombreProvincia
	into CuboParqueo.dbo.DimParqueo
	FROM [ExamenAnalisis].dbo.Distrito, [ExamenAnalisis].dbo.Canton, [ExamenAnalisis].dbo.Provincia


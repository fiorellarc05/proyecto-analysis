use CuboParqueo   
if
	(OBJECT_ID ('dbo.DimParqueo', 'U') > 0) drop table DimParqueo; 

use ExamenAnalisis
  
	SELECT  q.IDParqueo,
	d.Descripcion as NombreDistrito,
	c.Descripcion as NombreCanton,
	p.Descripcion as NombreProvincia
	
  into CuboParqueo.dbo.DimParqueo FROM [ExamenAnalisis].dbo.Parqueo q, [ExamenAnalisis].dbo.Distrito d,  [ExamenAnalisis].dbo.Canton c, [ExamenAnalisis].dbo.Provincia p

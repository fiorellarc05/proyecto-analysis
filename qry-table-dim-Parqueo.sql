use CuboParqueo   if
	(OBJECT_ID ('dbo.DimParqueo', 'U') > 0) drop table DimParqueo; 

use ExamenAnalisis
  
	SELECT  p.IDParqueo, 
	p.NombreDistrito +' - '+ p.NombreCanton +' - '+ p.NombreProvincia as ParqueoInfo
	
  into CuboParqueo.dbo.DimParqueo FROM  [ExamenAnalisis].dbo.Parqueo p


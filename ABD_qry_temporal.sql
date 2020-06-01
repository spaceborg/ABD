
SELECT cli.idCliente, cli.nomCliente, cli.apeCliente,telCliente
  FROM ventas ven INNER JOIN clientes cli 
    ON cli.idCliente = ven.idCliente
 WHERE ven.totVenta >= 50000
 GROUP BY cli.idCliente
 ORDER BY nomCliente;
 
 UPDATE ventas 
    SET totVenta = 82000 
  WHERE idVenta BETWEEN 28 AND 31;

  
  SELECT * FROM ventas;
  SELECT * FROM productos;
  SELECT * FROM detalleventas;


SELECT pro.idProducto as codigo, pro.nomProducto as Producto, count(pro.nomProducto) as Cantidad_Vendida
  FROM ventas ven INNER JOIN detalleventas det
    ON det.idVenta = ven.idVenta INNER JOIN productos pro
    ON pro.idProducto = det.idProducto 
 WHERE pro.nomProducto = 'adhesivo tela' or pro.nomProducto = 'arroz'
 GROUP BY pro.idProducto, pro.nomProducto
 ORDER BY pro.nomProducto;







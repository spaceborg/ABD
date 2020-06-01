drop procedure if exists pa_cantidad_ventas;

delimiter //
create procedure pa_cantidad_ventas(in p_producto1 varchar(45), 
								    in p_producto2 varchar(45))
begin
  SELECT pro.nomProducto as Producto, sum(det.cantDetVenta) as Cantidad_Vendida
    FROM ventas ven INNER JOIN detalleventas det
      ON det.idVenta = ven.idVenta INNER JOIN productos pro
      ON pro.idProducto = det.idProducto 
   WHERE pro.nomProducto = p_producto1 or pro.nomProducto = p_producto2
   GROUP BY pro.idProducto, pro.nomProducto
   ORDER BY pro.nomProducto;
end //
delimiter ;

call pa_cantidad_ventas('adhesivo tela','arroz');
call pa_cantidad_ventas('sal','harina');
call pa_cantidad_ventas('leche','huevos');
call pa_cantidad_ventas('suavizante','cloro');



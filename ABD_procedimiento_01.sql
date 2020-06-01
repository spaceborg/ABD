
drop procedure if exists pa_clientes_premium;

delimiter //
create procedure pa_clientes_premium()
begin
  SELECT cli.idCliente, cli.nomCliente, cli.apeCliente,telCliente
    FROM ventas ven INNER JOIN clientes cli 
      ON cli.idCliente = ven.idCliente
   WHERE ven.totVenta >= 50000
   GROUP BY cli.idCliente
   ORDER BY nomCliente;
end //
delimiter ;

call pa_clientes_premium();

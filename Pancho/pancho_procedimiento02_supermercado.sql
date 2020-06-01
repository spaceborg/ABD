drop procedure if exists proc_ctd_vta;

delimiter //
create procedure proc_ctd_vta(in p_prd1 int,in p_prd2 int)
begin
  SELECT p.nom_prd as Nombre_Producto
       , count(p.nom_prd) as Cantidad_total
    FROM ventas v INNER JOIN detalle_ventas d
      ON d.ide_vta = v.ide_vta INNER JOIN productos p
      ON p.ide_prd = d.ide_prd 
   WHERE p.ide_prd = p_prd1 
      or p.ide_prd = p_prd2
   GROUP BY p.ide_prd, p.nom_prd ;
end //
delimiter ;

call proc_ctd_vta(7,8);

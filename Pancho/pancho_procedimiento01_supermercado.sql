drop procedure if exists proc_cli_metropolitana;

delimiter //
create procedure proc_cli_metropolitana()
begin
  SELECT c.ide_cli
       , c.nom_cli
	   , c.ape_cli
	   , r.nom_reg
       , cm.nom_com
    FROM ventas v INNER JOIN clientes c
      ON c.ide_cli = v.ide_cli INNER JOIN comunas cm
      ON cm.ide_com = c.ide_com INNER JOIN regiones r
      ON r.ide_reg = cm.ide_reg      
   WHERE cm.ide_reg = 13
   ORDER BY c.nom_cli;
end //
delimiter ;

call proc_cli_metropolitana();


--  1. Cantidad y promedio de productos  vendidos por cliente.
DROP VIEW IF EXISTS vta_por_cli;
CREATE VIEW vta_por_cli AS
SELECT c.nom_cli as Nombre
     , c.ape_cli as Apellido
     , p.nom_prd as Producto
     , d.ctd_det_vta as cantidad_cliente
     , AVG(d.pre_det_vta) as promedio_venta     
  FROM Detalle_ventas d INNER JOIN ventas v
    ON d.ide_vta = v.ide_vta INNER JOIN clientes c
    ON v.ide_cli = c.ide_cli INNER JOIN productos p
    ON p.ide_prd = d.ide_prd
GROUP BY Nombre, Apellido;


-- 2. Cantidad y promedio de productos  vendidos por categoría.
DROP VIEW IF EXISTS vta_por_cat;
CREATE VIEW vta_por_cat AS
SELECT c.nom_cat as categorias
     , SUM(d.ctd_det_vta) as cantidad_total
     , AVG(d.pre_det_vta) as promedio
  FROM detalle_ventas d INNER JOIN ventas v 
    ON d.ide_vta = v.ide_vta INNER JOIN productos p
    ON p.ide_prd = d.ide_prd INNER JOIN subcategoria s
    ON s.ide_sub = p.ide_sub INNER JOIN categorias c
    ON c.ide_cat = s.ide_cat
GROUP BY categorias;


-- 3. Promedio de precios de productos vendidos. (Vistas)
DROP VIEW IF EXISTS pre_prom_por_prd;
CREATE VIEW pre_prom_por_prd AS
SELECT p.nom_prd as producto
     , SUM(d.ctd_det_vta) as cantidad_total
     , AVG(d.pre_det_vta) as promedio
  FROM detalle_ventas d INNER JOIN ventas v 
    ON d.ide_vta = v.ide_vta INNER JOIN productos p
    ON p.ide_prd = d.ide_prd
GROUP BY producto
ORDER BY producto;


-- Vistas
SELECT * FROM vta_por_cli;
SELECT * FROM vta_por_cat;
SELECT * FROM pre_prom_por_prd;


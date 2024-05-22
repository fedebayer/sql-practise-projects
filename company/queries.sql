**Según el modelo dado resolver:**

1. Mostrar el código, razón social de todos los clientes cuyo límite de crédito sea mayor o igual a $ 1000 ordenado por código de cliente.
2. Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por cantidad vendida.
3. Realizar una consulta que muestre código de producto, nombre de producto y el stock total, sin importar en que deposito se encuentre, 
los datos deben ser ordenados por nombre del artículo de menor a mayor.
4. Realizar una consulta que muestre para todos los artículos código, detalle y cantidad de artículos que lo componen. 
Mostrar solo aquellos artículos para los cuales el stock promedio por depósito sea mayor a 100.
5. Realizar una consulta que muestre código de artículo, detalle y cantidad de egresos de stock que se realizaron para ese artículo 
en el año 2012 (egresan los productos que fueron vendidos). Mostrar solo aquellos que hayan tenido más egresos que en el 2011.
6. Mostrar para todos los rubros de artículos código, detalle, cantidad de artículos de ese rubro y stock total de ese rubro de 
artículos. Solo tener en cuenta aquellos artículos que tengan un stock mayor al del artículo ‘00000000’ en el depósito ‘00’.

/*PUNTO 1
Mostrar el código, razón social de todos los clientes cuyo límite de crédito sea mayor o igual a $ 1000 ordenado por código de cliente.*/

SELECT clie_codigo, clie_razon_social
FROM CAP_Practica_2.dbo.Cliente
WHERE clie_limite_credito >= 1000
ORDER BY clie_codigo;

/*PUNTO 2
Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por cantidad vendida.*/


SELECT P.prod_codigo, P.prod_detalle, SUM(ITF.item_cantidad) AS cantidad_vendida
FROM CAP_Practica_2.dbo.Producto AS P
INNER JOIN CAP_Practica_2.dbo.Item_Factura AS ITF ON P.prod_codigo = ITF.item_producto
INNER JOIN CAP_Practica_2.dbo.Factura AS F ON ITF.item_tipo = F.fact_tipo
                        AND ITF.item_sucursal = F.fact_sucursal
                        AND ITF.item_numero = F.fact_numero
WHERE YEAR(F.fact_fecha) = 2012
GROUP BY P.prod_codigo, P.prod_detalle, F.fact_fecha
ORDER BY cantidad_vendida DESC;

/*PUNTO 3
Realizar una consulta que muestre código de producto, nombre de producto y el stock total, 
sin importar en que deposito se encuentre, los datos deben ser ordenados por nombre del artículo de menor a mayor.*/

SELECT P.prod_codigo, P.prod_detalle AS nombre_producto, SUM(S.stoc_cantidad) AS stock_total
FROM CAP_Practica_2.dbo.Producto AS P
LEFT JOIN CAP_Practica_2.dbo.STOCK AS S ON P.prod_codigo = S.stoc_producto
GROUP BY P.prod_codigo, P.prod_detalle
ORDER BY nombre_producto;
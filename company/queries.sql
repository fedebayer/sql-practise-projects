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
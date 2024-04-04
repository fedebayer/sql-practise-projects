PUNTOS
1. Listar tipo de documento (descripción), número de doc., condición de IVA (descripción), apellido y nombres de los clientes
2. Listar el CUIT y Razón Social y condición de IVA (descripción) de los proveedores que posean sean Monotributristas ordenados por CUIT
3. Listar los productos cuyo precio de venta sea mayor a 100 y menor a 250 (ver BEETWEN)
4. Listar los 5 productos más caros (mostrar código, descripción, precio de compra)
5. Listar los 5 productos más baratos (mostrar código, descripción, precio de compra)

/*Punto 1*/
SELECT 
    TD.Descripcion AS "TipoDocumento",
    C.NumeroDocumento,
    CI.Descripcion AS "CondicionIva",
    C.Apellido,
    C.Nombre
FROM Cliente C
INNER JOIN CondicionIva CI ON C.CondicionIva = CI.Codigo
INNER JOIN TipoDocumento TD ON C.TipoDocumento = TD.Id;

/*Punto 2*/
SELECT
    P.CUIT,
    P.RazonSocial,
    CI.Descripcion AS "CondicionIva"
FROM Proveedor P
INNER JOIN CondicionIva CI ON P.CondicionIva = CI.Codigo
WHERE CI.Descripcion = 'Monotributo'
ORDER BY P.CUIT;

/*Punto 3*/
SELECT
    Codigo,
    Descripcion,
    PrecioVenta
FROM Producto
WHERE PrecioVenta BETWEEN 100 AND 250;
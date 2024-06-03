/*1. Hacer una función que dado un artículo y un deposito devuelva un string que indique el estado del depósito según el artículo. Si la cantidad almacenada es menor al límite retornar “OCUPACION DEL DEPOSITO XX %” siendo XX el % de ocupación. Si la cantidad almacenada es mayor o igual al límite retornar “DEPOSITO COMPLETO”
2. Realizar una función que dado un artículo y una fecha, retorne el stock que existía a esa fecha
3. Cree el/los objetos de base de datos necesarios para actualizar la columna de empleado empl_comision con la sumatoria del total de lo vendido por ese empleado a lo largo del último año. Se deberá retornar el código del vendedor que más vendió (en monto) a lo largo del último año.
4. Realizar un procedimiento que complete con los datos existentes en el modelo provisto la tabla de hechos denominada `Fact_table` tiene la siguiente definición:
    
CREATE TABLE Fact_table
( anio char(4),
mes char(2),
familia char(3),
rubro char(4),
zona char(3),
cliente char(6),
producto char(8),
cantidad decimal(12,2),
monto decimal(12,2)
)
ALTER TABLE Fact_table
ADD CONSTRAINT PRIMARY KEY (anio,mes,familia,rubro,zona,cliente,producto)
    
5. Realizar los triggers para las distintas operaciones (Alta, Baja, Modificación) sobre la tabla “clientes”, generando un nuevo registro en la tabla de auditoría.
6. Realizar una vista de los siguientes datos del producto:
    - Código
    - Detalle
    - Precio
    - Descripción de Familia
    - Descripción de Rubro
    - Descripción de Envase*/
 
 /*PUNTO 1
Hacer una función que dado un artículo y un deposito devuelva un string que indique 
el estado del depósito según el artículo. Si la cantidad almacenada es menor al límite
retornar “OCUPACION DEL DEPOSITO XX %” siendo XX el % de ocupación. Si la cantidad 
almacenada es mayor o igual al límite retornar “DEPOSITO COMPLETO”*/

USE [FB_Practica_SQL_1_2]
GO

CREATE FUNCTION dbo.Get_Deposit_State (@article char(8), @deposit char(2))
RETURNS varchar(50)
AS
BEGIN
    DECLARE @quantity decimal(12,2)
    DECLARE @max_stock decimal(12,2)
    DECLARE @occupation decimal(5,2)
    DECLARE @state varchar(50)

    SELECT @quantity = stoc_cantidad, @max_stock = stoc_stock_maximo
    FROM CAP_Practica_2.dbo.STOCK
    WHERE stoc_producto = @article AND stoc_deposito = @deposit

    SET @occupation = (@quantity / @max_stock) * 100

    IF @quantity < @max_stock
        SET @state = 'OCUPACION DEL DEPOSITO ' + CONVERT(varchar(5), @occupation) + '%'
    ELSE
        SET @state = 'DEPOSITO COMPLETO'

    RETURN @state
END

SELECT dbo.Get_Deposit_State('00000030', '00') AS 'Estado Deposito';

/*PUNTO 2
Realizar una función que dado un artículo y una fecha, retorne el stock que existía a esa fecha*/

CREATE FUNCTION dbo.Get_Stock_At_Date (@article char(8), @date smalldatetime)
RETURNS decimal(12, 2)
AS
BEGIN
    DECLARE @stock decimal(12, 2)
    SELECT @stock = stoc_cantidad
    FROM CAP_Practica_2.dbo.STOCK
    WHERE stoc_producto = @article AND (stoc_proxima_reposicion <= @date OR stoc_proxima_reposicion IS NULL)
    ORDER BY stoc_proxima_reposicion DESC
    RETURN @stock
END

SELECT dbo.Get_Stock_At_Date('00000030', '1978-01-05 00:00:00') AS 'Stock en esa fecha';

/*PUNTO 3
Cree el/los objetos de base de datos necesarios para actualizar la columna 
de empleado empl_comision con la sumatoria del total de lo vendido por ese empleado 
a lo largo del último año. Se deberá retornar el código del vendedor que más vendió 
(en monto) a lo largo del último año.*/

CREATE TABLE dbo.Ventas_Empleado (
    empl_codigo numeric(6, 0) NOT NULL,
    total_ventas decimal(12, 2) NULL
);

INSERT INTO dbo.Ventas_Empleado (empl_codigo, total_ventas)
SELECT f.fact_vendedor, SUM(i.item_cantidad * i.item_precio)
FROM dbo.Factura f
JOIN dbo.Item_Factura i ON f.fact_tipo = i.item_tipo AND f.fact_sucursal = i.item_sucursal AND f.fact_numero = i.item_numero
WHERE f.fact_fecha >= DATEADD(year, -1, GETDATE())
GROUP BY f.fact_vendedor

SELECT * FROM dbo.Ventas_Empleado;

UPDATE dbo.Empleado
SET empl_comision = ve.total_ventas * 0.1
FROM dbo.Empleado e
JOIN (
    SELECT empl_codigo, total_ventas
    FROM dbo.Ventas_Empleado
) ve ON e.empl_codigo = ve.empl_codigo

SELECT * FROM dbo.Empleado;

SELECT TOP 1 empl_codigo
FROM dbo.Ventas_Empleado
ORDER BY total_ventas DESC

/*PUNTO 4
Realizar un procedimiento que complete con los datos existentes 
en el modelo provisto la tabla de hechos denominada Fact_table tiene la siguiente definición:

CREATE TABLE Fact_table
( anio char(4),
mes char(2),
familia char(3),
rubro char(4),
zona char(3),
cliente char(6),
producto char(8),
cantidad decimal(12,2),
monto decimal(12,2)
)
ALTER TABLE Fact_table
ADD CONSTRAINT PRIMARY KEY (anio,mes,familia,rubro,zona,cliente,producto)*/

CREATE TABLE Fact_table
( anio char(4),
mes char(2),
familia char(3),
rubro char(4),
zona char(3),
cliente char(6),
producto char(8),
cantidad decimal(12,2),
monto decimal(12,2)
CONSTRAINT [PKFact_table] PRIMARY KEY NONCLUSTERED 
(
	anio,mes,familia,rubro,zona,cliente,producto ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SELECT * FROM dbo.Fact_table;

CREATE PROCEDURE insert_data_into_fact_table
AS
BEGIN
  INSERT INTO Fact_table (anio, mes, familia, rubro, zona, cliente, producto, cantidad, monto)
  SELECT YEAR(fact_fecha), MONTH(fact_fecha), prod_familia, prod_rubro, depo_zona, fact_cliente, item_producto, item_cantidad, item_precio
  FROM dbo.Factura AS Fac
  JOIN dbo.Item_Factura AS ItemF ON Fac.fact_tipo = ItemF.item_tipo AND Fac.fact_sucursal = ItemF.item_sucursal AND Fac.fact_numero = ItemF.item_numero
  JOIN dbo.Producto AS Pro ON ItemF.item_producto = Pro.prod_codigo
  JOIN dbo.STOCK AS Sto ON Pro.prod_codigo = Sto.stoc_producto
  JOIN dbo.DEPOSITO AS Dep ON Sto.stoc_deposito = Dep.depo_codigo
END

EXEC insert_data_into_fact_table;

SELECT * FROM dbo.Fact_table;

/*PUNTO 5
Realizar los triggers para las distintas operaciones (Alta, Baja, Modificación) 
sobre la tabla “clientes”, generando un nuevo registro en la tabla de auditoría.*/
USE [FB_Practica_SQL_1_2]
GO

CREATE TABLE [dbo].[AuditoriaCliente](
    [clie_codigo] [char](6) NOT NULL,
    [clie_razon_social] [char](100) NULL,
    [clie_telefono] [char](100) NULL,
    [clie_domicilio] [char](100) NULL,
    [clie_limite_credito] [decimal](12, 2) NULL,
    [clie_vendedor] [numeric](6, 0) NULL,
    [accion] [varchar](10) NOT NULL,
    [fecha] [datetime] NOT NULL
)


SELECT * FROM dbo.AuditoriaCliente;

USE [FB_Practica_SQL_1_2]
GO

CREATE TRIGGER [dbo].[trg_Cliente_Auditoria]
ON [dbo].[Cliente]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @accion varchar(10)
    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
            SET @accion = 'UPDATE'
        ELSE
            SET @accion = 'INSERT'
    END
    ELSE
        SET @accion = 'DELETE'

    INSERT INTO [dbo].[AuditoriaCliente]
    (
        [clie_codigo],
        [clie_razon_social],
        [clie_telefono],
        [clie_domicilio],
        [clie_limite_credito],
        [clie_vendedor],
        [accion],
        [fecha]
    )
    SELECT
        [clie_codigo],
        [clie_razon_social],
        [clie_telefono],
        [clie_domicilio],
        [clie_limite_credito],
        [clie_vendedor],
        @accion,
        GETDATE()
    FROM
        inserted
    UNION ALL
    SELECT
        [clie_codigo],
        [clie_razon_social],
        [clie_telefono],
        [clie_domicilio],
        [clie_limite_credito],
        [clie_vendedor],
        @accion,
        GETDATE()
    FROM
        deleted
END


SELECT * FROM dbo.Cliente;

UPDATE dbo.Cliente SET clie_domicilio = 'LIBERTADOR' WHERE clie_domicilio = 'LIBERTADOR && CHACABUCO';

SELECT * FROM dbo.Cliente;

SELECT * FROM dbo.AuditoriaCliente;

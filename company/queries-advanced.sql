1. Hacer una función que dado un artículo y un deposito devuelva un string que indique el estado del depósito según el artículo. Si la cantidad almacenada es menor al límite retornar “OCUPACION DEL DEPOSITO XX %” siendo XX el % de ocupación. Si la cantidad almacenada es mayor o igual al límite retornar “DEPOSITO COMPLETO”
2. Realizar una función que dado un artículo y una fecha, retorne el stock que existía a esa fecha
3. Cree el/los objetos de base de datos necesarios para actualizar la columna de empleado empl_comision con la sumatoria del total de lo vendido por ese empleado a lo largo del último año. Se deberá retornar el código del vendedor que más vendió (en monto) a lo largo del último año.
4. Realizar un procedimiento que complete con los datos existentes en el modelo provisto la tabla de hechos denominada `Fact_table` tiene la siguiente definición:
    
    ```sql
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
    **ADD CONSTRAINT PRIMARY KEY (anio,mes,familia,rubro,zona,cliente,producto)**
    ```
    
5. Realizar los triggers para las distintas operaciones (Alta, Baja, Modificación) sobre la tabla “clientes”, generando un nuevo registro en la tabla de auditoría.
6. Realizar una vista de los siguientes datos del producto:
    - Código
    - Detalle
    - Precio
    - Descripción de Familia
    - Descripción de Rubro
    - Descripción de Envase
 
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
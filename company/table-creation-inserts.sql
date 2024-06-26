USE [FB_Practica_SQL_1_1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Envases](
	[enva_codigo] [numeric](6, 0) NOT NULL,
	[enva_detalle] [char](50) NULL,
 CONSTRAINT [XPKEnvases] PRIMARY KEY NONCLUSTERED 
(
	[enva_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Rubro](
	[rubr_id] [char](4) NOT NULL,
	[rubr_detalle] [char](50) NULL,
 CONSTRAINT [XPKRubro] PRIMARY KEY NONCLUSTERED 
(
	[rubr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Familia](
	[fami_id] [char](3) NOT NULL,
	[fami_detalle] [char](50) NULL,
 CONSTRAINT [XPKFamilia] PRIMARY KEY NONCLUSTERED 
(
	[fami_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Producto](
	[prod_codigo] [char](8) NOT NULL,
	[prod_detalle] [char](50) NULL,
	[prod_precio] [decimal](12, 2) NULL,
	[prod_familia] [char](3) NULL,
	[prod_rubro] [char](4) NULL,
	[prod_envase] [numeric](6, 0) NULL,
 CONSTRAINT [XPKProducto] PRIMARY KEY NONCLUSTERED 
(
	[prod_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [R_1] FOREIGN KEY([prod_familia])
REFERENCES [dbo].[Familia] ([fami_id])
GO

ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [R_1]
GO

ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [R_2] FOREIGN KEY([prod_rubro])
REFERENCES [dbo].[Rubro] ([rubr_id])
GO

ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [R_2]
GO

ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [R_5] FOREIGN KEY([prod_envase])
REFERENCES [dbo].[Envases] ([enva_codigo])
GO

ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [R_5]
GO

CREATE TABLE [dbo].[Composicion](
	[comp_cantidad] [decimal](12, 2) NULL,
	[comp_producto] [char](8) NOT NULL,
	[comp_componente] [char](8) NOT NULL,
 CONSTRAINT [XPKComposicion] PRIMARY KEY NONCLUSTERED 
(
	[comp_producto] ASC,
	[comp_componente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Composicion]  WITH CHECK ADD  CONSTRAINT [R_3] FOREIGN KEY([comp_producto])
REFERENCES [dbo].[Producto] ([prod_codigo])
GO

ALTER TABLE [dbo].[Composicion] CHECK CONSTRAINT [R_3]
GO

ALTER TABLE [dbo].[Composicion]  WITH CHECK ADD  CONSTRAINT [R_4] FOREIGN KEY([comp_componente])
REFERENCES [dbo].[Producto] ([prod_codigo])
GO

ALTER TABLE [dbo].[Composicion] CHECK CONSTRAINT [R_4]
GO

CREATE TABLE [dbo].[Zona](
	[zona_codigo] [char](3) NOT NULL,
	[zona_detalle] [char](50) NULL,
 CONSTRAINT [XPKZona] PRIMARY KEY NONCLUSTERED 
(
	[zona_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Departamento](
	[depa_codigo] [numeric](6, 0) NOT NULL,
	[depa_detalle] [char](50) NULL,
	[depa_zona] [char](3) NULL,
 CONSTRAINT [XPKDepartamento] PRIMARY KEY NONCLUSTERED 
(
	[depa_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Departamento]  WITH CHECK ADD  CONSTRAINT [R_16] FOREIGN KEY([depa_zona])
REFERENCES [dbo].[Zona] ([zona_codigo])
GO

ALTER TABLE [dbo].[Departamento] CHECK CONSTRAINT [R_16]
GO

CREATE TABLE [dbo].[Empleado](
	[empl_codigo] [numeric](6, 0) NOT NULL,
	[empl_nombre] [char](50) NULL,
	[empl_apellido] [char](50) NULL,
	[empl_nacimiento] [smalldatetime] NULL,
	[empl_ingreso] [smalldatetime] NULL,
	[empl_tareas] [char](100) NULL,
	[empl_salario] [decimal](12, 2) NULL,
	[empl_comision] [decimal](12, 2) NULL,
	[empl_jefe] [numeric](6, 0) NULL,
	[empl_departamento] [numeric](6, 0) NULL,
 CONSTRAINT [XPKEmpleado] PRIMARY KEY NONCLUSTERED 
(
	[empl_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_empleado_jefe] FOREIGN KEY([empl_jefe])
REFERENCES [dbo].[Empleado] ([empl_codigo])
GO

ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [FK_empleado_jefe]
GO

ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [R_7] FOREIGN KEY([empl_codigo])
REFERENCES [dbo].[Empleado] ([empl_codigo])
GO

ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [R_7]
GO

ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [R_8] FOREIGN KEY([empl_departamento])
REFERENCES [dbo].[Departamento] ([depa_codigo])
GO

ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [R_8]
GO

CREATE TABLE [dbo].[DEPOSITO](
	[depo_codigo] [char](2) NOT NULL,
	[depo_detalle] [char](50) NULL,
	[depo_domicilio] [char](50) NULL,
	[depo_telefono] [char](50) NULL,
	[depo_encargado] [numeric](6, 0) NULL,
	[depo_zona] [char](3) NULL,
 CONSTRAINT [XPKDEPOSITO] PRIMARY KEY NONCLUSTERED 
(
	[depo_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DEPOSITO]  WITH CHECK ADD  CONSTRAINT [R_10] FOREIGN KEY([depo_zona])
REFERENCES [dbo].[Zona] ([zona_codigo])
GO

ALTER TABLE [dbo].[DEPOSITO] CHECK CONSTRAINT [R_10]
GO

ALTER TABLE [dbo].[DEPOSITO]  WITH CHECK ADD  CONSTRAINT [R_9] FOREIGN KEY([depo_encargado])
REFERENCES [dbo].[Empleado] ([empl_codigo])
GO

ALTER TABLE [dbo].[DEPOSITO] CHECK CONSTRAINT [R_9]
GO

CREATE TABLE [dbo].[STOCK](
	[stoc_cantidad] [decimal](12, 2) NULL,
	[stoc_punto_reposicion] [decimal](12, 2) NULL,
	[stoc_stock_maximo] [decimal](12, 2) NULL,
	[stoc_detalle] [char](100) NULL,
	[stoc_proxima_reposicion] [smalldatetime] NULL,
	[stoc_producto] [char](8) NOT NULL,
	[stoc_deposito] [char](2) NOT NULL,
 CONSTRAINT [XPKSTOCK] PRIMARY KEY NONCLUSTERED 
(
	[stoc_producto] ASC,
	[stoc_deposito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[STOCK]  WITH CHECK ADD  CONSTRAINT [R_11] FOREIGN KEY([stoc_producto])
REFERENCES [dbo].[Producto] ([prod_codigo])
GO

ALTER TABLE [dbo].[STOCK] CHECK CONSTRAINT [R_11]
GO

ALTER TABLE [dbo].[STOCK]  WITH CHECK ADD  CONSTRAINT [R_12] FOREIGN KEY([stoc_deposito])
REFERENCES [dbo].[DEPOSITO] ([depo_codigo])
GO

ALTER TABLE [dbo].[STOCK] CHECK CONSTRAINT [R_12]
GO

CREATE TABLE [dbo].[Cliente](
	[clie_codigo] [char](6) NOT NULL,
	[clie_razon_social] [char](100) NULL,
	[clie_telefono] [char](100) NULL,
	[clie_domicilio] [char](100) NULL,
	[clie_limite_credito] [decimal](12, 2) NULL,
	[clie_vendedor] [numeric](6, 0) NULL,
 CONSTRAINT [XPKCliente] PRIMARY KEY NONCLUSTERED 
(
	[clie_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_clie_vendedor] FOREIGN KEY([clie_vendedor])
REFERENCES [dbo].[Empleado] ([empl_codigo])
GO

ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_clie_vendedor]
GO

CREATE TABLE [dbo].[Factura](
	[fact_tipo] [char](1) NOT NULL,
	[fact_sucursal] [char](4) NOT NULL,
	[fact_numero] [char](8) NOT NULL,
	[fact_fecha] [smalldatetime] NULL,
	[fact_vendedor] [numeric](6, 0) NULL,
	[fact_total] [decimal](12, 2) NULL,
	[fact_total_impuestos] [decimal](12, 2) NULL,
	[fact_cliente] [char](6) NULL,
 CONSTRAINT [XPKFactura] PRIMARY KEY NONCLUSTERED 
(
	[fact_tipo] ASC,
	[fact_sucursal] ASC,
	[fact_numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_fact_vendedor] FOREIGN KEY([fact_vendedor])
REFERENCES [dbo].[Empleado] ([empl_codigo])
GO

ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_fact_vendedor]
GO

ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [R_15] FOREIGN KEY([fact_cliente])
REFERENCES [dbo].[Cliente] ([clie_codigo])
GO

ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [R_15]
GO

CREATE TABLE [dbo].[Item_Factura](
	[item_tipo] [char](1) NOT NULL,
	[item_sucursal] [char](4) NOT NULL,
	[item_numero] [char](8) NOT NULL,
	[item_producto] [char](8) NOT NULL,
	[item_cantidad] [decimal](12, 2) NULL,
	[item_precio] [decimal](12, 2) NULL,
 CONSTRAINT [XPKItem_Factura] PRIMARY KEY NONCLUSTERED 
(
	[item_tipo] ASC,
	[item_sucursal] ASC,
	[item_numero] ASC,
	[item_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Item_Factura]  WITH CHECK ADD  CONSTRAINT [R_13] FOREIGN KEY([item_tipo], [item_sucursal], [item_numero])
REFERENCES [dbo].[Factura] ([fact_tipo], [fact_sucursal], [fact_numero])
GO

ALTER TABLE [dbo].[Item_Factura] CHECK CONSTRAINT [R_13]
GO

ALTER TABLE [dbo].[Item_Factura]  WITH CHECK ADD  CONSTRAINT [R_14] FOREIGN KEY([item_producto])
REFERENCES [dbo].[Producto] ([prod_codigo])
GO

ALTER TABLE [dbo].[Item_Factura] CHECK CONSTRAINT [R_14]
GO

/*INSERTS*/

INSERT INTO dbo.Envases VALUES (1, 'BOLSAS'), (2, 'LATAS'), (3, 'CAJAS');

INSERT INTO dbo.Rubro VALUES ('0001', 'ALFAJORES'), ('0002', 'GALLETITAS');

INSERT INTO dbo.Familia VALUES ('001', 'FAMILIA BENSON'), ('002', 'COLORADOS');

INSERT INTO dbo.Producto VALUES ('00000011', 'ADAMS 100 X 2 MENTOL', 24483.75, '001', '0001', 1), 
('00000022', 'ADAMS x20 MENTA', 8.25, '002', '0002', 1);

INSERT INTO dbo.Composicion VALUES (1.00, '00000011', '00000022');

INSERT INTO dbo.Zona VALUES ('001', 'ZONA FEDERACION'), ('002', 'ZONA LIBRES'), ('003', 'ZONA ALTA');

INSERT INTO dbo.Departamento VALUES (1, 'Administracion', '001'), (2, 'Ventas', '002'), (3, 'Compras', '003');

INSERT INTO dbo.Empleado VALUES (1, 'Juan', 'Perez', '1978-01-01 00:00:00', '2000-01-03 00:00:00', 'Gerente', 25000.00, 0.00, NULL, 1),
(2, 'Pedro', 'Gonzalez', '1978-01-05 00:00:00', '2000-01-08 00:00:00', 'Jefe de compras', 15000.00, 0.00, 1, 1);

INSERT INTO dbo.DEPOSITO VALUES ('01', 'BUJAN ROQUE', 'AV. SAN MARTIN && O HIGGINS', NULL, 1, '001'),
('02', 'VARGAS TINO', 'AV. SAN MARTIN', NULL, 2, '002');

INSERT INTO dbo.STOCK VALUES (10.00, 5.00, 50.00, NULL, NULL, '00000011', '01'),
(7.00, 2.00, 35.00, NULL, NULL, '00000022', '02');

INSERT INTO dbo.Cliente VALUES ('000001', 'CONSUMIDOR FINAL', NULL, 'LIBERTADOR && CHACABUCO', 3797.00, 1),
('000002', 'MENDEZ RAQUEL', NULL, 'ALVEAR', 5418.00, 2);

INSERT INTO dbo.Factura VALUES ('A', '0001', '00000111', '2023-01-01 00:00:00', 1, 105.73, 18.33, '000001'),
('A', '0002', '00000222', '2023-02-02 00:00:00', 2, 155.23, 50.67, '000002');

INSERT INTO dbo.Item_Factura VALUES ('A', '0001', '00000111', '00000011', 1.00, 6.70),
('A', '0002', '00000222', '00000022', 1.00, 7.10);
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
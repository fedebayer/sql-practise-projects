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
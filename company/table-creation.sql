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
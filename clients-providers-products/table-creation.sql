/*
A continuación se detalla la información que se desea persistir en el sistema para lo cual deberán crear la tablas correspondientes:

- Información de los tipos de Documentos (Tabla `TiposDocumentos`)
    - id (incrementable)
    - Descripción (20 caracteres alfanuméricos)
- Información de las condiciones de IVA (Tabla `CondicionesIva`)
    - Código (5 caracteres alfanuméricos)
    - Descripción (50 caracteres alfanuméricos)
- Información de los clientes (Tabla Clientes)
    - Tipo de documento (obligatorio)
    - Número de Documento (obligatorio, entero)
    - Apellido (obligatorio, 50 caracteres)
    - Nombres (obligatorio, 50 caracteres)
    - Condición de IVA (obligatorio)
    - Teléfono (opcional, 20 caracteres)
    - celular (opcional, 20 caracteres)
    - Email (opcional, 255 caracteres)
    - Domicilio (calle -100 caracteres-, numero –entero-, código postal -10 caracteres-), opcionales
    - Estado (obligatorio, entero) (puede estar activo o deshabilitado)
- Información de los proveedores (Tabla Proveedores)
    - id (incrementable)
    - Nombre de fantasía (opcional, 100 caracteres)
    - Razón Social (obligatorio, 100 caracteres)
    - Numero de CUIT (obligatorio, numérico)
    - Domicilio (Ídem Clientes)
    - Teléfono (opcional, 20 caracteres)
    - Email (opcional, 255 caracteres)
    - Condición de IVA (obligatorio)
    - Nombre Contacto (obligatorio, 50 caracteres)
    - Estado (obligatorio, entero) (puede estar activo o deshabilitado)
- Información de los Productos que ofrece la empresa (Tabla Productos)
    Cada producto está compuesto por un código de 5 caracteres alfanuméricos, una descripción (50 caracteres) y un precio de compra 
    (decimal, máximo dos dígitos decimales) y un precio sugerido de venta (siendo este opcional, decimal, máximo dos dígitos decimales).
    Los productos dispondrán de un Estado (obligatorio, entero) ya que pueden estar disponibles o no para vender.    
- Información de los Depósitos donde existirá stock de Productos (Tabla Depósitos)
    Cada deposito está compuesto por un identificador incrementable, un nombre (100 caracteres), un Domicilio (calle -100 caracteres-, 
    numero –entero-, código postal -10 caracteres-), opcionales, un teléfono (opcional, 10 caracteres) y un mail (opcional, 255 caracteres).
*/

USE [FB_Practica_SQL_1_1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TipoDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TipoDocumento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CondicionIva](
	[Codigo] [varchar](5) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_CondicionIva1] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Domicilio](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Calle] [varchar](100) NULL,
	[Numero] [int] NULL,
	[CodigoPostal] [varchar](10) NULL,
 CONSTRAINT [PK_Domicilio] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_CondicionIva] FOREIGN KEY([CondicionIva])
REFERENCES [dbo].[CondicionIva] ([Codigo])
GO

ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_CondicionIva]
GO

ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Domicilio] FOREIGN KEY([IdDomicilio])
REFERENCES [dbo].[Domicilio] ([Id])
GO

ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_Domicilio]
GO

ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_TipoDocumento] FOREIGN KEY([TipoDocumento])
REFERENCES [dbo].[TipoDocumento] ([Id])
GO

ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_TipoDocumento]
GO

CREATE TABLE [dbo].[Proveedor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[NombreDeFantasia] [varchar](100) NULL,
	[RazonSocial] [varchar](100) NOT NULL,
	[CUIT] [numeric](18, 0) NOT NULL,
	[IdDomicilio] [int] NULL,
	[Telefono] [varchar](20) NULL,
	[Email] [varchar](255) NULL,
	[CondicionIva] [varchar](5) NOT NULL,
	[NombreContacto] [varchar](50) NOT NULL,
	[Estado] [int] NOT NULL,
	[DatosContacto] [varchar](200) NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_CondicionIva] FOREIGN KEY([CondicionIva])
REFERENCES [dbo].[CondicionIva] ([Codigo])
GO

ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_CondicionIva]
GO

ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_Domicilio] FOREIGN KEY([IdDomicilio])
REFERENCES [dbo].[Domicilio] ([Id])
GO

ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_Domicilio]
GO


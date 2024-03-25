2. Crear los scripts para realizar la carga inicial de las condiciones de IVA (MONOTRIBUTO, RESP. INSC., RESP NO INSC., NO RESPONSABLE, 
	CONSUMIDOR FINAL, EXENTO)
3. Crear scripts para realizar la carga inicial de al menos 20 productos
4. Crear los scripts para realizar la carga inicial de al menos 10 Clientes
5. Crear los scripts para realizar la carga inicial de al menos 15 Proveedores
6. Agregar la columna datos de contacto (dato opcional, 200 caracteres) a la taba de proveedores
7. Actualizar la columna datos de contacto de los proveedores que tengan cargado el campo email 
	(donde email sea distinto de NULL) con el valor de este campo (email).
	
/*PUNTO 2*/
INSERT INTO CondicionIva (Codigo, Descripcion) VALUES ('001AA', 'Monotributo'), 
('002BB', 'Resp Inc'), ('003CC', 'Resp No Inc'), ('004DD', 'No Responsable'), 
('005EE', 'Consumidor Final'), ('006FF', 'Exento');

SELECT * FROM CondicionIva;

/*PUNTO 3*/
INSERT INTO Producto (Codigo, Descripcion, PrecioCompra, PrecioVenta, Estado) VALUES ('AAA11', 'Nvidia GT700', 75999.00, 80000.00, 1),
('BBB22', 'AMD Radeon RX 7000', 100000.00, 110000.00, 1), ('CCC33', 'Intel Core i9-13900K', 50000.00, 55000.00, 1),
('DDD44', 'Samsung Galaxy S23 Ultra', 20000.00, 22000.00, 1), ('EEE55', 'Apple iPhone 15', 15000.00, 16000.00, 1),
('FFF66', 'Sony PlayStation 6', 10000.00, 11000.00, 1), ('GGG77', 'Xbox Series X/S', 5000.00, 55000.00, 1),
('HHH88', 'Laptop ASUS ROG G15', 30000.00, 33000.00, 1), ('III99', 'Monitor Samsung Odyssey', 20000.00, 22000.00, 1),
('JJJAA', 'Impresora HP LaserJet Pro M404dw', 10000.00, 11000.00, 1), ('KKKBB', 'Escritorio IKEA Malm', 5000.00, 55000.00, 1),
('LLLCC', 'Sofá IKEA Kivik', 30000.00, 33000.00, 1), ('MMMDD', 'Televisión Samsung 65" 4K UHD', 20000.00, 22000.00, 1), 
('NNNEE', 'Nevera LG InstaView Door-in-Door', 10000.00, 11000.00, 1), ('OOOFF', 'Lavadora Samsung WW90T854DBX', 5000.00, 55000.00, 1),
('PPPGG', 'Secadora Samsung DV90T854DBX', 30000.00, 33000.00, 1), ('QQQQH', 'Microondas Whirlpool MWF425SL', 20000.00, 22000.00, 1),
('RRRII', 'Horno eléctrico Whirlpool W7OM450S', 10000.00, 11000.00, 1), ('OOFFF', 'Lavadora', 123000.00, 140000.00, 1),
('SSSJJ', 'Mini linterna LED', 200.00, 240.00, 1);

SELECT * FROM Producto;

/*PUNTO 4*/
INSERT INTO Domicilio (Calle, Numero, CodigoPostal) VALUES ('9 de Julio', 250, 'B7000'), ('9 de Julio', 570, 'B700'),
('Avenida Corrientes', 100, 'C1000'), ('Avenida Santa Fe', 200, 'C1425'), ('Avenida Córdoba', 300, 'C1050'),
('Calle Florida', 400, 'C1000'), ('Calle Reconquista', 500, 'C1000'), ('Calle Lavalle', 600, 'C1000'), ('Calle Maipú', 700, 'C1000'),
('Calle Sarmiento', 800, 'C1000'), ('Calle Callao', 900, 'C1000'), ('Calle Corrientes', 1000, 'C1000'), ('Avenida Santa Fe', 2000, 'C1425'),
('Avenida Córdoba', 3000, 'C1050'), ('Calle Florida', 4000, 'C1000'), ('Calle Reconquista', 5000, 'C1000'), ('Calle Lavalle', 6000, 'C1000'),
('Calle Maipú', 7000, 'C1000'), ('Calle Sarmiento', 8000, 'C1000'), ('Calle Callao', 9000, 'C1000'), ('Calle 57', 123, 'C1000'), 
('Calle 9 de Julio', 1000, 'C1000'), ('Calle Corrientes', 2000, 'C1000'), ('Calle Maipú', 3000, 'C1000'), ('Calle Santa Fe', 4000, 'C1000'),
('Calle de la Reconquista', 1111, 'C1000');

SELECT * FROM Domicilio;

/*PUNTO 5*/
INSERT INTO Proveedor (NombreDeFantasia, RazonSocial, CUIT, IdDomicilio, Telefono, Email, CondicionIva, NombreContacto, Estado) VALUES
('Dynamic Solutions', 'DYNAMIC SOLUTIONS S.R.L', 29526037666, 1, '45912993', 'consultas@dynamicsolutions.com', '002BB', 'Gabriel Collado', 1),
('Compumundo', 'COMPUMUNDO S.A.', 30711234567, 2, '45912994', 'atencionclientes@computmundo.com.ar', '001AA', 'Juan Pérez', 1),
('Mercado Libre', 'MERCADO LIBRE S.A.', 30711234568, 3, '45912995', 'soporte@mercadolibre.com.ar', '003CC', 'Ana López', 1),
('Amazon', 'AMAZON.COM INC.', 30711234569, 4, '45912996', 'soporte@amazon.com', '004DD', 'Pedro García', 1),
('Aliexpress', 'ALIEXPRESS.COM', 30711234570, 5, '45912997', 'soporte@aliexpress.com', '005EE', 'María Fernández', 1),
('Ebay', 'EBAY INC.', 30711234571, 6, '45912998', 'soporte@ebay.com', '006FF', 'Carlos Rodríguez', 1),
('Carrefour', 'CARREFOUR ARGENTINA S.A.', 30711234572, 7, '45912999', 'atencionclientes@carrefour.com.ar', '001AA', 'Daniela Gómez', 1),
('Walmart', 'WALMART ARGENTINA S.A.', 30711234573, 8, '45913000', 'atencionclientes@walmart.com.ar', '002BB', 'Sebastián Hernández', 1),
('Dia', 'DIA S.A.', 30711234574, 9, '45913001', 'atencionclientes@dia.com.ar', '003CC', 'Laura Martínez', 1),
('Cencosud', 'Cencosud S.A.', 30711234575, 10, '45913002', 'atencionclientes@cencosud.com.ar', '004DD', 'Federico López', 1),
('Jumbo', 'JUMBO S.A.', 30711234576, 11, '45913003', 'atencionclientes@jumbo.com.ar', '005EE', 'Carla Pérez', 1),
('Disco', 'Disco S.A.', 30711234577, 12, '45913004', 'atencionclientes@disco.com.ar', '006FF', 'Martín García', 1),
('Coto', 'Coto S.A.', 30711234578, 13, '45913005', 'atencionclientes@coto.com.ar', '001AA', 'Mariano Rodríguez', 1),
('Kiosco La esquina', 'Kiosco La esquina S.R.L.', 30711234579, 14, '45913006', 'atencionclientes@kioscolaesquina.com.ar', '002BB', 'Lucía Gómez', 1),
('Fábrica de empanadas Don Juan', 'Fábrica de empanadas Don Juan S.A.', 30711234580, 15, '45913007','atencionclientes@empanadasdonjuan.com.ar', '003CC', 'Pedro Martínez', 1);

SELECT * FROM Proveedor;

/*PUNTO 6*/
ALTER TABLE Proveedor
ADD DatosContacto VARCHAR(200);

SELECT * FROM Proveedor;

/*PUNTO 7*/
UPDATE Proveedor
SET DatosContacto = Email
WHERE Email IS NOT NULL;

SELECT * FROM Proveedor;
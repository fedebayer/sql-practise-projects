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
-- Seleccionar Todos los Clientes
SELECT * FROM Cliente;

-- Seleccionar Todos los Abogados
SELECT * FROM Abogado;

-- Agregar un Nuevo Cliente
INSERT INTO Persona (Nombre, Numero_telefonico)
VALUES ('Ana María Pérez', '+591 78888888');

INSERT INTO Cliente (Direccion, PersonaID)
VALUES ('Calle Falsa 123', LAST_INSERT_ID());

-- Actualizar la Dirección de un Cliente
UPDATE Cliente
SET Direccion = 'Nueva Calle 456'
WHERE ClienteID = 1;

-- Eliminar un Abogado
DELETE FROM Abogado
WHERE AbogadoID = 2;

-- Seleccionar Todos los Casos Asociados a un Cliente
SELECT Caso.*
FROM Caso
JOIN Cliente ON Caso.ClienteID = Cliente.ClienteID
WHERE Cliente.ClienteID = 1;

-- Contar el Número de Casos por Abogado
SELECT Abogado.PersonaID, COUNT(Caso.CasoID) AS NumeroCasos
FROM Abogado
LEFT JOIN Abogado_Caso ON Abogado.AbogadoID = Abogado_Caso.AbogadoID
LEFT JOIN Caso ON Abogado_Caso.CasoID = Caso.CasoID
GROUP BY Abogado.PersonaID;

-- Buscar Actividades Pendientes para un Abogado Específico
SELECT Actividad.*
FROM Actividad
WHERE AbogadoID = 1 AND Estado <> 'Completada';

-- Unir Datos de Clientes y sus Contactos de Emergencia
SELECT Cliente.Nombre, Contacto_emergencia.Nombre AS NombreContacto
FROM Cliente
JOIN Contacto_emergencia ON Cliente.ClienteID = Contacto_emergencia.ClienteID;

-- Total de Pagos por Caso
SELECT Caso.Titulo, SUM(Pago.Monto_pago) AS TotalPagado
FROM Pago
JOIN Caso ON Pago.CasoID = Caso.CasoID
GROUP BY Caso.Titulo;

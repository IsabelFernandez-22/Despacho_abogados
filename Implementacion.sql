CREATE DATABASE IF NOT EXISTS DESPACHO_ABOGADOS;

CREATE TABLE IF NOT EXISTS Persona (
PersonaID int PRIMARY KEY AUTO_INCREMENT,
Nombre varchar(100),
Numero_telefonico varchar(15)
);

CREATE TABLE IF NOT EXISTS Cliente (
ClienteID int PRIMARY KEY AUTO_INCREMENT,
Direccion varchar(100) NOT NULL,
PersonaID int,
FOREIGN KEY (PersonaID) REFERENCES Persona(PersonaID)
);
select * from actividad;
CREATE TABLE IF NOT EXISTS Abogado (
AbogadoID int PRIMARY KEY AUTO_INCREMENT,
Especializacion varchar(50),
PersonaID int NOT NULL,
FOREIGN KEY (PersonaID) REFERENCES Persona(PersonaID)
);

CREATE TABLE IF NOT EXISTS Actividad (
ActividadID int PRIMARY KEY AUTO_INCREMENT,
Descripcion text,
Fecha_asignacion datetime,
Fecha_vencimiento datetime,
Estado varchar(15),
AbogadoID int,
FOREIGN KEY (AbogadoID) REFERENCES Abogado(AbogadoID)
);

CREATE TABLE IF NOT EXISTS Contacto_emergencia (
ContactoID int PRIMARY KEY AUTO_INCREMENT,
Nombre varchar(100),
Relacion varchar(15),
Numero_telefono varchar(15),
ClienteID int,
FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE IF NOT EXISTS Cita (
CitaID int PRIMARY KEY AUTO_INCREMENT,
Fecha_Hora datetime,
Lugar text,
Estado varchar(15),
AbogadoID int,
ClienteID int,
FOREIGN KEY (AbogadoID) REFERENCES Abogado(AbogadoID),
FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE IF NOT EXISTS Caso (
CasoID int PRIMARY KEY AUTO_INCREMENT,
Titulo varchar(50),
Descripcion text,
Fecha_inicio Date,
Estado varchar(15),
FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE IF NOT EXISTS Abogado_Caso (
AbogadoCasoID int PRIMARY KEY AUTO_INCREMENT,
ROL varchar(20),
Fecha_Asignacion Date,
Estado varchar(15),
CasoID int,
AbogadoID int,
FOREIGN KEY (AbogadoID) REFERENCES Abogado(AbogadoID),
FOREIGN KEY (CasoID) REFERENCES Caso(CasoID)
);

CREATE TABLE IF NOT EXISTS Audiencia (
AudienciaID int PRIMARY KEY AUTO_INCREMENT,
Fecha_Hora Datetime,
Lugar varchar(100),
Resultado varchar(15),
CasoID int,
FOREIGN KEY (CasoID) REFERENCES Caso(CasoID)
);

CREATE TABLE IF NOT EXISTS Juzgado (
JuzgadoID int PRIMARY KEY AUTO_INCREMENT,
Nombre varchar(20),
Direccion varchar(100),
Numero_telefonico varchar(15),
AudienciaID int,
FOREIGN KEY (AudienciaID) REFERENCES Audiencia(AudienciaID)
);

CREATE TABLE IF NOT EXISTS Pago (
PagoID int PRIMARY KEY AUTO_INCREMENT,
Fecha_pago date,
Monto_pago decimal,
Metodo_pago varchar(20),
CasoID int,
FOREIGN KEY (CasoID) REFERENCES Caso(CasoID)
);

CREATE TABLE IF NOT EXISTS Comprobante_pago (
ComprobanteID int PRIMARY KEY AUTO_INCREMENT,
Fecha_emision Datetime,
Monto_total decimal,
Estado varchar(15),
PagoID int,
FOREIGN KEY (PagoID) REFERENCES Pago(PagoID)
);

CREATE TABLE IF NOT EXISTS Expediente (
ExpedienteID int PRIMARY KEY AUTO_INCREMENT,
Numero varchar(15),
Fecha_apertura date,
Clasificacion varchar(15),
Subtipo varchar(20),
CasoID int,
FOREIGN KEY (CasoID) REFERENCES Caso(CasoID)
);

CREATE TABLE IF NOT EXISTS Testigos (
TestigosID int PRIMARY KEY AUTO_INCREMENT,
Descripcion text,
Fecha_declaracion datetime,
Direccion varchar(100),
ExpedienteID int,
FOREIGN KEY (ExpedienteID) REFERENCES Expediente(ExpedienteID)
);

CREATE TABLE IF NOT EXISTS Evidencia (
EvidenciaID int PRIMARY KEY AUTO_INCREMENT,
Descripcion text,
Tipo varchar(50),
FechaObtencion date,
ExpedienteID int,
FOREIGN KEY (ExpedienteID) REFERENCES Expediente(ExpedienteID)
);

CREATE TABLE IF NOT EXISTS Servicio (
ServicioID int PRIMARY KEY AUTO_INCREMENT,
Nombre varchar(20),
Descripcion text,
Tarifa decimal
);

CREATE TABLE IF NOT EXISTS Caso_servicio (
Caso_servicioID int PRIMARY KEY AUTO_INCREMENT,
Estado_pago varchar(15),
CasoID int,
ServicioID int,
FOREIGN KEY (CasoID) REFERENCES Caso(CasoID),
FOREIGN KEY (ServicioID) REFERENCES Servicio(ServicioID)
);

CREATE TABLE IF NOT EXISTS Tipo_servicio (
Tipo_servicioID int PRIMARY KEY AUTO_INCREMENT,
Categoria varchar(15),
Descripcion text,
ServicioID int,
FOREIGN KEY (ServicioID) REFERENCES Servicio(ServicioID)
);

CREATE TABLE IF NOT EXISTS Demandas (
DemandasID int PRIMARY KEY AUTO_INCREMENT,
Tipo_demanda varchar(100),
CasoID int,
FOREIGN KEY (CasoID) REFERENCES Caso(CasoID)
);

CREATE TABLE IF NOT EXISTS Demandado (
DemandadoID int PRIMARY KEY AUTO_INCREMENT,
Nombre varchar(100),
Direccion varchar(100),
DemandasID int,
FOREIGN KEY (DemandasID) REFERENCES Demandas(DemandasID)
);

CREATE TABLE IF NOT EXISTS Abogado_defensor (
Abogado_defensorID int PRIMARY KEY AUTO_INCREMENT,
Nombre varchar(100),
Direccion_oficina varchar(100)
);

CREATE TABLE IF NOT EXISTS Demandado_AbogadoDef (
Demandado_AbogadoDefID int PRIMARY KEY AUTO_INCREMENT,
Fecha_asignacion date,
Estado_representacion varchar(15),
Notas text,
DemandadoID int,
Abogado_defensorID int,
FOREIGN KEY (DemandadoID) REFERENCES Demandado(DemandadoID),
FOREIGN KEY (Abogado_defensorID) REFERENCES Abogado_defensor(Abogado_defensorID)
);

INSERT INTO Persona (Nombre, Numero_telefonico)
VALUES ('Jose Ernesto Fernandez Peñaranda', '+591 62131119');

INSERT INTO Abogado (Especializacion, PersonaID)
VALUES ('Derecho Penal', 1);
select * from actividad;

##TRIGGERS
DELIMITER //
CREATE TRIGGER trg_update_actividad_estado
BEFORE UPDATE ON Actividad
FOR EACH ROW

BEGIN
IF NEW.Fecha_vencimiento <= NOW() AND OLD.Estado <> 'Completada' THEN
SET NEW.Estado = 'Completada';
END IF;
END; //
DELIMITER ;

#EJEMPLO
#Si actualizas un registro de actividad y la fecha de vencimiento ha pasado, el trigger cambia
#el estado de la actividad a 'Completada'.
UPDATE Actividad
SET Fecha_vencimiento = '2024-09-04'
WHERE ActividadID = 1;
select * from actividad;
DELIMITER //

#Trigger para evitar la creación de pagos con un monto negativo
CREATE TRIGGER trg_check_pago_monto
BEFORE INSERT ON Pago
FOR EACH ROW

BEGIN
IF NEW.Monto_pago <= 0 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto del pago debe ser positivo.';
END IF;
END; //

DELIMITER ;
INSERT INTO Pago (Fecha_pago, Monto_pago, Metodo_pago, CasoID)
VALUES ('2024-09-15', -100.00, 'Transferencia', 1);
-- Esto generará un error debido al monto negativo.
#Trigger para garantizar que los casos no se dupliquen en la tabla Caso
DELIMITER //

CREATE TRIGGER trg_prevent_duplicate_caso
BEFORE INSERT ON Caso
FOR EACH ROW
BEGIN
IF EXISTS (SELECT 1 FROM Caso WHERE Titulo = NEW.Titulo AND Fecha_inicio =
NEW.Fecha_inicio) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe un caso con el mismo título y
fecha de inicio.';
END IF;
END; //

DELIMITER ;

INSERT INTO Caso (Titulo, Descripcion, Fecha_inicio, Estado)
VALUES ('Asistencia familiar', 'Demanda de asistencia familiar al señor Jose Ernesto Fernandez
por pago de persiones de sus dos hijos.', '2024-09-15', 'Abierto');
-- Esto generará un error si ya existe un caso con el mismo título y fecha de inicio.

select * from caso;
#FUNCIONES

#Función para calcular el monto total de los pagos realizados para un caso
DELIMITER //

CREATE FUNCTION calcular_monto_total_pagos(casoID INT)
RETURNS DECIMAL(10,2)
BEGIN
DECLARE monto_total DECIMAL(10,2);

SELECT COALESCE(SUM(Monto_pago), 0) INTO monto_total
FROM Pago
WHERE CasoID = casoID;

RETURN monto_total;
END; //
DELIMITER ;

INSERT INTO Pago (Fecha_pago, Monto_pago, Metodo_pago, CasoID)
VALUES ('2024-07-22', 200, 'Efectivo', 1);

SELECT calcular_monto_total_pagos(1) AS MontoTotal;

#PROCEDIMIENTOS
#Procedimiento para asignar un abogado a un caso
DELIMITER //
CREATE PROCEDURE asignar_abogado_a_caso(
IN p_casoID INT,
IN p_abogadoID INT,
IN p_rol VARCHAR(20)
)
BEGIN
INSERT INTO Abogado_Caso (ROL, Fecha_Asignacion, Estado, CasoID, AbogadoID)
VALUES (p_rol, CURDATE(), 'Activo', p_casoID, p_abogadoID);
END; //
DELIMITER ;
CALL asignar_abogado_a_caso(1, 1, 'Abogado Principal');

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

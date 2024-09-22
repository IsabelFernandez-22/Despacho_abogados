<?php
// dal/actividadDAO.php
include '../dal/db.php'; // Asegúrate de que la ruta es correcta


class ActividadDAO {
    private $conn;

    public function __construct() {
        $this->conn = $this->getConnection();
    }

    private function getConnection() {
        // Conexión a la base de datos
        $host = 'localhost';
        $db = 'DESPACHO_ABOGADOS';
        $user = 'root';
        $pass = '';

        try {
            $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn;
        } catch (PDOException $e) {
            echo "Error de conexión: " . $e->getMessage();
            exit();
        }
    }
    public function obtenerActividades() {
        $query = "SELECT * FROM Actividad";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function crearActividad($descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID) {
        $query = "INSERT INTO Actividad (Descripcion, Fecha_asignacion, Fecha_vencimiento, Estado, AbogadoID) VALUES (:descripcion, :fechaAsignacion, :fechaVencimiento, :estado, :abogadoID)";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':descripcion', $descripcion);
        $stmt->bindParam(':fechaAsignacion', $fechaAsignacion);
        $stmt->bindParam(':fechaVencimiento', $fechaVencimiento);
        $stmt->bindParam(':estado', $estado);
        $stmt->bindParam(':abogadoID', $abogadoID);
        $stmt->execute();
    }

    public function obtenerActividad($actividadID) {
        $query = "SELECT * FROM Actividad WHERE ActividadID = :actividadID";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':actividadID', $actividadID);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function actualizarActividad($actividadID, $descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID) {
        $query = "UPDATE Actividad SET Descripcion = :descripcion, Fecha_asignacion = :fechaAsignacion, Fecha_vencimiento = :fechaVencimiento, Estado = :estado, AbogadoID = :abogadoID WHERE ActividadID = :actividadID";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(':actividadID', $actividadID);
        $stmt->bindParam(':descripcion', $descripcion);
        $stmt->bindParam(':fechaAsignacion', $fechaAsignacion);
        $stmt->bindParam(':fechaVencimiento', $fechaVencimiento);
        $stmt->bindParam(':estado', $estado);
        $stmt->bindParam(':abogadoID', $abogadoID);
        $stmt->execute();
    }
}
?>

<?php
// bll/actividadService.php
include '../dal/actividadDAO.php';

class ActividadService {
    private $actividadDAO;

    public function __construct($actividadDAO) {
        $this->actividadDAO = $actividadDAO;
    }

    public function obtenerActividades() {
        return $this->actividadDAO->obtenerActividades();
    }

    public function crearActividad($descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID) {
        $this->actividadDAO->crearActividad($descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID);
    }

    public function obtenerActividad($actividadID) {
        return $this->actividadDAO->obtenerActividad($actividadID);
    }

    public function actualizarActividad($actividadID, $descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID) {
        $this->actividadDAO->actualizarActividad($actividadID, $descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID);
    }
}
?>

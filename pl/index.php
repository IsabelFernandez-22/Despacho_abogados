<?php
// pl/index.php
// Es la capa de presentación, muestra la interfaz del usuario y su interacción.
include_once '../bll/actividadService.php';
include_once '../dal/actividadDAO.php'; // Incluye el archivo que contiene la clase ActividadDAO

// Crear una instancia de ActividadDAO
$actividadDAO = new ActividadDAO();

// Crear una instancia de ActividadService pasando el objeto ActividadDAO
$actividadService = new ActividadService($actividadDAO);

// Manejo de formularios
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['crear'])) {
        $descripcion = $_POST['descripcion'];
        $fechaAsignacion = $_POST['fecha_asignacion'];
        $fechaVencimiento = $_POST['fecha_vencimiento'];
        $estado = $_POST['estado'];
        $abogadoID = $_POST['abogadoID'];
        $actividadService->crearActividad($descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID);
    } elseif (isset($_POST['actualizar'])) {
        $actividadID = $_POST['actividadID'];
        $descripcion = $_POST['descripcion'];
        $fechaAsignacion = $_POST['fecha_asignacion'];
        $fechaVencimiento = $_POST['fecha_vencimiento'];
        $estado = $_POST['estado'];
        $abogadoID = $_POST['abogadoID'];
        $actividadService->actualizarActividad($actividadID, $descripcion, $fechaAsignacion, $fechaVencimiento, $estado, $abogadoID);
    }
}

// Obtener todas las actividades para mostrar en la lista
$actividades = $actividadService->obtenerActividades();

// Verificar si se ha solicitado editar una actividad
if (isset($_GET['editar'])) {
    $actividadID = $_GET['editar'];
    $actividad = $actividadService->obtenerActividad($actividadID);
} else {
    $actividad = null;
}
?>
<!DOCTYPE html> 
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Actividades</title>
    <style>
        body {
            background-color: #f4f4f9;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 40px;
        }
        h1, h2 {
            color: #2c3e50;
            margin-bottom: 20px;
            text-align: center;
            text-transform: uppercase;
        }
        form {
            margin-bottom: 40px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fafafa;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
            font-weight: bold;
        }
        input, select {
            padding: 10px;
            margin: 6px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 100%;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        input:focus, select:focus {
            border-color: #2980b9;
            outline: none;
        }
        input[type="submit"] {
            background-color: #2980b9;
            border: none;
            color: white;
            padding: 12px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #1a5276;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th {
            background-color: #2c3e50;
            color: white;
            padding: 12px;
        }
        td {
            padding: 10px;
            text-align: center;
            background-color: #f9f9f9;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e0e0e0;
        }
        a {
            color: #2980b9;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        /* Estilos del menú */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #2c3e50;
            padding: 10px;
            color: white;
        }
        .menu {
            position: relative;
            display: inline-block;
        }
        .menu button {
            background-color: #2980b9;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .menu button:hover {
            background-color: #1a5276;
        }
        .menu-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
            border-radius: 5px;
            margin-top: 5px;
        }
        .menu-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .menu:hover .menu-content {
            display: block;
        }
    </style>
</head>
<body>
    <!-- Menú superior -->
    <div class="navbar">
        <h1>Despacho Jurídico Fertar</h1>
        <div class="menu">
            <button>Menú</button>
            <div class="menu-content">
                <a href="#abogados">Abogados</a>
                <a href="#clientes">Clientes</a>
                <a href="#casos">Casos</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h1>Gestión de Actividades</h1>

        <!-- Formulario para crear actividad -->
        <form method="post">
            <h2>Crear Actividad</h2>
            <label for="descripcion">Descripción:</label>
            <input type="text" id="descripcion" name="descripcion" required>
            <label for="fecha_asignacion">Fecha Asignación:</label>
            <input type="datetime-local" id="fecha_asignacion" name="fecha_asignacion" required>
            <label for="fecha_vencimiento">Fecha Vencimiento:</label>
            <input type="datetime-local" id="fecha_vencimiento" name="fecha_vencimiento" required>
            <label for="estado">Estado:</label>
            <select id="estado" name="estado" required>
                <option value="Sin comenzar">Sin comenzar</option>
                <option value="En proceso">En proceso</option>
                <option value="Terminado">Terminado</option>
            </select>
            <label for="abogadoID">Abogado ID:</label>
            <input type="number" id="abogadoID" name="abogadoID" required>
            <input type="submit" name="crear" value="Crear Actividad">
        </form>

        <!-- Formulario para actualizar actividad -->
        <form method="post">
            <h2>Actualizar Actividad</h2>
            <?php if ($actividad): ?>
                <input type="hidden" name="actividadID" value="<?php echo htmlspecialchars($actividad['ActividadID']); ?>">
                <label for="descripcion">Descripción:</label>
                <input type="text" id="descripcion" name="descripcion" value="<?php echo htmlspecialchars($actividad['Descripcion']); ?>">
                <label for="fecha_asignacion">Fecha Asignación:</label>
                <input type="datetime-local" id="fecha_asignacion" name="fecha_asignacion" value="<?php echo htmlspecialchars(date('Y-m-d\TH:i', strtotime($actividad['Fecha_asignacion']))); ?>">
                <label for="fecha_vencimiento">Fecha Vencimiento:</label>
                <input type="datetime-local" id="fecha_vencimiento" name="fecha_vencimiento" value="<?php echo htmlspecialchars(date('Y-m-d\TH:i', strtotime($actividad['Fecha_vencimiento']))); ?>">
                <label for="estado">Estado:</label>
                <select id="estado" name="estado">
                    <option value="Sin comenzar" <?php echo ($actividad['Estado'] == 'Sin comenzar') ? 'selected' : ''; ?>>Sin comenzar</option>
                    <option value="En proceso" <?php echo ($actividad['Estado'] == 'En proceso') ? 'selected' : ''; ?>>En proceso</option>
                    <option value="Terminado" <?php echo ($actividad['Estado'] == 'Terminado') ? 'selected' : ''; ?>>Terminado</option>
                </select>
                <label for="abogadoID">Abogado ID:</label>
                <input type="number" id="abogadoID" name="abogadoID" value="<?php echo htmlspecialchars($actividad['AbogadoID']); ?>">
                <input type="submit" name="actualizar" value="Actualizar Actividad">
            <?php else: ?>
                <p>Selecciona una actividad para editar.</p>
            <?php endif; ?>
        </form>

        <!-- Mostrar actividades existentes -->
        <h2>Actividades Existentes</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Fecha de Asignación</th>
                    <th>Fecha de Vencimiento</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($actividades as $actividad): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($actividad['ActividadID']); ?></td>
                        <td><?php echo htmlspecialchars($actividad['Descripcion']); ?></td>
                        <td><?php echo htmlspecialchars($actividad['Estado']); ?></td>
                        <td><?php echo htmlspecialchars($actividad['Fecha_asignacion']); ?></td>
                        <td><?php echo htmlspecialchars($actividad['Fecha_vencimiento']); ?></td>
                        <td>
                            <a href="index.php?editar=<?php echo htmlspecialchars($actividad['ActividadID']); ?>">Editar</a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</body>
</html>

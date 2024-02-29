<?php
include 'conexion.php';

// Consulta SQL para recuperar datos de ubicación relacionados con negocios
$sql = "SELECT n.nombre AS nombre_negocio, u.latitud, u.longitud
FROM negocios n
INNER JOIN ubicacion u  ON n.idnegocios = u.negocio";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Crear un array para almacenar los datos
    $ubicaciones_negocios = array();

    // Recorrer los resultados y agregarlos al array
    while ($row = $result->fetch_assoc()) {
        $ubicaciones_negocios[] = $row;
    }

    // Devolver los datos como JSON
    echo json_encode($ubicaciones_negocios);
} else {
    echo json_encode(array('error' => 'No se encontraron ubicaciones relacionadas con negocios.'));
}

// Cerrar la conexión
$conn->close();
?>

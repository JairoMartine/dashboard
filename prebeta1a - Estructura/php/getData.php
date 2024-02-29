<?php
include 'conexion.php';

// Consulta SQL para obtener datos de la tabla 'ingresos'
$sql = "SELECT fecha, monto FROM ingresos";
$result = $conn->query($sql);

// Crear un array para almacenar los datos
$data = array();

// Verificar si se obtuvieron resultados
if ($result->num_rows > 0) {
    // Recorrer los resultados y agregarlos al array
    while ($row = $result->fetch_assoc()) {
        $data[] = array(
            "date" => $row["fecha"],
            "amount" => $row["monto"]
        );
    }
}

// Cerrar la conexión a la base de datos
$conn->close();

// Convertir el array a formato JSON
$jsonData = json_encode($data);

// Enviar la respuesta como JSON
header('Content-Type: application/json');
echo $jsonData;
?>

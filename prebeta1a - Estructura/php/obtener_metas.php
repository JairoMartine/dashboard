<?php
include 'conexion.php';

// Consulta para obtener datos de las metas (fecha, finalizado, no finalizado)
$sql = "SELECT fecha, SUM(finalizado) as metas_completadas, COUNT(*) - SUM(finalizado) as metas_no_completadas FROM Metas GROUP BY fecha";
$result = $conn->query($sql);

// Inicializar variables
$metasHechas = 0;
$metasSinCompletar = 0;

// Obtener resultados
$datosPorFecha = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $fecha = $row['fecha'];
        $metasHechas += $row['metas_completadas'];
        $metasSinCompletar += $row['metas_no_completadas'];

        // Almacenar datos por fecha
        $datosPorFecha[] = array(
            'fecha' => $fecha,
            'metas_completadas' => $row['metas_completadas'],
            'metas_no_completadas' => $row['metas_no_completadas']
        );
    }
}

// Calcular el porcentaje de metas completadas
$porcentajeCompletadas = ($metasHechas / ($metasHechas + $metasSinCompletar)) * 100;
$porcentajeCompletadas = number_format($porcentajeCompletadas, 2);  // Limitar a dos decimales

// Cerrar la conexión a la base de datos
$conn->close();

// Devolver el resultado como un objeto JSON
echo json_encode(array('porcentajeCompletadas' => $porcentajeCompletadas, 'datosPorFecha' => $datosPorFecha));
?>

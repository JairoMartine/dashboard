<?php
include 'conexion.php';

// Consulta para obtener el conteo de clientes por mes
$sqlClientes = "
SELECT
  COUNT(CASE WHEN MONTH(fecha_baja) = 01 THEN idcliente END) AS clientes_enero,
  COUNT(CASE WHEN MONTH(fecha_baja) = 02 THEN idcliente END) AS clientes_febrero,
  COUNT(CASE WHEN MONTH(fecha_baja) = 03 THEN idcliente END) AS clientes_marzo,
  COUNT(CASE WHEN MONTH(fecha_baja) = 04 THEN idcliente END) AS clientes_abril,
  COUNT(CASE WHEN MONTH(fecha_baja) = 05 THEN idcliente END) AS clientes_mayo
FROM cliente;
";

$resultClientes = $conn->query($sqlClientes);

if (!$resultClientes) {
    die('Error en la consulta de clientes: ' . $conn->error);
}

$datosClientes = $resultClientes->fetch_assoc();

// Consulta para obtener datos de ingresos con fechas y montos
$sqlIngresos = "SELECT fecha, monto FROM ingresos";
$resultadoIngresos = $conn->query($sqlIngresos);

// Consulta para obtener datos de puntos de equilibrio con fechas y montos
$sqlPuntoEquilibrio = "SELECT fecha, monto FROM puntos_equlibrio";
$resultadoPuntoEquilibrio = $conn->query($sqlPuntoEquilibrio);

// Nueva consulta para obtener datos de ventas por servicio con nombres de servicio e ingresos
$sqlVentasPorServicio = "SELECT Nombre_Servicio, Ingreso FROM ventas_por_servicio";
$resultadoVentasPorServicio = $conn->query($sqlVentasPorServicio);

// Verificar errores en las consultas de ingresos, punto de equilibrio, y ventas por servicio
if (!$resultadoIngresos || !$resultadoPuntoEquilibrio || !$resultadoVentasPorServicio) {
    die('Error en la consulta de ingresos, punto de equilibrio o ventas por servicio: ' . $conn->error);
}

// Obtener resultados de las consultas de ingresos, punto de equilibrio y ventas por servicio
$datosIngresos = $resultadoIngresos->fetch_all(MYSQLI_ASSOC);
$datosPuntoEquilibrio = $resultadoPuntoEquilibrio->fetch_all(MYSQLI_ASSOC);
$datosVentasPorServicio = $resultadoVentasPorServicio->fetch_all(MYSQLI_ASSOC);

// Cerrar la conexión a la base de datos
$conn->close();

echo json_encode(['clientes' => $datosClientes, 'ingresos' => $datosIngresos, 'puntoEquilibrio' => $datosPuntoEquilibrio, 'ventasPorServicio' => $datosVentasPorServicio]);
?>

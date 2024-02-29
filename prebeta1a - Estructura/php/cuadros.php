<?php
include 'conexion.php';

// Obtener fechas de filtro si están presentes en la URL
$fechaInicio = isset($_GET['fechaInicio']) ? $_GET['fechaInicio'] : null;
$fechaFin = isset($_GET['fechaFin']) ? $_GET['fechaFin'] : null;

// Consulta para obtener ingresos con fechas
$sqlIngresos = "SELECT fecha, monto AS total FROM ingresos";
if ($fechaInicio && $fechaFin) {
    $sqlIngresos .= " WHERE fecha BETWEEN '$fechaInicio' AND '$fechaFin'";
}
$resultadoIngresos = $conn->query($sqlIngresos);

// Consulta para obtener total de negocios con fechas
$sqlNegocios = "SELECT fecha_registro as fecha, idnegocios AS total FROM negocios";
if ($fechaInicio && $fechaFin) {
    $sqlNegocios .= " WHERE fecha_registro BETWEEN '$fechaInicio' AND '$fechaFin'";
}
$resultadoNegocios = $conn->query($sqlNegocios);

// Consulta para obtener total de socios con fechas
$sqlSocios = "SELECT fecha_registro as fecha, idsocio AS total FROM socio";
if ($fechaInicio && $fechaFin) {
    $sqlSocios .= " WHERE fecha_registro BETWEEN '$fechaInicio' AND '$fechaFin'";
}
$resultadoSocios = $conn->query($sqlSocios);

// Consulta para obtener total de clientes con fechas
$sqlClientes = "SELECT fecha_registro as fecha, idcliente AS total FROM cliente";
if ($fechaInicio && $fechaFin) {
    $sqlClientes .= " WHERE fecha_registro BETWEEN '$fechaInicio' AND '$fechaFin'";
}
$resultadoClientes = $conn->query($sqlClientes);

// Consulta para obtener utilidades con fechas
$sqlUtilidades = "SELECT fecha, monto AS total FROM utilidades";
if ($fechaInicio && $fechaFin) {
    $sqlUtilidades .= " WHERE fecha BETWEEN '$fechaInicio' AND '$fechaFin'";
}
$resultadoUtilidades = $conn->query($sqlUtilidades);

// Consulta para obtener puntos de equilibrio con fechas
$sqlPuntoEquilibrio = "SELECT fecha, monto AS total FROM puntos_equlibrio";
if ($fechaInicio && $fechaFin) {
    $sqlPuntoEquilibrio .= " WHERE fecha BETWEEN '$fechaInicio' AND '$fechaFin'";
}
$resultadoPuntoEquilibrio = $conn->query($sqlPuntoEquilibrio);

// Verificar errores en las consultas
if (!$resultadoIngresos || !$resultadoNegocios || !$resultadoSocios || !$resultadoClientes || !$resultadoUtilidades || !$resultadoPuntoEquilibrio) {
    die('Error en la consulta: ' . $conn->error);
}

// Obtener resultados de las consultas
$datosIngresos = $resultadoIngresos->fetch_all(MYSQLI_ASSOC);
$datosNegocios = $resultadoNegocios->fetch_all(MYSQLI_ASSOC);
$datosSocios = $resultadoSocios->fetch_all(MYSQLI_ASSOC);
$datosClientes = $resultadoClientes->fetch_all(MYSQLI_ASSOC);
$datosUtilidades = $resultadoUtilidades->fetch_all(MYSQLI_ASSOC);
$datosPuntoEquilibrio = $resultadoPuntoEquilibrio->fetch_all(MYSQLI_ASSOC);

// Cerrar la conexión a la base de datos
$conn->close();

// Devolver el resultado como un objeto JSON
echo json_encode([
    'ingresos' => $datosIngresos,
    'negocios' => $datosNegocios,
    'socios' => $datosSocios,
    'clientes' => $datosClientes,
    'utilidades' => $datosUtilidades,
    'punto_equilibrio' => $datosPuntoEquilibrio,
]);
?>















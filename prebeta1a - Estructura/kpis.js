var clientesChart;
var ingresosPuntoEquilibrioChart;
var ventasPorServicioChart;
var originalData2; // Almacena los datos originales
var currentCurrency2 = 'peso'; // Moneda predeterminada

// Función para cargar y mostrar la gráfica de Ingresos, Punto de Equilibrio y Utilidades
function cargarGraficoIngresosPuntoEquilibrio() {
    // Obtener datos de PHP
    fetch('php/kpslist.php')
      .then(response => response.json())
      .then(data => {
        // Datos de ingresos, punto de equilibrio y utilidades
        var datosIngresos = data.ingresos;
        var datosPuntoEquilibrio = data.puntoEquilibrio;

        // Calcular datos de utilidades
        var datosUtilidades = datosIngresos.map(ingreso => {
          var puntoEquilibrio = datosPuntoEquilibrio.find(item => item.fecha === ingreso.fecha);
          var montoPuntoEquilibrio = puntoEquilibrio ? puntoEquilibrio.monto : 0;
          return { fecha: ingreso.fecha, monto: ingreso.monto - montoPuntoEquilibrio };
        });

        // Obtener fechas únicas
        var fechasUnicas = [...new Set([...datosIngresos.map(item => item.fecha), ...datosPuntoEquilibrio.map(item => item.fecha)])];

        // Ordenar las fechas de manera ascendente
        fechasUnicas.sort();

        // Función para obtener el monto para una fecha específica
        function getMonto(datos, fecha) {
          var registro = datos.find(item => item.fecha === fecha);
          return registro ? registro.monto : 0;
        }

        // Crear gráfico de ECharts
        ingresosPuntoEquilibrioChart = echarts.init(document.getElementById('ingresosPuntoEquilibrio'));

        var option = {
          title: {
            text: 'Ingresos, Punto de Equilibrio y Utilidades'
          },
          legend: {
            data: ['Ingresos', 'Punto de Equilibrio', 'Utilidades'],
            bottom: 0
          },
          xAxis: {
            type: 'category',
            data: fechasUnicas
          },
          yAxis: {
            type: 'value',
            name: 'Montos'
          },
          tooltip: {
            trigger: 'axis',
            axisPointer: {
              type: 'cross'
            },
            formatter: function (params) {
              var result = params[0].name + '<br>';
              params.forEach(function (item) {
                result += item.seriesName + ': ' + item.value + '<br>';
              });
              return result;
            }
          },
          series: [
            {
              name: 'Ingresos',
              type: 'line',
              data: fechasUnicas.map(fecha => getMonto(datosIngresos, fecha))
            },
            {
              name: 'Punto de Equilibrio',
              type: 'line',
              data: fechasUnicas.map(fecha => getMonto(datosPuntoEquilibrio, fecha))
            },
            {
              name: 'Utilidades',
              type: 'line',
              data: fechasUnicas.map(fecha => getMonto(datosUtilidades, fecha))
            }
          ]
        };

        // Establecer opciones y dibujar gráfico
        ingresosPuntoEquilibrioChart.setOption(option);
      })
      .catch(error => console.error('Error al obtener datos:', error));
}

// Función para cargar y mostrar la gráfica de Clientes por Mes
function cargarClientesPorMes() {
    // Obtener datos de PHP
    fetch('php/kpslist.php')
      .then(response => response.json())
      .then(data => {
        var datosClientes = data.clientes;

        // Crear gráfico de barras
        clientesChart = echarts.init(document.getElementById('clientesPorMes'));

        var option = {
          title: {
            text: 'Clientes por Mes'
          },
          xAxis: {
            type: 'category',
            data: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo']
          },
          yAxis: {
            type: 'value',
            name: 'Cantidad de Clientes',
            min: 0,
            max: 5,
            interval: 1
          },
          series: [
            {
              name: 'Clientes',
              type: 'bar',
              data: [
                datosClientes.clientes_enero,
                datosClientes.clientes_febrero,
                datosClientes.clientes_marzo,
                datosClientes.clientes_abril,
                datosClientes.clientes_mayo
              ],
              label: {
                show: true,
                position: 'top'
              },
              emphasis: {
                focus: 'series'
              },
              tooltip: {
                show: true,
                formatter: '{b}: {c}'
              }
            }
          ],
        };

        // Establecer opciones y dibujar gráfico
        clientesChart.setOption(option);
      })
      .catch(error => console.error('Error al obtener datos:', error));
}

function inicializarGraficoVentasPorServicio() {
  // Obtener datos de PHP
  fetch('php/kpslist.php')
    .then(response => response.json())
    .then(data => {
      var nombresServicio = data.ventasPorServicio.map(item => item.Nombre_Servicio);
      var ingresosPorServicio = data.ventasPorServicio.map(item => item.Ingreso);

      // Crear gráfico de ECharts para Ventas por Servicio
      ventasPorServicioChart = echarts.init(document.getElementById('ventasPorServicio'));

      var option = {
        title: {
          text: 'Ventas por Servicio'
        },
        xAxis: {
          type: 'category',
          data: nombresServicio
        },
        yAxis: {
          type: 'value',
          name: 'Ingreso'
        },
        dataZoom: [
          {
              type: 'inside', 
              start: 0,
              end: 100
          },
          {
              type: 'slider', 
              start: 0,
              end: 100
          }
        ],
        tooltip: {
          trigger: 'axis',
          formatter: function (params) {
              var data = params[0].data;
              return 'Ingreso: ' + data;
          }
        },
        series: [
          {
            name: 'Ingreso',
            type: 'bar',
            data: ingresosPorServicio,
            itemStyle: {
              color: '#5BB75B' 
            },
            emphasis: {
              itemStyle: {
                color: '#3498db' 
              }
            }
          }
        ]
      };

      ventasPorServicioChart.setOption(option);
    })
    .catch(error => console.error('Error al obtener datos:', error));
}


// Función para cambiar el tipo de gráfica
function cambiarTipoGrafica() {
  var tipoSeleccionado = document.getElementById('tipoGrafica').value;

  // Ocultar todas las gráficas
  document.getElementById('clientesPorMes').style.display = 'none';
  document.getElementById('ingresosPuntoEquilibrio').style.display = 'none';
  document.getElementById('ventasPorServicio').style.display = 'none';

  // Mostrar la gráfica seleccionada
  switch (tipoSeleccionado) {
    case 'clientes':
      document.getElementById('clientesPorMes').style.display = 'block';
      break;
    case 'ingresos':
      document.getElementById('ingresosPuntoEquilibrio').style.display = 'block';
      break;
    case 'servicios':
      document.getElementById('ventasPorServicio').style.display = 'block';
      break;
    // Agrega más casos según tus necesidades
  }
}

// Llamada a la función al cargar la página
cargarClientesPorMes()
  
cargarGraficoIngresosPuntoEquilibrio();

inicializarGraficoVentasPorServicio();
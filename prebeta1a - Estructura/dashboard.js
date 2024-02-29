function renderGraficaCrecimiento() {
    var myChart = echarts.init(document.getElementById('crecimiento'));

    fetch('php/getData.php')
        .then(response => response.json())
        .then(data => {
            var fechas = data.ingresos.map(item => item.fecha);
            var montos = data.ingresos.map(item => item.monto);

            var option = {
                title: {
                    text: 'Crecimiento de Ingresos'
                },
                tooltip: {
                    trigger: 'axis',
                    formatter: function (params) {
                        var date = params[0].axisValue;
                        var value = params[0].data;
                        return date + '<br>Monto: ' + value;
                    }
                },
                xAxis: {
                    type: 'category',
                    data: fechas
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: montos,
                    type: 'line',
                    label: {
                        show: true,
                        formatter: '{c}',
                        position: 'top'
                    }
                }]
            };

            myChart.setOption(option);
        })
        .catch(error => console.error('Error en gráfica de crecimiento:', error));
}


var originalData; // Almacena los datos originales
var currentCurrency = 'peso'; // Moneda predeterminada

// Función para hacer la solicitud AJAX y obtener datos de PHP
function fetchData(callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
    if (xhr.readyState == 4 && xhr.status == 200) {
        originalData = JSON.parse(xhr.responseText);
        callback(originalData);
    }
    };
    xhr.open("GET", "php/getData.php", true);
    xhr.send();
}

var chart = echarts.init(document.getElementById('chartContainer'));

function updateChart() {
  var startDate = document.getElementById('startDate').value;
  var endDate = document.getElementById('endDate').value;

  // Filtrar datos basados en el rango de fechas
  var filteredData = originalData.filter(function (item) {
    return item.date >= startDate && item.date <= endDate;
  });

  // Actualizar el gráfico con los datos filtrados y la moneda actual
  updateChartWithData(filteredData, currentCurrency);
}


function updateChartWithData(filteredData, currency) {
    var dates = filteredData.map(function (item) {
      return item.date;
    });

    var amounts = filteredData.map(function (item) {
      return convertCurrency(item.amount, currency);
    });

    // Configurar la opción del gráfico
    var option = {
      xAxis: {
        type: 'category',
        data: dates
      },
      tooltip: {
        trigger: 'axis',
        formatter: function (params) {
        var date = params[0].axisValue;
        var value = params[0].data;
        return date + '<br>Monto: ' + value;
        }
      },
      yAxis: {
        type: 'value',
        axisLabel: {
          formatter: '{value} ' + getCurrencySymbol(currency) // Agrega el símbolo de la moneda al eje Y
        }
      },
      series: [{
        data: amounts,
        type: 'line',
        label: {
          show: true,
          formatter: '{c}',
          position: 'top'
        }
      }]
    };

    // Actualizar el gráfico con la nueva configuración
    chart.setOption(option);
}

// Función para cambiar la moneda
function changeCurrency() {
    var selectedCurrency = document.getElementById('currencySelector').value;
    currentCurrency = selectedCurrency;
    updateData();
    updateChart(); // Actualiza el gráfico con la nueva moneda
}

function convertCurrency(amount, currency) {
    // Tasas de conversión
    const pesoToDollarRate = 16;
    const pesoToEuroRate = 0.053;

    // Convertir de pesos a dólares
    if (currency === 'dolar') {
    return amount / pesoToDollarRate;
    } 
    

    // Convertir de pesos a euros
    if (currency === 'euro') {
        return amount * pesoToEuroRate;
    }

    // Por defecto, asumimos que el monto ya está en pesos
    return amount;
}

function getCurrencySymbol(currency) {
  
    switch (currency) {
        case 'peso':
          return '$';
        case 'dolar':
          return 'US$';
        case 'euro':
          return '€';
        default:
          return '';
    }
}

// Inicializar el gráfico con todos los datos al cargar la página
fetchData(function(data) {
    updateChartWithData(data, currentCurrency);
});

function actualizarVelocimetro(url) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);

            // Configuración del gráfico
            var option = {
                title: {
                    text: 'Velocimetro de Metas'
                },
                series: [{
                    type: 'gauge',
                    detail: { formatter: '{value}%', fontSize: 20 },
                    data: [{ value: data.porcentajeCompletadas, name: 'Metas' }],
                    min: 0,
                    max: 100,
                    axisLabel: { show: true, fontSize: 10 },
                    splitLine: { show: true, length: 20 },
                    pointer: { width: 5 },
                    title: { show: true, offsetCenter: [0, '-40%'] }
                }]
            };

            // Inicializa el gráfico
            var chart = echarts.init(document.getElementById('velocimetro'));
            chart.setOption(option);
        }
    };
    xhr.open('GET', url, true);
    xhr.send();
}

function initMap() {
    // Inicializa el mapa en una ubicación y con un nivel de zoom
    var map = L.map('map').setView([23.6345, -102.5528], 4);

    // Añade una capa de mapa de OpenStreetMap
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    // Realiza una solicitud al servidor PHP para obtener datos de ubicación relacionados con negocios
    fetch('php/mapa.php')
        .then(response => response.json())
        .then(data => {
            // Agrega marcadores al mapa utilizando los datos recuperados
            data.forEach(location => {
                L.marker([location.latitud, location.longitud]).addTo(map)
                    .bindPopup(location.nombre_negocio);
            });
        })
        .catch(error => console.error('Error:', error));
}



// Llama a la función para inicializar el mapa y agregar marcadores
initMap();

// Llama a la función con la URL del script PHP
actualizarVelocimetro('php/obtener_metas.php');
// Llama a las funciones para cargar y renderizar las gráficas
renderGraficaCrecimiento();

window.addEventListener('resize', function () {
    actualizarVelocimetro('php/obtener_metas.php');
    renderGraficaCrecimiento();

});
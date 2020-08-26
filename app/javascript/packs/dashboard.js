var Chart = require('chart.js');
let colors1 = ['#264653', "#2A9D8F", "#E9C46A", "#F4A261", "#E76F51", "#E63946", "#F1FAEE", "#A8DADC", "#457B9D", "#fefae0"]
let colors2 = ["#F4A261", "#E76F51", "#E63946"]
let floorChart = document.getElementById('floorChart').getContext('2d')
let officeChart = document.getElementById('officeChart').getContext('2d')

let chartQuery = (route, canvas, chartType, chartColor) => {
  let result = [[],[]];
  fetch(route)
  .then(response => response.json())
  .then(data => {
    console.log(data)
    data.forEach(row => {
      result[0].push(row.obj)
      result[1].push(row.count)
    });
    
    console.log(result[0].length >= 0 ? 'yes' : 'No')
    //CRETE the chart
    new Chart(canvas, {
      type: chartType,
      data: {
        labels: result[0].length > 0 ? result[0] : ['Sin datos'],
        datasets: [{
          label: 'alguna label',
          backgroundColor: chartColor,
          data: result[1].length > 0 ? result[1] : [1]
        }]
      },
      options: {}
    });
    //End chart
  })  
  .catch(error => {
    canvas.font = "10px Arial";
    canvas.fillText("Problemas con los datos", 10, 50);
  })
}

chartQuery('/three_floor', floorChart, 'doughnut', colors1)
chartQuery('/three_office', officeChart, 'doughnut', colors2)


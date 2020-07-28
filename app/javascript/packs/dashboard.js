var Chart = require('chart.js');
let colors = ['#264653', "#2A9D8F", "#E9C46A", "#F4A261", "#E76F51", "#E63946", "#F1FAEE", "#A8DADC", "#457B9D", "#fefae0"]
let myChart = document.getElementById('myChart').getContext('2d')

fetch('/chart_')
.then(response => response.json())
.then(data => {

})

let myDoughnutChart = new Chart(myChart, {
  type: 'doughnut',
  data: {
    labels: ['uno', 'dos', 'tre', 'cuatro', 'cinco', 'six', 'a', 'b', 'c', 'z'],
    datasets: [{
      label: 'alguna label',
      backgroundColor: colors,
      data: [6,5,4,3,2,1,1, 2,3,2]
    }]
  },
  options: {}
});
var Chart = require('chart.js');
console.log(Chart)

let div1 = document.getElementById('div1')
let myDoughnutChart = Chart(ctx, {
  type: 'doughnut',
  data: data,
  options: options
});

div1.appendChild.myDoughnutChart
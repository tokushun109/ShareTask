# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.line_graph = ->
    ctx = document.getElementById("myLineChart")
    myLineChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: graph_x,
        datasets: [{
            label: '進捗度',
            data: graph_y,
            borderColor: "rgba(255,0,0,1)",
            backgroundColor: "rgba(255,0,0,0.3)",
            lineTension: 0
        }]
      },
      options: {
        scales: {
          xAxes: [{
              type: 'time',
              time: {
                unit: 'day'
              }
          }],
          yAxes: [{
            ticks: {
              max: 100,
              min: 0,
              stepSize: 25,
              callback: (value, index, values) ->
                return  value +  '%'
            }
          }],
        },
        legend: {
          display:false
        },
        title: {
          display: true,
          text: '進捗度',
        }
      }
    })

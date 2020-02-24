# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.draw_graph = ->
    ctx = document.getElementById("myLineChart")
    myLineChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: graph_x,
        datasets: [
          {
            label: '進捗度',
            data: graph_y,
            borderColor: "rgba(255,0,0,1)",
            backgroundColor: "rgba(0,0,0,0)"
          },
        ],
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
              suggestedMax: 100,
              suggestedMin: 0,
              stepSize: 25,
              callback: (value, index, values) ->
                return  value +  '%'
            }
          }],
        },
      }
    })

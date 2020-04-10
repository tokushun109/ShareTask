# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.bar_graph = ->
    ctx = document.getElementById("myLineChart")
    myLineChart = new Chart(ctx, {
      type: "bar",
      data:{
        labels: graph_x,
        datasets:[{
          backgroundColor: 'rgba(91,192,222,1)',
          label: '進捗度',
          data: graph_y
        }]
      },
      options:{
        scales: {
          yAxes: [{
            ticks: {
              suggestedMax: 100,
              suggestedMin: 0,
              stepSize: 25,
              callback: (value, index, values) ->
                return  value +  '%'
              }
          }]
        }
      }
    })

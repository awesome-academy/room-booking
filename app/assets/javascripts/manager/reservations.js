$(document).ready(function() {
  var primaryColor = getComputedStyle(document.body).getPropertyValue('--primary');
  var secondaryColor = getComputedStyle(document.body).getPropertyValue('--secondary');
  var successColor = getComputedStyle(document.body).getPropertyValue('--success');
  var warningColor = getComputedStyle(document.body).getPropertyValue('--warning');
  var dangerColor = getComputedStyle(document.body).getPropertyValue('--danger');
  var infoColor = getComputedStyle(document.body).getPropertyValue('--info');
  var darkColor = getComputedStyle(document.body).getPropertyValue('--dark');
  var lightColor = getComputedStyle(document.body).getPropertyValue('--light');

  function printChart(data) {
    Morris.Line({
      element: 'reservations_chart',
      data: data,
      xkey: 'y',
      ykeys: ['a','b'],
      labels: ['Total Bill', 'Total Book']
    });
  }

  function renderChart() {
    $.ajax({
      type: "POST",
      url: document.URL+'/get_data',
      dataType: "json",
      cache: false,
      contentType: "application/json",
      success: function(data) {
        $('#reservations_chart').html('');
        printChart(data);
      },
      error: function(xhr, status, error) {
        alert(xhr.status);
      }
    });
  }

  renderChart();

  renderDChart();

  function renderDChart() {
    $.ajax({
      type: "POST",
      url: document.URL+'/get_data1',
      dataType: "json",
      cache: false,
      contentType: "application/json",
      success: function(data) {
        console.log(data.a)
        printDChart(data);
      },
      error: function(xhr, status, error) {
        alert(xhr.status);
      }
    });
  }


  function printDChart(data1){
    var doughnutChartCanvas = $("#UsersDoughnutChart1").get(0).getContext("2d");
    var doughnutPieData = {
        datasets: [{
            data: data1.a,
            backgroundColor: [
                successColor,
                infoColor,
                secondaryColor
            ],
            borderColor: [
                successColor,
                infoColor,
                secondaryColor
            ],
        }],
        labels: data1.y
    };
    console.log(doughnutPieData)
    var doughnutPieOptions = {
        cutoutPercentage: 70,
        animationEasing: "easeOutBounce",
        animateRotate: true,
        animateScale: false,
        responsive: true,
        maintainAspectRatio: true,
        showScale: true,
        legend: {
            display: false
        },
        layout: {
            padding: {
                left: 0,
                right: 0,
                top: 0,
                bottom: 0
            }
        }
    };
    var doughnutChart = new Chart(doughnutChartCanvas, {
        type: 'doughnut',
        data: doughnutPieData,
        options: doughnutPieOptions
    });
    }
});

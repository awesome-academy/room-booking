$(document).ready(function() {

  function printChart1(data) {
    Morris.Line({
      element: 'users_chart',
      data: data,
      xkey: 'y',
      ykeys: ['a'],
      labels: ['Total New Account']
    });
  }

  function renderChart1() {
    $.ajax({
      type: "POST",
      url: document.URL+'/get_data',
      dataType: "json",
      cache: false,
      contentType: "application/json",
      success: function(data) {
        $('#users_chart').html('');
        printChart1(data);
      },
      error: function(xhr, status, error) {
        alert(xhr.status);
      }
    });
  }

  renderChart1();

});

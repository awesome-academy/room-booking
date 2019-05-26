$(document).ready(function() {
  var location = $('#mydata').data('location');
  initialize(location);
  function initialize(location) {
    var i;
    for (i = 0; i < location.length; i++) {
      $('#stars_'+location[i].id).raty({
        path: '/assets',
        readOnly: true,
        score: location[i].total_rate
      });
    }
  }
});

$(document).ready(function() {
  var review = $('#mydata1').data('review');
  initialize(review);
  function initialize(review) {
    var i;
    for (i = 0; i < review.length; i++) {
      $('#stars_'+review[i].id).raty({
        path: '/assets',
        readOnly: true,
        score: review[i].rate
      });
    }
  }
});

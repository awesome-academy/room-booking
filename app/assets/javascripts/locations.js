$(document).ready(function() {
  var location = $('#mydata').data('location');
  function initialize() {
    var mapCanvas = document.getElementById('map-canvas');
    var mapOptions = {
      center: new google.maps.LatLng(location['latitude'], location['longitude']),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(mapCanvas, mapOptions);
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(location['latitude'], location['longitude']),
      title: I18n.t("javascripts.locations.roombooking")
    });
    marker.setMap(map);
  }
  initialize();
  google.maps.event.addDomListener(window, 'load', initialize);

  function star_rating() {
    $('#star-rating').raty({
      path: '/assets/',
      scoreName: 'review[rate]',
    });
  };

  star_rating();

  var review = $('#mydata1').data('review');
  initializee(review);
  function initializee(review) {
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

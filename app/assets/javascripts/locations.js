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
  google.maps.event.addDomListener(window, 'load', initialize);
});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require oms.min
//= require map

//= require jquery.ui.widget
//= require z.jquery.fileupload

//= require bootstrap-sprockets
//= require_tree .

// ########$(function() {
// ########  $('.directUpload').find("input:file").each(function(i, elem) {
// ########    var fileInput    = $(elem);
// ########    console.log(fileInput);
// ########  });
// ########});

//HOLD MARKERS
var marker_container = [];
//********************************************************
// function initMap(){
  //Specify features and elements to define styles.
  // var styleArray = [
  //   {
  //     featureType: "all",
  //     stylers: [
  //      { saturation: -80 }
  //     ]
  //   },{
  //     featureType: "road.arterial",
  //     elementType: "geometry",
  //     stylers: [
  //       { hue: "#00ffee" },
  //       { saturation: 50 }
  //     ]
  //   },{
  //     featureType: "poi.business",
  //     elementType: "labels",
  //     stylers: [
  //       { visibility: "off" }
  //     ]
  //   }
  // ];
  
// Create a map object and specify the DOM element for display.
  var latlng = new google.maps.LatLng(35.2725611, -120.7054056);
  var myOptions = {
      center: latlng,
      scrollwheel: false,
      //styles: styleArray,
      zoom: 5,
      minZoom: 3,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
  };
 //********************************************************

//POPULATE MAP WITH MARKERS OF USERS PICS AND CREATE INFOWINDOWS ON CLICK
function populateMap(response) {

var mymap = new google.maps.Map(document.getElementById('map-canvas'), myOptions);

 google.maps.event.addListener(mymap, 'click', function(event){
  this.setOptions({scrollwheel:true});
 });
 google.maps.event.addListener(mymap, 'mouseout', function(event){
  this.setOptions({scrollwheel:false});  
 });

var geocoder = new google.maps.Geocoder();

  document.getElementById('submit').addEventListener('click', function() {
    geocodeAddress(geocoder, mymap);
  });

var oms = new OverlappingMarkerSpiderfier(mymap);//

var infoWindow = new google.maps.InfoWindow({content: ""});

while(marker_container[0]){
  marker_container.pop().setMap(null);
}

oms.clearListeners('click');
oms.clearMarkers();

for (var i=0; i<response.length;i++){

 //reset image and marker size
 var icon = {
  url: response[i].thumbnail, 
  scaledSize: new google.maps.Size(50, 50), 
  origin: new google.maps.Point(0, 0), 
  anchor: new google.maps.Point(0, 0),  
        };//var icon

 //place marker
 var marker = new google.maps.Marker({
  position: {
    lat: response[i].location.latitude,
    lng: response[i].location.longitude},
    map: mymap,
    icon: icon,
            });//var marker

 marker_container.push(marker);

      //create content for infowindow
      marker.desc = "<img src=\""+response[i].url+"\" height=\"370\" width=\"370\"><div class=\"pic_info\">"+response[i].username+" "+response[i].tags+"</div>";

      oms.addMarker(marker);

      oms.addListener('click', function(marker, event) {
        infoWindow.setContent(marker.desc);
        infoWindow.open(mymap, marker);
      });
    }
  }

  function geocodeAddress(geocoder, resultsMap) {
  var address = document.getElementById('address').value;
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      resultsMap.setCenter(results[0].geometry.location);
/*      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });*/
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}
//***********BELOW IS ALL THE AJAX UNCOMMENT AFTER MAP SHOWS UP********

function initialize() {

  $.ajax({
    method: 'GET',
    url: 'map/usersfeed',
    dataType: 'JSON',
  })
  .done(function(data) {
    populateMap(data);
    console.log("Successfully got data on initialize!!");
  })
  .fail(function(data) {
    console.log( "Failed to get my own data initialize :(");
    console.log(JSON.stringify(data));
  })
}

//event listener to run initialize method on window complete load
google.maps.event.addDomListener(window, 'load', initialize);


$(document).ready(function() {

  function getNewsFeed(event){
    event.preventDefault();
    $.ajax({
      method: 'GET',
      url: 'map/mediafeed',
      dataType: 'JSON',
    })
    .done(function(data) {
      populateMap(data);
      console.log("Successfully got my data on click!!");
    })
    .fail(function(data) {
      console.log( "Failed to get my data on click :(");
      console.log(JSON.stringify(data));
    })
  }

  function getUserPics(event){
    event.preventDefault();
    $.ajax({
      method: 'GET',
      url: 'map/usersfeed',
      dataType: 'JSON',
    })
    .done(function(data) {
      populateMap(data);
      console.log("Successfully got data on initialize!!");
    })
    .fail(function(data) {
      console.log( "Failed to get my own data initialize :(");
      console.log(JSON.stringify(data));
    })
  } 

// var signout = function() {
//   document.location.href = "https://instagram.com/accounts/logout?continue=http://www.mysite.com";
// };
  // function logout(event){
  //   event.preventDefault();

  //   $.ajax({
  //     url: "map/destroy",
  //     method: 'get',
  //     dataType: 'JSON',
  //   })
  //   .done(function(data) {
  //     if(result === "no_errors") location.href = "http://www.google.com"
  //         console.log("Logout Successful");
  //   })
  //   .fail(function(e) {
  //     alert('Error::' + e.responseText);
  //     console.log("logout fail");
  //   })
  // }
  // function currentLocation(){
  //   if (navigator.geolocation){
  //        navigator.geolocation.getCurrentPosition(getPosition);
  //    }
  //    else{
  //         alert("Geolocation is not supported by this browser.");
  //    }
  // }

  // function getPosition(position) {
  //       UserLatitude = position.coords.latitude;
  //       UserLongitude = position.coords.longitude;
  //       showPosition(UserLatitude, UserLongitude);
  // }

  // function showPosition(userLatitude, userLongitude){
  //   lat= userLatitude;
  //   lon= userLongitude;
  //   latlon=new google.maps.LatLng(lat, lon);
  //   map.panTo(latlon);
  //   map.setZoom(15);
  //   var circle = new google.maps.Circle({
  //     map: map,
  //     center: latlon,
  //     radius: 100,
  //     fillColor: '#5CB8E6',
  //   });
  // }


  $("#users_feed").on("click", getUserPics);
  $("#news_feed").on("click", getNewsFeed);
  //$("#instagram_logout").on("click", logout);
  // $("#center").on("click", currentLocation);
});



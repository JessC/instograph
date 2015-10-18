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

//= require bootstrap-sprockets
//= require_tree .

//********************************************************
//HOLD MARKERS

 var marker_container = [];


// function initMap(){
  // Specify features and elements to define styles.
  var styleArray = [
    {
      featureType: "all",
      stylers: [
       { saturation: -80 }
      ]
    },{
      featureType: "road.arterial",
      elementType: "geometry",
      stylers: [
        { hue: "#00ffee" },
        { saturation: 50 }
      ]
    },{
      featureType: "poi.business",
      elementType: "labels",
      stylers: [
        { visibility: "off" }
      ]
    }
  ];

  
// Create a map object and specify the DOM element for display.
  var latlng = new google.maps.LatLng(37.3359971, -121.8847111);
  var myOptions = {
      center: latlng,
      scrollwheel: false,
      styles: styleArray,
      zoom: 8
      // mapTypeId: google.maps.MapTypeId.ROADMAP,
  };

  //STARTS A NEW MAP "CANVAS" WITH "OPTIONS"
 //********************************************************


 //CREATES AN INSTANCE OF THE OVERLLAPPINGSPIDERFIER
 // var oms = new OverlappingMarkerSpiderfier(mymap);//
// }



//POPULATE MAP WITH MARKERS OF USERS PICS AND CREATE INFOWINDOWS ON CLICK
function populateMap(response) {

var mymap = new google.maps.Map(document.getElementById('map-canvas'), myOptions);

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
//***********BELOW IS ALL THE AJAX UNCOMMENT AFTER MAP SHOWS UP********

function initialize() {

    $.ajax({
      method: 'GET',
      url: 'map/usersfeed',
      dataType: 'JSON',
    })
    .done(function(data) {
      populateMap(data);
      console.log("Successfully got data on initialize!!")
    })
    .fail(function(data){
      console.log( "Failed to get my own data initialize :(" );
      console.log(JSON.stringify(data));
    })
}

//event listener to run initialize method on window complete load
  google.maps.event.addDomListener(window, 'load', initialize);


$(document).ready(function() {

  function getUserPics(event){
    event.preventDefault();
    $.ajax({
      method: 'GET',
      url: 'map/usersfeed',
      dataType: 'JSON',
    })
    .done(function(data){
      populateMap(data);
      console.log( "Successfully got my own data after button click! :)" );
    })
    .fail(function() {
      console.log( "Failed to get my own data on button click :(" );
      console.log(JSON.stringify(data));
    });
  }

  function getNewsFeed(event){
    
    event.preventDefault();
    $.ajax({
      method: 'GET',
      url: 'map/mediafeed',
      dataType: 'JSON',
    })
      .done(function(data){
        populateMap(data);
      })
      .fail(function(data){
        console.log( "Failed to get my own data on button initialize :(" );
        console.log(JSON.stringify(data));
      });
  }
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


  $("#profile_pic").on("click", getUserPics);
  $("#news_feed").on("click", getNewsFeed);
  // $("#center").on("click", currentLocation);
});


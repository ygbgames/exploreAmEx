<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
      
      .controls {
        margin-top: 10px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 400px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }

	.addressClass{
	font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size: 16px;
  line-height: 1.5;
  color: #222;
	}
    </style>
<title>Issue</title>
    <link rel="stylesheet" href="css/style.css">
    <script	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=false&libraries=places"></script>
    
    
<script type="text/javascript">
var geocoder;
$(function(){
	initialize();
	
});


var map;

function initialize() {
var mapOptions = {
zoom: 14,
disableDefaultUI: true
};

var markers = [];
map = new google.maps.Map(document.getElementById('map-canvas'),
		  mapOptions);

/* var defaultBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(-33.8902, 151.1759),
    new google.maps.LatLng(-33.8474, 151.2631));
map.fitBounds(defaultBounds); */

// Create the search box and link it to the UI element.
var input = /** @type {HTMLInputElement} */(
    document.getElementById('pac-input'));
map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

var searchBox = new google.maps.places.SearchBox(
  /** @type {HTMLInputElement} */(input));

// [START region_getplaces]
// Listen for the event fired when the user selects an item from the
// pick list. Retrieve the matching places for that item.
google.maps.event.addListener(searchBox, 'places_changed', function() {
  var places = searchBox.getPlaces();

  if (places.length == 0) {
    return;
  }
  for (var i = 0, marker; marker = markers[i]; i++) {
    marker.setMap(null);
  }

  // For each place, get the icon, place name, and location.
  markers = [];
  var bounds = new google.maps.LatLngBounds();
  for (var i = 0, place; place = places[i]; i++) {
    var image = {
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(25, 25)
    };

    // Create a marker for each place.
    var marker = new google.maps.Marker({
      map: map,
      icon: image,
      title: place.name,
      position: place.geometry.location
    });

    
    markers.push(marker);

    bounds.extend(place.geometry.location);
    
   	(function(z){
        google.maps.event.addListener(marker, "click", function() {
           show_details(z);
        });    
     })(marker);
  }

  map.fitBounds(bounds);
});
// [END region_getplaces]

// Bias the SearchBox results towards places that are within the bounds of the
// current map's viewport.
google.maps.event.addListener(map, 'bounds_changed', function() {
  var bounds = map.getBounds();
  searchBox.setBounds(bounds);
});


// Try HTML5 geolocation
if(navigator.geolocation) {
navigator.geolocation.getCurrentPosition(function(position) {
  var pos = new google.maps.LatLng(position.coords.latitude,
                                   position.coords.longitude);
  var contentStringCal = '<div id="contentCal">Your Current Location</div>';
  var m=new google.maps.Marker({
      position: pos,
      map: map,
      icon: 'images/myloc.png',
      animation: google.maps.Animation.DROP
    });
  
  var infowindow = new google.maps.InfoWindow({});
  
        
  google.maps.event.addListener(m, 'mouseover', function() {
      //open the infowindow when it's not open yet
      if(contentStringCal!=infowindow.getContent())
      {
        infowindow.setContent(contentStringCal);
        infowindow.open(map,m);
      }
  });
  
  google.maps.event.addListener(m, 'click', function() {
      //when the infowindow is open, close it an clear the contents
      if(contentStringCal==infowindow.getContent())
      {
        infowindow.close(map,m);
        infowindow.setContent('');
      }
      //otherwise trigger mouseover to open the infowindow
      else
      {
        google.maps.event.trigger(m, 'mouseover');
      }
  });
  //clear the contents of the infwindow on closeclick
  google.maps.event.addListener(infowindow, 'closeclick', function() {
        infowindow.setContent('');
  });

  map.setCenter(pos);
}, function() {
  handleNoGeolocation(true);
});
} else {
// Browser doesn't support Geolocation
handleNoGeolocation(false);
}

//$("#pac-input").css('position','');
}


function show_details(a){
	$("#storeName").val("");
	$("#storeName").val(a.title);
	$("#storenamespan").html($("#storeName").val());
	geocoder = new google.maps.Geocoder();
	pos=a.getPosition();
	geocoder.geocode({
	    latLng: pos
	  }, function(responses) {
	    if (responses && responses.length > 0) {
	      updateMarkerAddress(responses[0].formatted_address);
	    } else {
	      updateMarkerAddress('Cannot determine address at this location.');
	    }
	  });
}
function updateMarkerAddress(address){
	$("#myaddress").val("");
	$("#myaddress").val(address);
	$("#storeaddspan").html($("#myaddress").val()/* .replace(/,/g, ",<br/>") */);
	
}


function handleNoGeolocation(errorFlag) {
if (errorFlag) {
 content = 'Error: The Geolocation service failed.';
} else {
 content = 'Error: Your browser doesn\'t support geolocation.';
}

var options = {
map: map,
position: new google.maps.LatLng(60, 105),
content: content
};

var infowindow = new google.maps.InfoWindow(options);
map.setCenter(options.position);
}

//google.maps.event.addDomListener(window, 'load', initialize);


function submitlocationclick(){
		$("#reportform").submit();
}

function mylocation() {
		  // Try HTML5 geolocation
		  if(navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		      var pos = new google.maps.LatLng(position.coords.latitude,
		                                       position.coords.longitude);


		      map.setCenter(pos);
		    }, function() {
		      handleNoGeolocation(true);
		    });
		  } else {
		    // Browser doesn't support Geolocation
		    handleNoGeolocation(false);
		  }
		}

		function handleNoGeolocation(errorFlag) {
		  if (errorFlag) {
		     content = 'Error: The Geolocation service failed.';
		  } else {
		     content = 'Error: Your browser doesn\'t support geolocation.';
		  }

		  var options = {
		    map: map,
		    position: new google.maps.LatLng(60, 105),
		    content: content
		  };

		  var infowindow = new google.maps.InfoWindow(options);
		  map.setCenter(options.position);
}

</script>
</head>
<body style="background: none;">
 <div style="height:500px;">
  	<div style='height:50px;background: #ccc;'></div>
    
    <div style="text-align: center;margin: 15px 0px 0px 0px;">
    	
    <input	type="button" name="mylocation" onclick="mylocation();" class="login login-submit" id='reportProblemBtn' value="My Location" style="cursor: pointer;width: 250px;"></div>
    	
    	<div style="text-align: center;margin: 0px 0px;display: none;" id="searchdiv">
  			<input id="pac-input" class="controls" type="text" placeholder="Search Box">
  			
  		</div>
    	<div id="map-canvas" style="height:400px; width:60%;margin:15px auto"></div>
    </div>
	<form method="post" action='issue.jsp' id="reportform">
    	<input type="hidden" id="storeName" name="storename"/>
    	<input type="hidden" id='myaddress' name="storeaddress"/>
   </form>
   <div style="width: 60%;margin: 35px auto 0px auto;">
   <table style="width: 100%">
   	<tr class="addressClass">
   		<td style="width: 120px;vertical-align: top;"><b>Store Name </b></td>
   		<td  style="width:*;vertical-align: top;" id="storenamespan"></td>
   	</tr>
   	<tr class="addressClass">
   		<td style="vertical-align: top;"><b>Store Address </b></td>
   		<td id="storeaddspan"></td>
   	</tr>
   </table>
   </div>
   <br/>
   <br/>
   <div style="margin: 10px auto;width: 60%;text-align: center;"><input	type="button" onclick="submitlocationclick();" name="nextpage" class="login login-submit" id='nextpage' 
   value="Next" style="cursor: pointer;width: 250px;">
    </div>
  </body>
</body>
</html>
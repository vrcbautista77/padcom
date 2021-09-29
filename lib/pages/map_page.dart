import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:padcom/models/pin_fill_info.dart';
import 'package:padcom/models/user_location_model.dart';
import 'package:padcom/pages/map_pin_pill.dart';
import 'package:provider/provider.dart';

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Set<Marker> _markers = {};
//   BitmapDescriptor mapMarker;
//   UserLocation userLocation;
//   Position currentPosition;
//   bool showSOS = false;

//   List<Map<String, dynamic>> bikeShops = [
//     {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000, "ratings": "9 out of 10"}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//     // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
//   ];

//   void locatePosition() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     currentPosition = position;

//     LatLng latLngPosition = LatLng(position.latitude, position.longitude);
//     CameraPosition cameraPosition = CameraPosition(target: latLngPosition);
//     GoogleMapController mapControllers;
//     mapControllers
//         ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }

//   @override
//   void initState() {
//     super.initState();
//     setCustomMarker();
//   }

//   void setCustomMarker() async {
//     mapMarker = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/marker_sos.png');
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     //To locatePosition
//     locatePosition();

//     bikeShops.forEach((element) {
//       _markers.add(Marker(
//           markerId: MarkerId(element['name']),
//           position: LatLng(element['lat'], element['long']),
//           infoWindow: InfoWindow(title: element['name'], snippet: element['ratings']),
//           onTap: ,
//           icon: mapMarker,
//         ));
//      });

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Check if enabled Location
//     userLocation = Provider.of<UserLocation>(context);

//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           setState(() {
//                       showSOS = !showSOS;
//                     });
//         },
//         child: Icon(Icons.location_searching),
//         backgroundColor: showSOS == false ? Colors.green : Colors.yellow,
//       ),
//       body: Container(
//         child: GoogleMap(
//           mapType: MapType.normal,
//           myLocationButtonEnabled: true,
//           myLocationEnabled: true,
//           zoomGesturesEnabled: true,
//           zoomControlsEnabled: true,
//           onMapCreated: _onMapCreated,
//           markers: showSOS == true ? _markers : {},
//           initialCameraPosition: CameraPosition(
//             target: LatLng(14.5032211, 121.0622898),
//             zoom: 15,
//           ),
//         ),
//       ),
//     );
//   }
// }

const double CAMERA_ZOOM = 12;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(14.4974668, 121.0451425);
const LatLng DEST_LOCATION = LatLng(14.587220, 121.182000);

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = 'AIzaSyARx6fzZKHGQjlC6RsAyRUlPmWMuOyUfBM';
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
  LocationData currentLocation;
// a reference to the destination location
  LocationData destinationLocation;
// wrapper around the location API
  Location location;
  double pinPillPosition = 10;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;
  bool showSOS = false;
  bool isStart = false;
  StreamSubscription<LocationData> locationSubscription;

  List<Map<String, dynamic>> bikeShops = [
    {
      "name": "ALON BIKE SHOP",
      "lat": 14.587220,
      "long": 121.182000,
      "ratings": "9 out of 10"
    }
  ];

  @override
  void initState() {
    super.initState();

    // create an instance of Location
    location = new Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    locationSubscription?.cancel();
    locationSubscription = location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation();
  }

  @override
  void dispose(){
    locationSubscription?.cancel();
    super.dispose();
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0), 'assets/marker.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0), 'assets/marker_sos.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();

    // hard-coded destination for this example
    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  _showSOS() {
    bikeShops.forEach((element) {
      _markers.add(Marker(
        markerId: MarkerId(element['name']),
        position: LatLng(element['lat'], element['long']),
        infoWindow:
            InfoWindow(title: element['name'], snippet: element['ratings']),
        // onTap: ,
        icon: destinationIcon,
      ));
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                _showSOS();

                setState(() {
                  showSOS = !showSOS;
                });
              },
              child: Icon(Icons.location_searching),
              backgroundColor: showSOS == false ? Colors.green : Colors.yellow,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isStart = !isStart;
                  });
                },
                child: isStart == false ? Icon(Icons.play_arrow) : Icon(Icons.stop),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton:
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            tiltGesturesEnabled: false,
            markers: showSOS ? _markers : {},
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onTap: (LatLng loc) {
              pinPillPosition = -100;
            },
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(Utils.mapStyles);
              _controller.complete(controller);
              // my map has completed being created;
              // i'm ready to show the pins on the map
              showPinsOnMap();
            },
          ),
          if (currentlySelectedPin.locationName != '')
            MapPinPillComponent(
                pinPillPosition: 50, currentlySelectedPin: currentlySelectedPin)
        ],
      ),
    );
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Your Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/marker_sos.png",
        avatarPath: "assets/default_user.png",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/marker_sos.png",
        avatarPath: "assets/default_user.png",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: sourceIcon));
    // destination pin

    bikeShops.forEach((element) {
      PinInformation pinInfo = PinInformation(
          locationName: element['name'],
          location: LatLng(element['lat'], element['long']),
          pinPath: "assets/marker_sos.png",
          avatarPath: "assets/marker_sos.png",
          labelColor: Colors.purple);

      _markers.add(Marker(
        markerId: MarkerId(element['name']),
        position: LatLng(element['lat'], element['long']),
        infoWindow:
            InfoWindow(title: element['name'], snippet: element['ratings']),
        onTap: () {
          setState(() {
            setPolylines(LatLng(element['lat'], element['long']));

            currentlySelectedPin = pinInfo;
            pinPillPosition = 0;
          });
        },
        icon: destinationIcon,
      ));
    });

    // _markers.add(Marker(
    //     markerId: MarkerId('destPin'),
    //     position: destPosition,
    //     onTap: () {
    //       setState(() {
    //         currentlySelectedPin = destinationPinInfo;
    //         pinPillPosition = 0;
    //       });
    //     },
    //     icon: destinationIcon));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    // setPolylines();
  }

  void setPolylines(LatLng destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 2, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: 16,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;

    if(isStart){
      controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    }
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}

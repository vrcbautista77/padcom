import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padcom/models/user_location_model.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  UserLocation userLocation;
  Position currentPosition;
  bool showSOS = false;

  List<Map<String, dynamic>> bikeShops = [
    {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000, "ratings": "9 out of 10"}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
    // {"name": "ALON BIKE SHOP", "lat": 14.587220, "long": 121.182000}
  ];

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLngPosition);
    GoogleMapController mapControllers;
    mapControllers
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/marker_sos.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    //To locatePosition
    locatePosition();

    bikeShops.forEach((element) {
      _markers.add(Marker(
          markerId: MarkerId(element['name']),
          position: LatLng(element['lat'], element['long']),
          infoWindow: InfoWindow(title: element['name'], snippet: element['ratings']),
          // onTap: ,
          icon: mapMarker,
        ));
     });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Check if enabled Location
    userLocation = Provider.of<UserLocation>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
                      showSOS = !showSOS;
                    });
        },
        child: Icon(Icons.location_searching),
        backgroundColor: showSOS == false ? Colors.green : Colors.yellow,
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          onMapCreated: _onMapCreated,
          markers: showSOS == true ? _markers : {},
          initialCameraPosition: CameraPosition(
            target: LatLng(14.5032211, 121.0622898),
            zoom: 15,
          ),
        ),
      ),
    );
  }
}

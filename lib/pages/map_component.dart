import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padcom/models/directions_model.dart';
import 'package:padcom/provider/directions_provider.dart';



class MapComponent extends StatefulWidget {
  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(14.6654872, 121.105623),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {
                if (_origin != null) _origin,
                if (_destination != null) _destination
              },
              polylines: {
                if (_info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: _info.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
              onLongPress: _addMarker,
            ),
            if (_info != null)
              Positioned(
                top: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: Text(
                    '${_info.totalDistance}, ${_info.totalDuration}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }
}

// class MapComponent extends StatefulWidget {
//   MapComponent({Key key, @required this.originCoordinates, this.destinationCoordinates}) : super(key: key);

//   final LatLng originCoordinates;
//   final LatLng destinationCoordinates;

//   @override
//   _MapComponentState createState() => _MapComponentState();
// }

// class _MapComponentState extends State<MapComponent> {
//   Completer<GoogleMapController> mapController = Completer();
//   Marker _origin;
//   Marker _destination;
//   Directions _info;
//   CameraPosition _initialCameraPosition;
//   final directionsProvider = DirectionsRepository();

//   @override
//   void initState() {
//     super.initState();

//     _initialCameraPosition = CameraPosition(
//       target: widget.originCoordinates,
//       zoom: 8,
//     );

//     _addMarkerAndDirections();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController.complete(controller);
//   }

//   void _addMarkerAndDirections() async {
//     setState(() {
//       _origin = Marker(
//         markerId: const MarkerId('origin'),
//         infoWindow: const InfoWindow(title: 'Origin'),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         position: widget.originCoordinates,
//       );

//       // if destination is null dont mark destination
//       if (widget.destinationCoordinates == null) {
//         return;
//       }

//       _destination = Marker(
//         markerId: const MarkerId('destination'),
//         infoWindow: const InfoWindow(title: 'Destination'),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         position: widget.destinationCoordinates,
//       );
//     });

//     // If destination is null, dont add directions
//     if (widget.destinationCoordinates == null) {
//       return;
//     }

//     final directions = await directionsProvider.getDirections(origin: _origin.position, destination: _destination.position);
//     setState(() => _info = directions);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 250,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Stack(alignment: Alignment.center, children: [
//           GoogleMap(
//             myLocationButtonEnabled: false,
//             // zoomControlsEnabled: false,
//             initialCameraPosition: _initialCameraPosition,
//             onMapCreated: _onMapCreated,
//             markers: {if (_origin != null) _origin, if (_destination != null) _destination},
//             polylines: {
//               if (_info != null)
//                 Polyline(
//                   polylineId: const PolylineId('overview_polyline'),
//                   color: Colors.red,
//                   width: 5,
//                   points: _info.polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList(),
//                 ),
//             },
//             onLongPress: _addMarkerAndDirections,
//           ),
//           if (_info != null)
//             Positioned(
//               top: 20.0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 6.0,
//                   horizontal: 12.0,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.yellowAccent,
//                   borderRadius: BorderRadius.circular(20.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0, 2),
//                       blurRadius: 6.0,
//                     )
//                   ],
//                 ),
//                 child: Text(
//                   '${_info.totalDistance}, ${_info.totalDuration}',
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//         ]));
//   }
// }
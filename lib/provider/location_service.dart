import 'dart:async';
import 'package:location/location.dart';
import 'package:padcom/models/user_location_model.dart';

class LocationService {
  // UserLocation _currenLocation;

  Location location = Location();

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              accuracy: locationData.accuracy,
            ));
          }
        });
      }
    });
  }

}

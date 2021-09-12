import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padcom/models/directions_model.dart';

class DirectionsRepository {
  DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();

  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final _googleAPIKey = "AIzaSyARx6fzZKHGQjlC6RsAyRUlPmWMuOyUfBM";

  final Dio _dio;
  
  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': _googleAPIKey,
      },
    );

    // Check if response is not successful
    if (response.statusCode != 200) {
      throw Exception("Atlas HTTP Error Occured, http response = ${response.statusCode}");
    }

    return Directions.fromMap(response.data);
  }
}
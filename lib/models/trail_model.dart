import 'package:cloud_firestore/cloud_firestore.dart';

class Trail {
  String id;
  GeoPoint origin;
  GeoPoint destination;
  String duration;
  String distance;
  DateTime createdAt;
  String difficulty;
  String title;
  String description;
  String userID;

  Trail({this.id, Map<String, dynamic> data}){
    this.origin = data['origin'] ?? null;
    this.destination = data['destination'] ?? null;
    this.title = data['title'] ?? '';
    this.description = data['description'] ?? '';
    this.difficulty = data['difficulty'] ?? '';
    this.userID = data['userID'] ?? '';
    this.duration = data['duration'] ?? '';
    this.distance = data['distance'] ?? '';
    if ((data['createdAt'] as Timestamp) != null) {
      this.createdAt = (data['createdAt'] as Timestamp).toDate();
    }
  }

  Map<String, dynamic> toJSON(){
    return {
      'origin': this.origin,
      'destination': this.destination,
      'createdAt': this.createdAt,
      'title': this.title,
      'description': this.description,
      'difficulty': this.difficulty,
      'userID': this.userID,
      'duration': this.duration,
      'distance': this.distance
    };
  }
}
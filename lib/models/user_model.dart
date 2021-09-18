import 'package:meta/meta.dart';

class User {
  String id;
  String email;
  String fname;
  String lname;
  String age;
  String city;
  DateTime birthDate;
  String gender;
  double weight;
  String photo;
  String bio;

  User({
    @required this.id,
    @required this.email,
    this.fname,
    this.lname,
    this.age,
    this.city,
    this.birthDate,
    this.gender,
    this.weight,
    this.photo,
    this.bio,
  });

  static final empty = User(id: '', email: '');

  User.fromDB({@required String id,@required Map<String, dynamic> data}){
    this.id = id;
    this.email = data['email'] ?? '';
    this.fname = data['fname'] ?? '';
    this.lname = data['lname'] ?? '';
    this.age = data['age'] ?? '';
    this.city = data['city'] ?? '';
    this.gender = data['gender'] ?? '';
    this.bio = data['bio'] ?? '';
    this.weight = (data['weight'] ?? 0.00).toDouble();
  }
}

import 'package:meta/meta.dart';

class User {
  String id;
  String email;

  User({
    @required this.id,
    @required this.email,
  });

  static final empty = User(id: '', email: '');
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

showSnackbar(context, {@required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(new SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        content: new Text(
          message,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ));
  }

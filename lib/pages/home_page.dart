import 'dart:math';

import 'package:flutter/material.dart';
import 'package:padcom/provider/user.dart';

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: max(MediaQuery.of(context).size.width / 1.5 + 450, MediaQuery.of(context).size.height),
            ),
            child: Text("Home Page")
          ),
        ),
      ),
    );
  }
}

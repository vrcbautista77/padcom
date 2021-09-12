import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:padcom/globals.dart';
import 'package:padcom/home.dart';
import 'package:padcom/models/user_model.dart';
import 'package:padcom/pages/edit_profile_page.dart';
import 'package:padcom/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    var user = FirebaseAuth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      // user is logged in
      await Future.delayed(const Duration(milliseconds: 5000), null);
      var checkUserDetails = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

      if(!checkUserDetails.exists){
        // go to edit profile
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(
          from: "login",
        )));
        return;
      }
      
      //set global user
      globalUser = User.fromDB(id: checkUserDetails.id, data: checkUserDetails.data());
                                            
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }else{
      // user not logged in
      await Future.delayed(const Duration(milliseconds: 5000), null);

      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xff9833CD),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(child: Container()),
                        Container(
                          height: 200.0,
                          child: Image.asset(
                            'assets/test_logo.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Container(width: 200, child: Image.asset('assets/test_logo.jpg')),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

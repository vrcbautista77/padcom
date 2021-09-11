import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:padcom/pages/edit_profile.dart';
import 'package:padcom/pages/home_page.dart';
import 'package:padcom/pages/login_page.dart';
import 'package:padcom/pages/profile.dart';

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
      home: HomePage(), //Profile(),
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
    User user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // user is logged in
      await Future.delayed(const Duration(milliseconds: 5000), null);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      return;
    }
    // user not logged in
    await Future.delayed(const Duration(milliseconds: 5000), null);

    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

    Future.delayed(const Duration(milliseconds: 1000), () {
      checkUser();
    });
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

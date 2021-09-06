import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padcom/pages/edit_profile_page.dart';
import 'package:padcom/pages/login_page.dart';
import 'package:padcom/pages/profile_page.dart';
import 'package:padcom/pages/profile_page.dart';

class HomePage extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentPageIndex = 0;
  String _title;
  bool _isLoading = false;

  final List<Widget> _pages = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    Profile()
  ];
  

  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;

      switch (index) {
        case 0:
          _title = "Home";
          break;
        case 1:
          _title = "Cities";
          break;
        case 2:
          _title = "Events";
          break;
        case 3:
          _title = "Profile";
          break;
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _title = "Home";
  }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(_title),
       centerTitle: true,
     ),
     drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: const Text('Activities'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: const Text('Favorite'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: _isLoading == false ?  Text('Logout') : Text('Logging out, please wait...'),
              onTap: () async {
                  setState(() {_isLoading = true;});
                  await FirebaseAuth.instance.signOut();
                  await Future.delayed(const Duration(milliseconds: 3000), null);
                  setState(() {_isLoading = false;});
                  // to login page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
     body: _pages[_currentPageIndex], // new
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped, // new
       currentIndex: _currentPageIndex, // new
        type: BottomNavigationBarType.fixed, // This is all you need!
       items: [
         new BottomNavigationBarItem(
           icon: Icon(Icons.home),
           label: 'Home',
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.location_city),
           label: 'Cities',
         ),
        new BottomNavigationBarItem(
           icon: Icon(Icons.event),
           label: 'Events',
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.person),
           label: 'Profile'
         )
       ],
     ),
   );
 }
}

class PlaceholderWidget extends StatelessWidget {
 final Color color;

 PlaceholderWidget(this.color);

 @override
 Widget build(BuildContext context) {
   return Container(
     color: color,
   );
 }
}
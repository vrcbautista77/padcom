import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padcom/models/global_data.dart';
import 'package:padcom/pages/community_page.dart';
import 'package:padcom/pages/edit_profile.dart';
import 'package:padcom/pages/friends_page.dart';
import 'package:padcom/pages/login_page.dart';
import 'package:padcom/pages/profile_page.dart';
import 'package:padcom/pages/trail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isLoading = false;

  final _pageController = PageController(initialPage: 0);

  void onTabTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          appBarTitle.value = 'Community';
          break;
        case 1:
          appBarTitle.value = 'Trails';
          break;
        case 2:
          appBarTitle.value = 'Friends';
          break;
        case 3:
          appBarTitle.value = 'Profile';
          break;
        default:
      }
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle.value),
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
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CommunityPage(),
          TrailPage(),
          FriensPage(),
          Profile(),
        ],
      ), // new

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 15,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.add_road), label: 'Trails'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.deepPurple,
        onTap: onTabTapped,
      ),
      // bottomSheet: Container(
      //   height: 50,
      //   padding: EdgeInsets.only(top: 5),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Column(
      //         children: [
      //           Icon(Icons.home),
      //           Text(
      //             'Community',
      //             style: TextStyle(
      //               color: AppColor.secondary,
      //               fontSize: 10,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           Icon(Icons.power_input_rounded),
      //           Text(
      //             'Trails',
      //             style: TextStyle(
      //               color: AppColor.secondary,
      //               fontSize: 10,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           Icon(Icons.people),
      //           Text(
      //             'Friends',
      //             style: TextStyle(
      //               color: AppColor.secondary,
      //               fontSize: 10,
      //             ),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           Icon(Icons.face_outlined),
      //           Text(
      //             'Profile',
      //             style: TextStyle(
      //               color: AppColor.secondary,
      //               fontSize: 10,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
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
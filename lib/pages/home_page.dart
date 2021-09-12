import 'dart:math';
import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/models/global_data.dart';
import 'package:padcom/pages/community_page.dart';
import 'package:padcom/pages/friends_page.dart';
import 'package:padcom/pages/profile.dart';
import 'package:padcom/pages/trail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;

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
        leading: SizedBox(),
        title: Text(appBarTitle.value),
        centerTitle: true,
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
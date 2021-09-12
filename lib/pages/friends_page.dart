import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';

class FriensPage extends StatefulWidget {
  const FriensPage({Key key}) : super(key: key);

  @override
  _FriensPageState createState() => _FriensPageState();
}

class _FriensPageState extends State<FriensPage> {
  TextEditingController _searchController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  void _changePage(int index) {
    setState(() {
      pageIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 1200), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height + 35),
        child: Column(
          children: [
            Expanded(child: Container()),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _changePage(0);
                    },
                    child: Container(
                      child: Text(
                        'All Friends',
                        style: TextStyle(
                          color: pageIndex == 0 ? AppColor.secondary : Colors.grey[500],
                          fontWeight: pageIndex == 0 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _changePage(1);
                    },
                    child: Container(
                      child: Text(
                        'Request',
                        style: TextStyle(
                          color: pageIndex == 1 ? AppColor.secondary : Colors.grey[500],
                          fontWeight: pageIndex == 1 ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300],
                ),
              )),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: TextField(
                    onChanged: (text) {},
                    controller: _searchController,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20.0,
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        allowImplicitScrolling: false,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                FriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                FriendTile(
                  lastMessage: '120 Friends',
                  name: 'Mary Manaloto',
                  onTap: () {},
                  profilePicture: null,
                ),
                FriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                FriendTile(
                  lastMessage: '120 Friends',
                  name: 'Mary Manaloto',
                  onTap: () {},
                  profilePicture: null,
                ),
                FriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                RequestFriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                RequestFriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                RequestFriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                RequestFriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                RequestFriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
                RequestFriendTile(
                  lastMessage: '200 Friends',
                  name: 'Jhon Albert Tuliao',
                  onTap: () {},
                  profilePicture: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  const FriendTile({
    Key key,
    this.name,
    this.lastMessage,
    this.profilePicture,
    this.onTap,
  }) : super(key: key);
  final String name;
  final String lastMessage;
  final String profilePicture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 25,
                  backgroundImage: profilePicture ?? AssetImage("assets/default_user.png"),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  lastMessage,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                tileColor: Colors.white,
                trailing: Container(
                  width: 110,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 25),
                        backgroundColor: AppColor.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Unfriend',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestFriendTile extends StatelessWidget {
  const RequestFriendTile({
    Key key,
    this.name,
    this.lastMessage,
    this.profilePicture,
    this.onTap,
  }) : super(key: key);
  final String name;
  final String lastMessage;
  final String profilePicture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 25,
                  backgroundImage: profilePicture ?? AssetImage("assets/default_user.png"),
                ),
                title: Text(
                  name,
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  lastMessage,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                tileColor: Colors.white,
                trailing: Container(
                  width: 110,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 25),
                              backgroundColor: AppColor.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 25),
                              backgroundColor: Colors.red.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

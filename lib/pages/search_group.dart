import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';

class SearchGroupPage extends StatefulWidget {
  SearchGroupPage({Key key}) : super(key: key);

  @override
  _SearchGroupPageState createState() => _SearchGroupPageState();
}

class _SearchGroupPageState extends State<SearchGroupPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GroupTile(
                subtitle: 'group made for something',
                onTap: () {},
                title: 'Bicom Group',
              ),
              GroupTile(
                subtitle: 'power !!!!',
                onTap: () {},
                title: 'Team Payaman',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  const GroupTile({
    Key key,
    this.title,
    this.subtitle,
    this.profilePicture,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String subtitle;
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
                // leading: CircleAvatar(
                //   backgroundColor: Colors.grey[200],
                //   radius: 25,
                //   backgroundImage: profilePicture ?? AssetImage("assets/default_user.png"),
                // ),
                title: Text(
                  title,
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitle,
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
                              'Request',
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
                              'Cancel',
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

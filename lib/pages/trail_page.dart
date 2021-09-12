import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/pages/add_route_modal.dart';
import 'package:padcom/pages/app_dropdown.dart';
import 'package:padcom/pages/trail_modal.dart';

class TrailPage extends StatefulWidget {
  TrailPage({Key key}) : super(key: key);

  @override
  _TrailPageState createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {
  TextEditingController _searchController = TextEditingController();
  String dropDownValue = 'Beginner';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
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
            AppDropdown(
              selectedValue: dropDownValue,
              listValue: [
                'Beginner',
                'Intermediate',
                'Expert',
              ],
              borderColor: AppColor.secondary,
              onChanged: (value) {
                setState(() {
                  dropDownValue = value;
                });
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TrailTile(
              onTap: () {
                showDialog(context: context, builder: (context) => TrailModal());
              },
              title: 'Rizal New Trail',
              subtitle: '4.2 out of 7',
              subtitle2: 'This is amazing trail. Sandy and Rocky feeling hehe',
              subtitle3: '200km',
            ),
            TrailTile(
              onTap: () {
                showDialog(context: context, builder: (context) => TrailModal());
              },
              title: 'Rizal New Trail',
              subtitle: '4.2 out of 7',
              subtitle2: 'This is amazing trail. Sandy and Rocky feeling hehe',
              subtitle3: '200km',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddRouteModal());
        },
        mini: true,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TrailTile extends StatelessWidget {
  const TrailTile({
    Key key,
    this.title,
    this.subtitle,
    this.onTap,
    this.subtitle2,
    this.subtitle3,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String subtitle2;
  final String subtitle3;
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle3,
                      style: TextStyle(
                        color: AppColor.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        subtitle2,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
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

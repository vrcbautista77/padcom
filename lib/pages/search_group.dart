import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padcom/pages/addgroup_modal.dart';
class SearchGroupPage extends StatefulWidget {
  SearchGroupPage({Key key}) : super(key: key);

  @override
  _SearchGroupPageState createState() => _SearchGroupPageState();
}

class _SearchGroupPageState extends State<SearchGroupPage> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  String searchValue = '';
  Stream<QuerySnapshot> trailsCollectionStream = FirebaseFirestore.instance.collection('groups').orderBy('created_at').snapshots();
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeInOut;
  double _fabHeight = 56.0;

   @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    _animationIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(begin: AppColor.secondary, end: AppColor.primary).animate(
        CurvedAnimation(
            parent: _animationController, curve: Interval(0.0, 1.0, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(CurvedAnimation(
        parent: _animationController, curve: Interval(0.0, 0.75, curve: Curves.linear)));
    Future.delayed(Duration(seconds: 2));
    super.initState();
  }

  Widget buttonAddGroup() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddGroupModal();
            },
          );
        },
        child: Icon(Icons.people),
        tooltip: 'Add group',
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: animate,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
        tooltip: 'Search Group',
      ),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else
      _animationController.reverse();
    isOpened = !isOpened;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value * 0.8, 0.0),
            child: buttonAddGroup(),
          ),
          // Transform(
          //   transform: Matrix4.translationValues(0.0, _translateButton.value * 1.7, 0.0),
          //   child: buttonAddGroup(),
          // ),
          // Transform(
          //   transform: Matrix4.translationValues(0.0, _translateButton.value * 0.85, 0.0),
          //   child: buttonSearchGroup(),
          // ),
          buttonToggle(),
        ],
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
                      onChanged: (text) {
                      setState(() {
                        searchValue = text;
                                            });
                    },
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
        body:  StreamBuilder<QuerySnapshot>(
        stream: trailsCollectionStream ,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        

           if(searchValue != '' && !data['title'].contains(searchValue)){
              return SizedBox();
            }

            return GroupTile(
              // onTap: () {
              //   showDialog(context: context, builder: (context) => TrailModal());
              // },
              title: data['title'] ?? '',
              subtitle:'admin' + ':' + '' + data ['user_name'] ?? '\n',
              subtitle1:data ['description'] ?? '',
            
             
            );
          }).toList(),
        );
        }
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
    this.subtitle1,
    this.profilePicture,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String subtitle1;
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                 subtitle: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        subtitle1,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      
                    ],
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
                          Container(
                            margin: EdgeInsets.only(left: 50),
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
                                'Join',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
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

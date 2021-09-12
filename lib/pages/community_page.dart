import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/pages/addgroup_modal.dart';
import 'package:padcom/pages/addpost_modal.dart';
import 'package:padcom/pages/expanded_texfield.dart';
import 'package:padcom/pages/post_item.dart';
import 'package:padcom/pages/search_group.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key key}) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buttonMenu() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buttonCreatePost() {
    return Container(
      child: FloatingActionButton(
        mini: true,
      onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddPostModal();
            },
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Create Post',
      ),
    );
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

  Widget buttonSearchGroup() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchGroupPage()));
        },
        child: Icon(Icons.search),
        tooltip: 'Search Group',
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
      appBar: null,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value * 2.55, 0.0),
            child: buttonCreatePost(),
          ),
          Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value * 1.7, 0.0),
            child: buttonAddGroup(),
          ),
          Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value * 0.85, 0.0),
            child: buttonSearchGroup(),
          ),
          buttonToggle(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreatePostWidget(),
            PostItem(),
            PostItem(),
            PostItem(),
          ],
        ),
      ),
    );
  }
}

class CreatePostWidget extends StatefulWidget {
  CreatePostWidget({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePostWidget> {
  TextEditingController _post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.secondary,
      // padding: EdgeInsets.fromLTRB(10, 10, 2, 10),
      // width: double.infinity,
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     CircleAvatar(
      //       backgroundColor: Colors.white,
      //       backgroundImage: AssetImage("assets/default_user.png"),
      //       radius: 25,
      //     ),
      //     Container(
      //       width: MediaQuery.of(context).size.width * 0.6,
      //       height: 70,
      //       child: ExpandedTextField(
      //         bgColor: Colors.grey[100],
      //         controller: _post,
      //         hintText: 'What\'s on your mind',
      //         textColor: Colors.black,
      //         style: TextStyle(fontSize: 12, color: Colors.black),
      //         styleHint: TextStyle(fontSize: 12, color: Colors.black),
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {},
      //       child: Image(
      //         image: AssetImage('assets/upload_media.png'),
      //         height: 30,
      //         width: 30,
      //         color: Colors.white,
      //       ),
      //     )
  //       ],
  //     ),
    );
  }
}

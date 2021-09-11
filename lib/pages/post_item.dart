import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';

class PostItem extends StatefulWidget {
  final BuildContext parentContext;
  final bool isFromThread;
  final Function threadItemAction;
  final int commentCount;
  PostItem({this.threadItemAction, this.isFromThread, this.commentCount, this.parentContext});
  @override
  State<StatefulWidget> createState() => _ThreadItem();
}

class _ThreadItem extends State<PostItem> {
  int _likeCount;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 2, 10),
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                      child: Container(
                          width: 48, height: 48, child: Image.asset('assets/default_user.png')),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Juan Dela Cruz',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold, color: AppColor.accent),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            'Post on January 2, 1997',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                                child: Icon(Icons.report),
                              ),
                              Text("Report"),
                            ],
                          ),
                        ),
                      ],
                      initialValue: 1,
                      onCanceled: () {
                        print("You have canceled the menu.");
                      },
                      onSelected: (value) {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bicycle Compitition',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 4, 10),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: 500,
                    height: 300,
                    child: Image(
                      image: AssetImage('assets/demo_post.jpg'),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 2,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            size: 18,
                            color: Colors.blue[900],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Like 1.5K',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.mode_comment, size: 18),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Comment 2.5k',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

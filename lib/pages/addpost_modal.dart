import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/pages/classic_textfield.dart';
import 'package:padcom/pages/expanded_button.dart';
import 'package:padcom/pages/expanded_texfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:padcom/globals.dart';
class AddPostModal extends StatefulWidget {
  const AddPostModal({Key key}) : super(key: key);



  @override
  _AddPostModalState createState() => _AddPostModalState();
}

class _AddPostModalState extends State<AddPostModal> {
  TextEditingController _postTitle = TextEditingController();
  TextEditingController _postBody = TextEditingController();
  // TextEditingController _postBody = TextEditingController();

   CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      scrollable: true,
      content: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Add Post'),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.red,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage("assets/default_user.png"),
                    radius: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 150,
                        child: ClassicTextField(
                          controller: _postTitle,
                          hintText: 'Create Post',
                          textAlign: TextAlign.left,
                          onChange: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 150,
                        height: 70,
                        child: ExpandedTextField(
                          bgColor: Colors.grey[100],
                          controller: _postBody,
                          hintText: 'Post Body',
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ExpandedButton(
                buttonColor: AppColor.secondary,
                borderRadius: 20,
                expanded: true,
                elevation: 1,
                title: 'Create',
                titleFontSize: 14,
                 onTap: () async {
                  if(_postTitle.text == '' || _postBody.text == ''){
                    _showSnackbar(context, message: "Please complete details");
                    return;
                  }
                  
                  await postCollection.add({
                    'title': _postTitle.text,
                    'body': _postBody.text,
                    'user_id': globalUser.id,
                    'user_name': globalUser.fname + " " + globalUser.lname,
                    'created_at': DateTime.now()
                  })
                  .then((value) {
                    Navigator.pop(context);
                    _showSnackbar(context, message: "Post added successfully");
                  })
                  .catchError((error) {
                      _showSnackbar(context, message: "Post denied");
                  });
                },
                titleAlignment: Alignment.center,
                titleColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
    
  }

      _showSnackbar(context, {@required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(new SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        content: new Text(
          message,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ));
  }
}

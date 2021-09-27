import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/pages/classic_textfield.dart';
import 'package:padcom/pages/expanded_button.dart';
import 'package:padcom/pages/expanded_texfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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
                    showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message: "Please complete required details to proceed",
                        ),
                    );
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
                    showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "Post added successfully!",
                        ),
                    );
                  })
                  .catchError((error) {
                    showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          message: "Error Occured, please try again",
                        ),
                    );
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
}

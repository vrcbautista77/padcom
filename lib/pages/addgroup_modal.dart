import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/pages/classic_textfield.dart';
import 'package:padcom/pages/expanded_button.dart';
import 'package:padcom/pages/expanded_texfield.dart';

class AddGroupModal extends StatefulWidget {
  const AddGroupModal({Key key}) : super(key: key);

  @override
  _AddGroupModalState createState() => _AddGroupModalState();
}

class _AddGroupModalState extends State<AddGroupModal> {
  TextEditingController _groupName = TextEditingController();
  TextEditingController _description = TextEditingController();
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
                  child: Text('Add Group'),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
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
                          controller: _groupName,
                          hintText: 'Group Name',
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
                          controller: _description,
                          hintText: 'Description',
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
                onTap: () {},
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

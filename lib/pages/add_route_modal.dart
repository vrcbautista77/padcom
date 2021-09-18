import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/pages/app_dropdown.dart';
import 'package:padcom/pages/classic_textfield.dart';
import 'package:padcom/pages/expanded_button.dart';
import 'package:padcom/pages/expanded_texfield.dart';
import 'package:padcom/pages/map_component.dart';

class AddRouteModal extends StatefulWidget {
  const AddRouteModal({Key key}) : super(key: key);

  @override
  _AddRouteModalState createState() => _AddRouteModalState();
}

class _AddRouteModalState extends State<AddRouteModal> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  String difficultyValue = 'Beginner';

  CollectionReference trailsCollection = FirebaseFirestore.instance.collection('trails');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      scrollable: true,
      content: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Add Route'),
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
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 22),
            //     child: RichText(
            //       text: TextSpan(children: [
            //         TextSpan(
            //           text: '4.2 out of 7 ',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 11,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         TextSpan(
            //           text: ' | ',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 14,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         TextSpan(
            //           text: '200km ',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 11,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ]),
            //     ),
            //   ),
            // ),
            Container(
              height: 230,
              width: 240,
              child: MapComponent(),
            ),
            SizedBox(
              height: 20,
            ),
            AppDropdown(
              selectedValue: difficultyValue,
              listValue: [
                'Beginner',
                'Intermediate',
                'Expert',
              ],
              borderColor: AppColor.secondary,
              onChanged: (value) {
                setState(() {
                  difficultyValue = value;
                });
              },
            ),
                        SizedBox(
              height: 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ClassicTextField(
                  controller: _title,
                  hintText: 'Title',
                  onChange: (value) {},
                  textAlign: TextAlign.left,
                  hintStyle: TextStyle(fontSize: 14),
                  style: TextStyle(fontSize: 14),
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: ExpandedTextField(
                controller: _description,
                bgColor: Colors.grey[100],
                hintText: 'description',
                styleHint: TextStyle(fontSize: 12),
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ExpandedButton(
                buttonColor: AppColor.secondary,
                borderRadius: 20,
                expanded: true,
                elevation: 1,
                title: 'Submit',
                titleFontSize: 14,
                onTap: () async {
                  if(_title.text == '' || _description.text == ''){
                    _showSnackbar(context, message: "Please complete details");
                    return;
                  }
                  
                  await trailsCollection.add({
                    'title': _title.text,
                    'description': _description.text,
                    'difficulty': difficultyValue,
                    'user_id': globalUser.id,
                    'created_at': DateTime.now()
                  })
                  .then((value) {
                    Navigator.pop(context);
                    _showSnackbar(context, message: "Route added success");
                  })
                  .catchError((error) {
                      _showSnackbar(context, message: "Route added error");
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

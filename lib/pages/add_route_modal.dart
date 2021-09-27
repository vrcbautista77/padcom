import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/models/trail_model.dart';
import 'package:padcom/pages/app_dropdown.dart';
import 'package:padcom/pages/classic_textfield.dart';
import 'package:padcom/pages/expanded_button.dart';
import 'package:padcom/pages/expanded_texfield.dart';
import 'package:padcom/pages/map_component.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

class AddRouteModal extends StatefulWidget {
  const AddRouteModal({Key key}) : super(key: key);

  @override
  _AddRouteModalState createState() => _AddRouteModalState();
}

class _AddRouteModalState extends State<AddRouteModal> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  String difficultyValue = 'Beginner';

  CollectionReference trailsCollection =
      FirebaseFirestore.instance.collection('trails');

  LatLng origin;
  LatLng destination;
  String duration;
  String distance;

  bool isLoading = false;

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
                  child: Text('Add Trail'),
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
              child: MapComponent(
                originCallback: (value) {
                  origin = value;
                },
                destinationCallback: (value) {
                  destination = value;
                },
                durationCallback: (value) {
                  duration = value;
                },
                distanceCallback: (value) {
                  distance = value;
                },
              ),
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
              child: isLoading == false
                  ? ExpandedButton(
                      buttonColor: AppColor.secondary,
                      borderRadius: 20,
                      expanded: true,
                      elevation: 1,
                      title: 'Confirm New Trail',
                      titleFontSize: 14,
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        if (_title.text == '' || _description.text == '') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message:
                                  "Please complete required details to proceed",
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        if (origin == null || destination == null) {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message:
                                  "Please pin origin/destination in the map",
                            ),
                          );
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        final newUID = Uuid().v4();
                        Trail newTrail = Trail(id: newUID, data: {});
                        newTrail.createdAt = DateTime.now();
                        newTrail.title = _title.text;
                        newTrail.description = _description.text;
                        newTrail.difficulty = difficultyValue;
                        newTrail.userID = globalUser.id;
                        newTrail.origin =
                            GeoPoint(origin.latitude, origin.longitude);
                        newTrail.destination = GeoPoint(
                            destination.latitude, destination.longitude);
                        newTrail.duration = duration;
                        newTrail.distance = distance;

                        await trailsCollection
                            .add(newTrail.toJSON())
                            .then((value) {
                          Navigator.pop(context);
                          isLoading = false;
                          showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                              message: "Trail added successfully!",
                            ),
                          );
                        }).catchError((error) {
                          setState(() {
                            isLoading = false;
                          });

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
                    )
                  : CircularProgressIndicator(),
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

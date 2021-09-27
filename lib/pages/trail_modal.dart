import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/models/trail_model.dart';
import 'package:padcom/pages/map_component.dart';
import 'package:padcom/pages/map_view_component.dart';

class TrailModal extends StatefulWidget {
  final Trail trail;

  const TrailModal({Key key, @required this.trail}) : super(key: key);

  @override
  _TrailModalState createState() => _TrailModalState();
}

class _TrailModalState extends State<TrailModal> {

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
                  child: Text(widget.trail.title),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.trail.distance,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' | ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.trail.duration,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Container(
              height: 230,
              width: 240,
              child: MapViewComponent(
                origin: LatLng(widget.trail.origin.latitude, widget.trail.origin.longitude),
                destination: LatLng(widget.trail.destination.latitude, widget.trail.destination.longitude),
              )
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(widget.trail.description,
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Name',
            //             style: TextStyle(
            //               color: AppColor.primary,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Text(
            //             'Best Record',
            //             style: TextStyle(
            //               color: AppColor.primary,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 5,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             '1.) John Smith',
            //             style: TextStyle(
            //               fontSize: 12,
            //               fontWeight: FontWeight.normal,
            //             ),
            //           ),
            //           Text(
            //             '20 secs',
            //             style: TextStyle(
            //               fontSize: 12,
            //               fontWeight: FontWeight.normal,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 5,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             '2.) Merry Faith',
            //             style: TextStyle(
            //               fontSize: 12,
            //               fontWeight: FontWeight.normal,
            //             ),
            //           ),
            //           Text(
            //             '1.5 mins',
            //             style: TextStyle(
            //               fontSize: 12,
            //               fontWeight: FontWeight.normal,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

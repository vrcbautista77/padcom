import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/pages/edit_profile_page.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blueGrey[700],
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //       colors: [
              //         AppColor.accent,
              //         AppColor.secondary,
              //         AppColor.primary,
              //       ],
              //       begin: const FractionalOffset(0.0, 1.0),
              //       end: const FractionalOffset(1.0, 0.0),
              //       // stops:[0.8, 0.3, 0.1,],
              //       tileMode: TileMode.clamp),
              // ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/default_user.png"),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        globalUser.fname + " " + globalUser.lname,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        onPressed: () {
                          print('Edit');
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => EditProfile()));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColor.accent,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  Text(
                    globalUser.email,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: globalUser.age + " ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'years old',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: ' | ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: globalUser.weight.toString() + ' ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: ' | ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                 
                      TextSpan(
                        text: globalUser.gender + " ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image(
                                image: AssetImage('assets/bicycle.png'),
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '200 ',
                                    style: TextStyle(
                                        color: AppColor.secondary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: 'KM',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal))
                                ]),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage('assets/activity.png'),
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '4 ',
                                    style: TextStyle(
                                        color: AppColor.secondary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: 'Activities',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal))
                                ]),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage('assets/friends.png'),
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: '1.5K ',
                                    style: TextStyle(
                                        color: AppColor.secondary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                      text: 'Friends',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal))
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top:20, bottom: 0, left: 20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio:',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    globalUser.bio,
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
              
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/pages/edit_profile.dart';

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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColor.accent,
                      AppColor.secondary,
                      AppColor.primary,
                    ],
                    begin: const FractionalOffset(0.0, 1.0),
                    end: const FractionalOffset(1.0, 0.0),
                    // stops:[0.8, 0.3, 0.1,],
                    tileMode: TileMode.clamp),
              ),
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
                        'Jhon Albert Tuliao'.toUpperCase(),
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
                    'tuliaojajan@gmail.com',
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
                        text: '22 ',
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
                        text: '40 ',
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
                        text: '179.2 ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'cm',
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Background:',
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
                    'My name is Alice and I\'m a developer Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: AppColor.secondary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Add Friend',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
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

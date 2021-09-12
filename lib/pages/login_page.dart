import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter/material.dart';
import 'package:padcom/globals.dart';
import 'package:padcom/models/user_model.dart';
import 'package:padcom/pages/edit_profile_page.dart';
import 'package:padcom/pages/home_page.dart';
import 'package:padcom/provider/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final userProvider = UserProvider();

  bool isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: null,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: max(MediaQuery.of(context).size.width / 1.5 + 450, MediaQuery.of(context).size.height),
                ),
                child: Stack(
                  children: [
                    Container(
                      child: SafeArea(
                        child: Container(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  width: 200,
                                  height: 200,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/test_logo.jpg'),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                              ),

                              //TEST
                              Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Log In',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Enter your login credentials',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey,
                              //         borderRadius: BorderRadius.circular(10),
                              //       ),
                              //       child: TextFormField(
                              //         autocorrect: false,
                              //         controller: _emailController,
                              //         keyboardType: TextInputType.name,
                              //         textCapitalization: TextCapitalization.words,
                              //         decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           focusedBorder: InputBorder.none,
                              //           enabledBorder: InputBorder.none,
                              //           errorBorder: InputBorder.none,
                              //           disabledBorder: InputBorder.none,
                              //           hintText: "Email",
                              //           contentPadding: EdgeInsets.only(left: 10, right: 10),
                              //         ),
                              //       ),
                              //     ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: isLoading == false
                                    ? Column(
                                  children: [
                                    // TextButton(
                                    //     // onPressed: onTap,
                                    //     style: TextButton.styleFrom(
                                    //       padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(30),
                                    //       ),
                                    //       backgroundColor: Colors.blue,
                                    //     ),  
                                    //     child: Align(
                                    //       child: Text(
                                    //         "Log in",
                                    //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15 , color: Colors.white),
                                    //       ),
                                    //     ),
                                    //   ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                        onPressed: () async{
                                          setState(() {
                                            isLoading = true;
                                          });
                                          try{
                                            await userProvider.logInWithFacebook();
                                            var uid = FirebaseUser.FirebaseAuth.instance.currentUser.uid;
                                            var checkUserDetails = await FirebaseFirestore.instance.collection("users").doc(uid).get();

                                            if(!checkUserDetails.exists){
                                              // go to edit profile
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(from: "login",)));
                                            }
                                            
                                            //set global user variable
                                            globalUser = User.fromDB(id: checkUserDetails.id, data: checkUserDetails.data());
                                          } catch(err){
                                            setState(() {
                                              isLoading = false;
                                            });
                                            return;
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });

                                          // to home
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),  
                                        child: Align(
                                          child: Text(
                                            "LOG IN WITH FACEBOOK",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15 , color: Colors.white),
                                          ),
                                        ) ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await userProvider.logInWithGoogle();
                                          Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()),);

                                          setState(() {
                                            isLoading = false;
                                          });                                          
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          backgroundColor: Colors.white70,
                                        ),  
                                        child: Align(
                                          child: Text(
                                            'LOG IN WITH GOOGLE',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15 , color: Color(0xFFCB4B3B)),
                                          ),
                                        ),
                                      ) 
                                    // AtlasButton(
                                    //   onTap: () => _onPressedLoginButton(context, type: LoginTypes.Google),
                                    //   expanded: true,
                                    //   borderRadius: 30,
                                    //   buttonColor: Colors.white70,
                                    //   title: 'LOG IN WITH GOOGLE',
                                    //   titleFontSize: 15,
                                    //   titleColor: Color(0xFFCB4B3B),
                                    //   titleAlignment: Alignment.center,
                                    // ),
                                  ],
                                ) : CircularProgressIndicator(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}

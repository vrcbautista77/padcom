import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/global_functions.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/models/user_model.dart';
import 'package:padcom/pages/edit_profile_page.dart';
import 'package:padcom/pages/home_page.dart';
import 'package:padcom/pages/register_page.dart';
import 'package:padcom/provider/user.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final userProvider = UserProvider();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        
      },
      
      child: Scaffold(
         backgroundColor: Colors.blueGrey.shade900,
        appBar: null,
        body: SafeArea(
          child: SingleChildScrollView(
            
            physics: ClampingScrollPhysics(),
            child: Container(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          width: 150,
                          height: 150,
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Logo.png'),
                          ),
                        ),
                      ),

                        SizedBox(
                        height: 20,
                      ),

                      // Container(
                      //   height: 10,
                      // ),
                      // Container(
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: (Text('LOGIN',
                      //     style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 24.0))),
                      //   )
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     'Enter your login credentials',
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        height: 50.0,
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEFEFEF),
                            hintText: "Enter Valid Email",
                            contentPadding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 10.0,
                                right: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Color(0xFFEFEFEF))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    BorderSide(color: Color(0xFFEFEFEF))),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter some text';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      PasswordTextField(
                          passwordController: _passwordController),
                         
                       SizedBox(
                        height: 20,
                      ),
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()));
                               
                                  },
                                  child: Text(" Sign Up",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  " Now",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                      SizedBox(
                        height: 50,
                      ),

                          const Divider(
                          height: 20,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.white,
                        ),

                      SizedBox(
                        height: 20,
                      ),
                  
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: isLoading == false
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      
                                      if(_emailController.text == "" || _passwordController.text == ""){
                                           setState(() {
                                        isLoading = false;
                                      });
                                        showTopSnackBar(
                                            context,
                                            CustomSnackBar.info(
                                              message: "Please input your credentials",
                                            ),
                                        );
                                        return;
                                      }

                                      try {
                                        await userProvider.loginWithEmailAndPassword(
                                          email: _emailController.text, password: _passwordController.text);
                                        var uid = FirebaseUser.FirebaseAuth
                                            .instance.currentUser.uid;
                                        var checkUserDetails =
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(uid)
                                                .get();

                                        if (!checkUserDetails.exists) {
                                          // go to edit profile
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfile(
                                                        from: "login",
                                                      )));
                                        }

                                        //set global user variable
                                        globalUser = User.fromDB(
                                            id: checkUserDetails.id,
                                            data: checkUserDetails.data());
                                      } catch (err) {
                                        showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message: "Error Occured, please try again",
                                            ),
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                        return;
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });

                                      // to home
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 25.0),
                                      width: 250.0,
                                      height: 45.0,
                                      decoration: new BoxDecoration(
                                        // color: colorPrimary,
                                        borderRadius:
                                            new BorderRadius.circular(50.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[900],
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          )
                                        ],
                                        gradient: new LinearGradient(
                                            colors: [
                                              AppColor.accent,
                                              AppColor.primary,
                                              AppColor.secondary,

                                            ],
                                            begin: const FractionalOffset(
                                                0.0, 1.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            // stops:[0.8, 0.3, 0.1,],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: (Text('Log-in',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        await userProvider.logInWithFacebook();
                                        var uid = FirebaseUser.FirebaseAuth
                                            .instance.currentUser.uid;
                                        var checkUserDetails =
                                            await FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(uid)
                                                .get();

                                        if (!checkUserDetails.exists) {
                                          // go to edit profile
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfile(
                                                        from: "login",
                                                      )));
                                          return;
                                        }

                                        //set global user variable
                                        globalUser = User.fromDB(
                                            id: checkUserDetails.id,
                                            data: checkUserDetails.data());
                                      } catch (err) {
                                        showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message: "Error Occured, please try again",
                                            ),
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                        return;
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });

                                      // to home
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10.0, bottom: 5.0),
                                      width: 250.0,
                                      height: 45.0,
                                      decoration: new BoxDecoration(
                                        color: Color(0xff3b5998),
                                        borderRadius:
                                            new BorderRadius.circular(50.0),
                                        boxShadow: [
                                          BoxShadow(
                                             color: Colors.grey[900],
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image(
                                              image: AssetImage(
                                                  "assets/fb_logo.png"),
                                              height: 20.0),
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: (Text(
                                                'Continue with Facebook',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await userProvider.logInWithGoogle();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );

                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      width: 250.0,
                                      height: 45.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            new BorderRadius.circular(50.0),
                                        boxShadow: [
                                          BoxShadow(
                                             color: Colors.grey[900],
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image(
                                              image: AssetImage(
                                                  "assets/google_logo.png"),
                                              height: 20.0),
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: (Text('Log in with Google',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                margin: EdgeInsets.all(40),
                                child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key key,
    @required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisible;
  bool isDisposed = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: <Widget>[
        
        Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 50.0,
          width: MediaQuery.of(context).size.width - 100,
          child: TextFormField(
            controller: widget.passwordController,
            obscureText: !passwordVisible,
            decoration: new InputDecoration(
              filled: true,
              fillColor: Color(0xFFEFEFEF),
              hintText: "Password",
              contentPadding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Color(0xFFEFEFEF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Color(0xFFEFEFEF))),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.only(top: 10.0, right: 5.0),
            width: 40.0,
            height: 45.0,
            child: IconButton(
              iconSize: 25,
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                size: 20,
              ),
              onPressed: () {
                if (!isDisposed) {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                }
              },
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

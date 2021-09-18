import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter/material.dart';
import 'package:padcom/global_functions.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/models/user_model.dart';
import 'package:padcom/pages/edit_profile_page.dart';
import 'package:padcom/pages/home_page.dart';
import 'package:padcom/pages/register_page.dart';
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
                            image: AssetImage('assets/test_logo.jpg'),
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
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
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: new InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEFEFEF),
                            hintText: "Email",
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
                      PasswordTextField(
                          passwordController: _passwordController),
                      SizedBox(
                        height: 10,
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
                                        showSnackbar(context, message: "Please input your credentials");
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
                                        showSnackbar(context,
                                            message: err.toString());
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
                                            color: Colors.grey[400],
                                            blurRadius: 2.0,
                                            spreadRadius: 0.0,
                                            offset: Offset(2.0, 2.0),
                                          )
                                        ],
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.orange,
                                              Colors.orangeAccent,
                                              Colors.deepOrange,
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
                                        child: (Text('LOG IN',
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
                                        }

                                        //set global user variable
                                        globalUser = User.fromDB(
                                            id: checkUserDetails.id,
                                            data: checkUserDetails.data());
                                      } catch (err) {
                                        showSnackbar(context,
                                            message: err.toString());
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
                                            color: Colors.grey,
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
                                            color: Colors.grey[350],
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
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.black),
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
          height: 40.0,
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
            height: 43.0,
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

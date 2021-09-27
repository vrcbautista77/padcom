import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/global_functions.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/models/user_model.dart';
import 'package:padcom/pages/edit_profile_page.dart';
import 'package:padcom/provider/user.dart';

import 'expanded_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userProvider = UserProvider();

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isHidePassword = true;
  bool isHideConfirmPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
      // appBar: AppBar(
      //   title: Text('Register Account'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 78.0),
                          width: 150,
                          height: 150,
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/Logo.png'),
                          ),
                        ),
                      ),
            // Stack(
            //   children: [
            //     Container(
            //       height: 140,
            //       width: double.infinity,
            //     ),
            //     Container(
            //       height: 100,
            //       width: double.infinity,
            //       padding: EdgeInsets.all(50),
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(
            //           colors: [
            //             AppColor.accent,
            //             AppColor.secondary,
            //             AppColor.primary,
            //           ],
            //           begin: const FractionalOffset(0.0, 1.0),
            //           end: const FractionalOffset(1.0, 0.0),
            //           // stops:[0.8, 0.3, 0.1,],
            //           //tileMode: TileMode.clamp,
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       bottom: 10,
            //       left: MediaQuery.of(context).size.width / 2 - 40,
            //       child: Center(
            //           child: Container(
            //         height: 80,
            //         width: 80,
            //         padding: EdgeInsets.all(5),
            //         decoration: BoxDecoration(
            //           color: Colors.transparent,
            //           border: Border.all(
            //             color: AppColor.accent,
            //             width: 1.5,
            //           ),
            //           borderRadius: BorderRadius.circular(100),
            //         ),
            //         child: ClipOval(
            //           child: Container(
            //             height: 80,
            //             width: 80,
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //             ),
            //             child: Stack(
            //               children: [
            //                 Image(
            //                   image: AssetImage("assets/Logo.png"),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       )),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, bottom: 10),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       'Name',
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.bold,
            //         color: AppColor.secondary,
            //       ),
            //     ),
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width / 2 - 30,
            //       child: TextFormField(
            //         controller: fNameController,
            //         textCapitalization: TextCapitalization.words,
            //         enableInteractiveSelection: false,
            //         decoration: new InputDecoration(
            //           filled: true,
            //           fillColor: Color(0xFFEFEFEF),
            //           hintText: 'First Name',
            //           counterText: "",
            //           labelText: 'First Name',
            //           labelStyle: TextStyle(
            //             height: 1,
            //           ),
            //           contentPadding: EdgeInsets.all(15),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5.0),
            //             borderSide: BorderSide(
            //               color: AppColor.primary,
            //             ),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5.0),
            //             borderSide: BorderSide(
            //               color: AppColor.secondary,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       width: MediaQuery.of(context).size.width / 2 - 30,
            //       child: TextFormField(
            //         controller: lNameController,
            //         textCapitalization: TextCapitalization.words,
            //         enableInteractiveSelection: false,
            //         decoration: new InputDecoration(
            //           filled: true,
            //           fillColor: Color(0xFFEFEFEF),
            //           hintText: 'Last Name',
            //           counterText: "",
            //           labelText: 'Last Name',
            //           labelStyle: TextStyle(
            //             height: 1,
            //           ),
            //           contentPadding: EdgeInsets.all(15),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5.0),
            //             borderSide: BorderSide(color: Colors.amber),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(5.0),
            //             borderSide: BorderSide(color: Colors.black),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 50,
            ),

            Padding(
                padding: const EdgeInsets.only(left: 48, bottom: 10),
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
              width: MediaQuery.of(context).size.width - 90,
              height: 50.0,
              child: TextFormField(
                controller: emailController,
                textCapitalization: TextCapitalization.words,
                enableInteractiveSelection: false,
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFEFEFEF),
                  hintText: 'Email',
                  counterText: "",
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    height: 1,
                  ),
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
               padding: const EdgeInsets.only(left: 48, bottom: 10),
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
            Stack(
              children: [
                Container(
                 width: MediaQuery.of(context).size.width - 90,
                  height: 50.0,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: isHidePassword,
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: false,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                      hintText: 'Password',
                      counterText: "",
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        height: 1,
                      ),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 1,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidePassword = !isHidePassword;
                        });
                      },
                      icon: Icon(isHidePassword
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
               width: MediaQuery.of(context).size.width - 90,
                height: 50.0,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: isHideConfirmPassword,
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: false,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                      hintText: 'Confirm Password',
                      counterText: "",
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        height: 1,
                      ),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.amber),  
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 1,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isHideConfirmPassword = !isHideConfirmPassword;
                        });
                      },
                      icon: Icon(isHideConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility)),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            isLoading == false ?
            Container(
              height: 50.0,
              width: 350.0,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ExpandedButton(
                buttonColor: AppColor.secondary,
                borderRadius: 20,
                expanded: true,
                elevation: 1,
                title: 'Register',
                titleFontSize: 14,
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });

                  if (emailController.text == "" ||
                      passwordController.text == "" ||
                      confirmPasswordController.text == "" ||
                      passwordController.text.length <= 6) {
                    setState(() {
                      isLoading = false;
                    });
                    showSnackbar(context,
                        message: "Please fill up all incomplete fields");
                    return;
                  }

                  if(passwordController.text != confirmPasswordController.text){
                    setState(() {
                      isLoading = false;
                    });
                    showSnackbar(context,
                        message: "Password do not match");
                    return;
                  }

                  // try {
                    var checkEmail =  await FirebaseFirestore.instance.collection("users").where('email', isEqualTo: emailController.text).get();
                    if(checkEmail.docs.length > 0){
                      setState(() {
                        isLoading = false;
                      });
                      showSnackbar(context,
                          message: "Email is already taken");
                      return;
                    }

                    await userProvider.normalSignUp(
                        email: emailController.text,
                        password: passwordController.text);

                    var uid =
                        FirebaseUser.FirebaseAuth.instance.currentUser.uid;
                    var checkUserDetails = await FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .get();

                    if (!checkUserDetails.exists) {
                      // go to edit profile
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    from: "login",
                                  )));
                      return;
                    }

                    //set global user variable
                    globalUser = User.fromDB(
                        id: checkUserDetails.id, data: checkUserDetails.data());
                  // } catch (err) {
                  //   showSnackbar(context, message: err.toString());
                  //   setState(() {
                  //     isLoading = false;
                  //   });
                  // }
                },
                titleAlignment: Alignment.center,
                titleColor: Colors.white,
              ),
            ) : CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

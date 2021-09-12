import 'package:flutter/material.dart';
import 'package:padcom/constants/color.dart';

import 'expanded_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isHidePassword = true;
  bool isHideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.all(50),
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
                      //tileMode: TileMode.clamp,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  child: Center(
                      child: Container(
                    height: 80,
                    width: 80,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: AppColor.accent,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipOval(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Image(
                              image: AssetImage("assets/default_user.png"),
                            ),
                            Center(child: Icon(Icons.camera))
                          ],
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: false,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                      hintText: 'First Name',
                      counterText: "",
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        height: 1,
                      ),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColor.primary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: false,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                      hintText: 'Last Name',
                      counterText: "",
                      labelText: 'Last Name',
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
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: TextFormField(
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TextFormField(
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
                        borderSide: BorderSide(color: Colors.black),
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
                      icon: Icon(isHidePassword ? Icons.visibility_off : Icons.visibility)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondary,
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TextFormField(
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
                        borderSide: BorderSide(color: Colors.black),
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
                      icon: Icon(isHideConfirmPassword ? Icons.visibility_off : Icons.visibility)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
                onTap: () {},
                titleAlignment: Alignment.center,
                titleColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

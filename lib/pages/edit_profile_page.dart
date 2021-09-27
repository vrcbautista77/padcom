import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:padcom/global_functions.dart';
import 'package:padcom/global_variables.dart';
import 'package:padcom/models/user_model.dart';
import 'package:padcom/pages/home_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key, this.from}) : super(key: key);

  final String from;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  DateTime birthDate;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.from == "login") {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: widget.from == "login" ? SizedBox() : null,
          title: Text('Edit Profile'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                if (_firstNameController.text == "" ||
                    _lastNameController.text == "" ||
                    _ageController.text == "" ||
                    _cityController.text == "" ||
                    _bioController.text == "" ||
                    _genderController.text == "" ||
                    _weightController.text == "" ||
                    _birthdayController.text == "") {
                    showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message: "Please complete required details to proceed",
                        ),
                    );

                  setState(() {
                    _isLoading = false;
                  });
                  return;
                }

                try {
                  var currentUser =
                      FirebaseAuth.FirebaseAuth.instance.currentUser;
                  final User newUser = User(
                      id: currentUser.uid,
                      email: currentUser.email,
                      fname: _firstNameController.text,
                      lname: _lastNameController.text,
                      gender: _genderController.text,
                      age: _ageController.text,
                      bio: _bioController.text,
                      birthDate: birthDate,
                      city: _cityController.text,
                      weight: double.parse(_weightController.text),
                      photo: currentUser.photoURL);

                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.uid)
                      .set({
                        'email': currentUser.email,
                        'fname': _firstNameController.text,
                        'lname': _lastNameController.text,
                        'age': _ageController.text,
                        'city': _cityController.text,
                        'bio': _bioController.text,
                        'gender': _genderController.text,
                        'weight': double.parse(_weightController.text),
                        'birthdate': _birthdayController.text,
                        'status': "pending",
                        'photo': currentUser.photoURL
                      })
                      .then((value) => print("User Added"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));

                  setState(() {
                    _isLoading = false;
                  });

                  // set global user
                  globalUser = newUser;

                  showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: "Register successfully!",
                      ),
                  );

                  await Future.delayed(Duration(seconds: 3));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } catch (error) {
                  showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          message: "Error Occured, please try again",
                        ),
                    );
                  setState(() {
                    _isLoading = false;
                  });
                  return;
                }
              },
              child: Text(
                _isLoading == false ? 'Save' : "Saving...",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/test_logo.jpg"),
                    radius: 65,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: TextFormField(
                        controller: _firstNameController,
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
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: TextFormField(
                        controller: _lastNameController,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: TextFormField(
                        controller: _ageController,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: false,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          hintText: 'Age',
                          counterText: "",
                          labelText: 'Age',
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
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: TextFormField(
                        controller: _cityController,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: false,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          hintText: 'City',
                          counterText: "",
                          labelText: 'City',
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
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 3, 5),
                      maxTime: DateTime(2019, 6, 7),
                      onChanged: (date) {
                        print('change $date');
                      },
                      onConfirm: (date) {
                        _birthdayController.text = date.year.toString() +
                            '/' +
                            date.month.toString() +
                            '/' +
                            date.day.toString();

                        birthDate = date;
                      },
                      currentTime: DateTime.now(),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextFormField(
                      controller: _birthdayController,
                      enabled: false,
                      textCapitalization: TextCapitalization.words,
                      enableInteractiveSelection: false,
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        hintText: 'Birthday',
                        counterText: "",
                        labelText: 'Birthday',
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TextFormField(
                    controller: _bioController,
                    textCapitalization: TextCapitalization.words,
                    enableInteractiveSelection: false,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                      hintText: 'Bio',
                      counterText: "",
                      labelText: 'Bio',
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
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[300],
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'ATHLETE INFORMATION',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Use to calculate calories, power nad more',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: TextFormField(
                        controller: _genderController,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: false,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          hintText: 'Gender',
                          counterText: '',
                          labelText: 'Gender',
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
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: TextFormField(
                        controller: _weightController,
                        textCapitalization: TextCapitalization.words,
                        enableInteractiveSelection: false,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          hintText: 'Weight',
                          counterText: "",
                          labelText: 'Weight',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

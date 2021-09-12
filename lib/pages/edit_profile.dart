import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:padcom/constants/color.dart';
import 'package:padcom/pages/register_page.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Text(
              'Done',
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
                      controller: _firstNameController,
                      textCapitalization: TextCapitalization.words,
                      enableInteractiveSelection: false,
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        hintText: 'Gender',
                        counterText: "",
                        labelText: 'Gender',
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
                      controller: _lastNameController,
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, bottom: 10),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Email',
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: AppColor.secondary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextFormField(
                  controller: _bioController,
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, bottom: 10),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Bio',
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: AppColor.secondary,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: TextFormField(
                  controller: _bioController,
                  textCapitalization: TextCapitalization.words,
                  enableInteractiveSelection: false,
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFEFEFEF),
                    hintText: 'Biography',
                    counterText: "",
                    labelText: 'Biography',
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
                         color: AppColor.secondary,
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
                    width: MediaQuery.of(context).size.width / 3 - 30,
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
                    width: MediaQuery.of(context).size.width / 3 - 30,
                    child: TextFormField(
                      controller: _cityController,
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
                  Container(
                    width: MediaQuery.of(context).size.width / 3 - 30,
                    child: TextFormField(
                      controller: _cityController,
                      textCapitalization: TextCapitalization.words,
                      enableInteractiveSelection: false,
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        hintText: 'Height',
                        counterText: "",
                        labelText: 'Height',
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
              // GestureDetector(
              //   onTap: () {
              //     DatePicker.showDatePicker(
              //       context,
              //       showTitleActions: true,
              //       minTime: DateTime(2018, 3, 5),
              //       maxTime: DateTime(2019, 6, 7),
              //       onChanged: (date) {
              //         print('change $date');
              //       },
              //       onConfirm: (date) {
              //         _birthdayController.text = date.year.toString() +
              //             '/' +
              //             date.month.toString() +
              //             '/' +
              //             date.day.toString();
              //       },
              //       currentTime: DateTime.now(),
              //     );
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width - 40,
              //     child: TextFormField(
              //       controller: _birthdayController,
              //       enabled: false,
              //       textCapitalization: TextCapitalization.words,
              //       enableInteractiveSelection: false,
              //       decoration: new InputDecoration(
              //         filled: true,
              //         fillColor: Color(0xFFEFEFEF),
              //         hintText: 'Birthday',
              //         counterText: "",
              //         labelText: 'Birthday',
              //         labelStyle: TextStyle(
              //           height: 1,
              //         ),
              //         contentPadding: EdgeInsets.all(15),
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5.0),
              //           borderSide: BorderSide(color: Colors.amber),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5.0),
              //           borderSide: BorderSide(color: Colors.black),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   width: MediaQuery.of(context).size.width - 40,
              //   child: TextFormField(
              //     controller: _bioController,
              //     textCapitalization: TextCapitalization.words,
              //     enableInteractiveSelection: false,
              //     decoration: new InputDecoration(
              //       filled: true,
              //       fillColor: Color(0xFFEFEFEF),
              //       hintText: 'Bio',
              //       counterText: "",
              //       labelText: 'Bio',
              //       labelStyle: TextStyle(
              //         height: 1,
              //       ),
              //       contentPadding: EdgeInsets.all(15),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //         borderSide: BorderSide(color: Colors.amber),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //         borderSide: BorderSide(color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   padding: EdgeInsets.all(10),
              //   color: Colors.grey[300],
              //   width: double.infinity,
              //   child: Column(
              //     children: [
              //       Text(
              //         'ATHLETE INFORMATION',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       Text(
              //         'Use to calculate calories, power nad more',
              //         style: TextStyle(
              //           color: Colors.blue.shade700,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       width: MediaQuery.of(context).size.width / 2 - 30,
              //       child: TextFormField(
              //         controller: _genderController,
              //         textCapitalization: TextCapitalization.words,
              //         enableInteractiveSelection: false,
              //         decoration: new InputDecoration(
              //           filled: true,
              //           fillColor: Color(0xFFEFEFEF),
              //           hintText: 'Gender',
              //           counterText: '',
              //           labelText: 'Gender',
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
              //     Container(
              //       width: MediaQuery.of(context).size.width / 2 - 30,
              //       child: TextFormField(
              //         controller: _weightController,
              //         textCapitalization: TextCapitalization.words,
              //         enableInteractiveSelection: false,
              //         decoration: new InputDecoration(
              //           filled: true,
              //           fillColor: Color(0xFFEFEFEF),
              //           hintText: 'Weight',
              //           counterText: "",
              //           labelText: 'Weight',
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

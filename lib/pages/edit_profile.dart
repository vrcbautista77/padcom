import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
            onPressed: () {},
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
                    minTime: DateTime(2018, 3, 5),
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
    );
  }
}

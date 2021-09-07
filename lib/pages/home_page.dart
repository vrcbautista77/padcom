import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _chosenValue = 'Android';  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
  //elevation: 5,
  style: TextStyle(color: Colors.white),
  iconEnabledColor:Colors.black,
  items: <String>[
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
  hint:Text(
    "Please choose a langauage",
    style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  ),
  onChanged: (String value) {
    setState(() {
      _chosenValue = value;
    });
  },
),

              Text("TEST"),
              Image(
                 width: 100.00,
                fit: BoxFit.fill,
                image: AssetImage('assets/test_logo.jpg'),
              )
            ],
          ),
        ),
        Card(
          child: Text("Card 2"),
        ),
        Card(
          child: Text("Card 3"),
        )
      ],
    );
  }
}

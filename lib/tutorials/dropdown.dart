import 'package:flutter/material.dart';
/*
getDropDownMenuItems() =>  <DropdownMenuItem>[
  DropdownMenuItem<String>(
    value: "Ludhiana",
    child: Text("Ludhiana"),
  ),
  DropdownMenuItem<String>(
    value: "Chandigarh",
    child: Text("Chandigarh"),
  ),
  DropdownMenuItem<String>(
    value: "Delhi",
    child: Text("Delhi"),
  ),
  DropdownMenuItem<String>(
    value: "Bangalore",
    child: Text("Bangalore"),
  ),
  DropdownMenuItem<String>(
    value: "Hyderabad",
    child: Text("Hyderabad"),
  )
];
*/

// map the List to some other object :)
getDropDownMenuItems(){
  return ["Ludhiana", "Chandigarh", "Delhi", "Bangalore", "Hyderabad"].map<DropdownMenuItem<String>>((String city){
    return DropdownMenuItem<String>(
      value: city,
      child: Text(city),
    );
  }).toList();
}

class DropDownWidget extends StatefulWidget{
  createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget>{

  String city = "Ludhiana";

  @override
  Widget build(BuildContext context) {

    return DropdownButton(
      items: getDropDownMenuItems(),
      value: city,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 24.0,
      style: TextStyle(fontSize: 18.0, color: Colors.amber),
      underline: Container(
        height: 2.0,
        color: Colors.blueGrey
      ),
      onChanged: (String value) {
        setState(() {
          city = value;
        });
      },
    );
  }
}

// Assignment: Show the MenuItem List from ActionBar click on 3 dots icon : -> and show the menu item
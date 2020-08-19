import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget{
  createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget>{

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      title: Text("Java", style: TextStyle(fontSize: 20.0),),
      subtitle: Text("Java J2EE Technology", style: TextStyle(fontSize: 16.0)),
      onChanged: (bool value){
        setState(() { // here we will re-build our widget
          isChecked = value;
        });
      },
      value: isChecked
    );

  }
}
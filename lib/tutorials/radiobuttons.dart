import 'package:flutter/material.dart';

class RadioButtonWidget extends StatefulWidget{
  createState() => _RadioButtonWidgetState();
}

enum Gender{
  female,
  male,
  others
}

class _RadioButtonWidgetState extends State<RadioButtonWidget>{

  Gender groupValue = Gender.female;

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ListTile(
            title: Text("Female"),
            leading: Radio(
              value: Gender.female,
              groupValue: groupValue,
              onChanged: (Gender value){
                setState(() { // re-build the Widget
                  groupValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Male"),
            leading: Radio(
              value: Gender.male,
              groupValue: groupValue,
              onChanged: (Gender value){
                setState(() { // re-build the Widget
                  groupValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Others"),
            leading: Radio(
              value: Gender.others,
              groupValue: groupValue,
              onChanged: (Gender value){
                setState(() {     // re-build the Widget
                  groupValue = value;
                });
              },
            ),
          )
        ],

      );
  }
}

// Assignment: Explore RadioListTile Widget
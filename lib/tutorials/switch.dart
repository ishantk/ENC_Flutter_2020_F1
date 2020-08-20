import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget{
  createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget>{

  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {

    return SwitchListTile(
      title: Text("Notification Settings", style: TextStyle(fontSize: 20.0),),
      subtitle: Text("Manage your notifications for the app", style: TextStyle(fontSize: 16.0),),
      value: isEnabled,
      onChanged: (bool value) {
        setState(() {
          isEnabled = value;
        });
      },
      secondary: Icon(Icons.notifications),
    );

  }
}
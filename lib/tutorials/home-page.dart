import 'package:flutter/material.dart';

// Widgets which may change the state on the UI, must be Stateful
// example: Counter on the Cart Page where dish quantity can be managed - 1 +
// Removing a Dish from the Cart, may display the updated dishes in the UI

// the moment we create object of StatefulWidget, createState function will be automatically executed
class HomePage extends StatefulWidget{

  /*@override
  HomePageState createState() {
    return HomePageState();
  }*/

  // HomePageState createState() => HomePageState();
  createState() => HomePageState();

}
// Creating object of HomePageState will execute its build function
class HomePageState extends State<HomePage>{
  // we have build function in the state, so that if anything changes in the state,
  // we can re execute the build function to redraw the Widget on UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: Text("Welcome to Home", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),),
        ),
    );
  }

}
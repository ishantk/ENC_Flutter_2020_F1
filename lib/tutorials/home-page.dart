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

  // i is attributes of HomePageState i.e. data in the State
  int i = 0;

  var quotes = <String>[
      "Be Exceptional",                             //0
      "Work Hard, Get Luckier",
      "Good Day for Good People",
      "Set your Goals Today",
      "Their is nothing like tomorrow. Live today"  //n-1
  ];

  // we have build function in the state, so that if anything changes in the state,
  // we can re execute the build function to redraw the Widget on UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: Center(
        child: Text("Quote $i\n${quotes[i]}",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
          textAlign: TextAlign.center,
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        tooltip: "Next Quote",
        onPressed: (){
          // PS: we can execute setState only in a stateful widget
          setState(() { // executing setState will execute build function again and hence, ui will be refreshed with new values
            i++;  // manipulated the data and hence, setState execution will refresh UI with changes

            // Circular rotation :)
            if(i == 5){
              i = 0;
            }

          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          color: Colors.grey,
          height: 50.0,
        ),
      ),
    );
  }

}
import 'package:enc_flutter_2020_f1/tutorials/home-page.dart';
import 'package:flutter/material.dart';

// Image References : https://www.flaticon.com/

// Whenever we create object of StatelessWidget, build function is executed
class SplashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    Future.delayed(
        Duration(seconds: 3),
        (){ // Anonymous Function | after 3 seconds, this function will be automatically executed
          //Navigator.push(
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            )
          );
        }
    );

    // Scaffold: a complete Full Screen UI Page
    // we can associate AppBar, TabBar, NavBar, BottomNavBars etc...
    return Scaffold(
      //appBar: AppBar(title: Text("Welcome"),),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/app_icon.png'),
            SizedBox(height: 2.0,),
            Text("Food Delivery App",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),),
            SizedBox(height: 2.0,),
            Text("Your Dish Our Command",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200, color: Colors.amber),),
          ],
        ),
      ),
    );
  }

}

// Assignment: Put the column in the center, even we have done, its now working :(
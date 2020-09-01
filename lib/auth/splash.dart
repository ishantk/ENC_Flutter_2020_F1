import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Image References : https://www.flaticon.com/


bool checkUserInFirebaseAuth() {
  // In case user has logged in or registered, FirebaseAuth Module saves that information locally on the device as token
  FirebaseAuth auth = FirebaseAuth.instance;
  if(auth.currentUser != null) {
    //Utils.UID = auth.currentUser.uid;
    return true;
  }else{
    return false;
  }
}

navigate(BuildContext context, String route){
  Future.delayed(
      Duration(seconds: 3),
          (){
        Navigator.pushReplacementNamed(context, route);
      }
  );
}

// Whenever we create object of StatelessWidget, build function is executed
class AppSplashPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    if(checkUserInFirebaseAuth()){ // UID is not empty -> i.e. User has either logged in or registered
      navigate(context, "/home");
    }else{
      navigate(context, "/signin");
    }

    // Scaffold: a complete Full Screen UI Page
    // we can associate AppBar, TabBar, NavBar, BottomNavBars etc...
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/app_icon.png'),
            SizedBox(height: 2.0,),
            Text("Food Delivery App",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),),
            SizedBox(height: 2.0,),
            Text("Your Dish Our Command",
              style: Theme.of(context).textTheme.headline1,
            )
          ],
        ),
      ),
    );
  }

}

// Assignment: Put the column in the center, even we have done, its now working :(
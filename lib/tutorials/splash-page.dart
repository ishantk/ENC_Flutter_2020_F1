import 'package:enc_flutter_2020_f1/tutorials/appbar.dart';
import 'package:enc_flutter_2020_f1/tutorials/bottom-navigation.dart';
import 'package:enc_flutter_2020_f1/tutorials/covid-list-hardcoded.dart';
import 'package:enc_flutter_2020_f1/tutorials/home-page.dart';
import 'package:enc_flutter_2020_f1/tutorials/listview.dart';
import 'package:enc_flutter_2020_f1/tutorials/navigation.dart';
import 'package:enc_flutter_2020_f1/tutorials/snackbar.dart';
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
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              //builder: (context) => HomePage(),
              //builder: (context) => SnackBarPage(),
              //builder: (context) => HomePageWithAppBar(),
              //builder: (context) => HomePageWithBottomNav(),
              //builder: (context) => NewsListPage(),
              //builder: (context) => CovidCaseListPage(),
              builder: (context) => PageOne(),
            )
          );*/

          //Navigator.pushNamed(context, "/page");
          //Navigator.pushReplacementNamed(context, "/page");
          //Navigator.pushReplacementNamed(context, "/country");
          //Navigator.pushReplacementNamed(context, "/newslist");
          //Navigator.pushReplacementNamed(context, "/register");
          //Navigator.of(context).pushReplacementNamed("/page");
          //Navigator.pushReplacementNamed(context, "/container");
          //Navigator.pushReplacementNamed(context, "/card");
          //Navigator.pushReplacementNamed(context, "/json");
          //Navigator.pushReplacementNamed(context, "/zomato");
          //Navigator.pushReplacementNamed(context, "/navdrawer");
          //Navigator.pushReplacementNamed(context, "/banner");
          Navigator.pushReplacementNamed(context, "/table");

        }
    );

    // Scaffold: a complete Full Screen UI Page
    // we can associate AppBar, TabBar, NavBar, BottomNavBars etc...
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      //appBar: AppBar(title: Text("Welcome"),),
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
import 'package:enc_flutter_2020_f1/auth/signin.dart';
import 'package:enc_flutter_2020_f1/auth/signup.dart';
import 'package:enc_flutter_2020_f1/auth/splash.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/home/home.dart';
import 'package:enc_flutter_2020_f1/tutorials/firestore-operations.dart';
import 'package:flutter/material.dart';

class FoodDeliveryApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: Constants.choice["APP_TITLE"],

      // App Routing, we define the routes which identifies the pages in our App
      routes: {
        "/": (context) => AppSplashPage(),
        "/signin": (context) => SignInPage(),
        "/signup": (context) => SignUpPage(),
        "/home": (context) => FirestoreDBOperationsPage(),
        //"/home": (context) => HomePage(),
      },

      initialRoute: "/",

      theme: ThemeData(
        // for colors: https://material.io/design/color/the-color-system.html#color-usage-and-palettes
          primaryColor: Colors.amber[500],
          accentColor: Colors.amber[200],
          primaryColorDark: Colors.amber[900],
          brightness: Brightness.light,
          fontFamily: 'Georgia',
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Hind'
              )
          )
      ),
    );
  }

}
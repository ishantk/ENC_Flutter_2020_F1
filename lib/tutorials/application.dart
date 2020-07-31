import 'package:enc_flutter_2020_f1/tutorials/splash-page.dart';
import 'package:flutter/material.dart';

class FoodDeliveryApp extends StatelessWidget{

  // final -> value cannot be modified
  final appTitle = "FoodDeliveryApp";

  @override
  Widget build(BuildContext context) {
    // represents App Object and is the root widget of our application
    // this represents no UI
    // is majorly used for configuration of the app | we use to configure android apps in manifest file
    // eg: we may like to attach a theme for our application and that has to be done here :)
    return MaterialApp(
      title: appTitle,
      home: SplashPage(),
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
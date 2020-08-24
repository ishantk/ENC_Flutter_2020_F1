import 'package:enc_flutter_2020_f1/tutorials/banner.dart';
import 'package:enc_flutter_2020_f1/tutorials/card-widget.dart';
import 'package:enc_flutter_2020_f1/tutorials/container-widget.dart';
import 'package:enc_flutter_2020_f1/tutorials/covid-list-hardcoded.dart';
import 'package:enc_flutter_2020_f1/tutorials/custom-theme.dart';
import 'package:enc_flutter_2020_f1/tutorials/datatable.dart';
import 'package:enc_flutter_2020_f1/tutorials/details-user.dart';
import 'package:enc_flutter_2020_f1/tutorials/gesture-detector.dart';
import 'package:enc_flutter_2020_f1/tutorials/json-parsing.dart';
import 'package:enc_flutter_2020_f1/tutorials/list-and-grid.dart';
import 'package:enc_flutter_2020_f1/tutorials/listview.dart';
import 'package:enc_flutter_2020_f1/tutorials/navigation-backward-passing-data.dart';
import 'package:enc_flutter_2020_f1/tutorials/navigation-drawer.dart';
import 'package:enc_flutter_2020_f1/tutorials/navigation-forward-passing-data.dart';
import 'package:enc_flutter_2020_f1/tutorials/navigation.dart';
import 'package:enc_flutter_2020_f1/tutorials/network-requests-with-header.dart';
import 'package:enc_flutter_2020_f1/tutorials/register-user.dart';
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

      //home: SplashPage(),

      // App Routing, we define the routes which identifies the pages in our App
      routes: {
        "/": (context) => SplashPage(),
        "/news": (context) => NewsListPage(),
        "/covid":(context) => CovidCaseListPage(),
        "/page":(context) => PageOne(),
        "/pagetwo":(context) => PageTwo(),
        "/country":(context) => CountryPage(),
        "/newslist":(context) => NewsList(),
        "/register":(context) => RegisterPage(),
        "/details":(context) => ConfirmUserDetails(),
        "/container":(context) => ContainerWidget(),
        "/card":(context) => CardWidget(),
        "/gridlist":(context) => GridListPage(),
        "/gesture":(context) => GesturePage(),
        "/json":(context) => NewsAPIPage(),
        "/zomato":(context) => ZomatoCuisinesPage(),
        "/navdrawer":(context) => NavigationDrawerPage(),
        "/banner":(context) => BannerPage(),
        "/table":(context) => DataTablePage(),
      },

      initialRoute: "/",

      //theme: buildThemeData(), // Customizing the Theme :)

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
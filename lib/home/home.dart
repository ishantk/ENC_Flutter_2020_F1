import 'package:enc_flutter_2020_f1/home/restaurants-home.dart';
import 'package:enc_flutter_2020_f1/home/search-restaurants.dart';
import 'package:enc_flutter_2020_f1/profile/cart.dart';
import 'package:enc_flutter_2020_f1/profile/user-profile.dart';
import 'package:enc_flutter_2020_f1/restaurant/cart-provider.dart';
import 'package:enc_flutter_2020_f1/restaurant/restaurant-list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget{

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int index = 0;

  List<Widget> widgets = [
    // 0
    RestaurantsHomePage(),
    // 1
    RestaurantSearchWidget(),
    // 2
    UserProfilePage()
  ];

  // navItemClicked shall refresh the UI i.e. build the UI again with new value of Index
  void navItemClicked(int i){
    setState(() {
      index = i;
    });
  }

  Widget _buildDialog(BuildContext context, String message) {
    return AlertDialog(
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, message['data']['body'].toString()),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    // Navigator.of(...);
  }


  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings Registered: $settings");
    });

    // Assignment: Save this token of User in Firestore :)
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
      // Token must be saved in the DataBase to send notification to a particular user :)
      // firestore update query to save token for User :)
    });

    _firebaseMessaging.subscribeToTopic("food-alerts");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: "CART",
            onPressed: (){
              MaterialPageRoute route = MaterialPageRoute(builder: (context) => DishCartPage());
              Navigator.push(context, route);
            },
          )
        ],
      ),
      body: Center(
        child: widgets.elementAt(index),  // widgets[index]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // 0
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("HOME")
          ),
          // 1
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("SEARCH")
          ),
          // 2
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              title: Text("PROFILE")
          )
        ],
        currentIndex: index,
        selectedFontSize: 16.0,
        selectedItemColor: Colors.red,
        /*onTap: (idx) {
          setState(() {
            index = idx;
          });
        }*/
        onTap: navItemClicked,
      ),
    );
  }
}
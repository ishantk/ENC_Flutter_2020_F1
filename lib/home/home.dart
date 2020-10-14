import 'package:enc_flutter_2020_f1/home/restaurants-home.dart';
import 'package:enc_flutter_2020_f1/home/search-restaurants.dart';
import 'package:enc_flutter_2020_f1/profile/cart.dart';
import 'package:enc_flutter_2020_f1/profile/user-profile.dart';
import 'package:enc_flutter_2020_f1/restaurant/restaurant-list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

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
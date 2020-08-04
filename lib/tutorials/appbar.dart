import 'package:flutter/material.dart';

// Global Level Objects:
// Widgets can have keys, which uniquely identifies them :)
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
SnackBar snackBar = SnackBar(content: Text("This is SnackBar"));

class HomePageWithAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // now scaffold widget has a key
      // and this key can manage the state of Scaffold Widget for us
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("AppBar"),
        // actions is a List of Widgets in the App Bar
        // as per principle it must be some icon
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            tooltip: "Cart",
            onPressed: (){
              scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: Icon(Icons.lock_open),
            tooltip: "Log Out",
            onPressed: (){
              scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }
}
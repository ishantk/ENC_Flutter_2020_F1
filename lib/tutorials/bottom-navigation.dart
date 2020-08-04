import 'package:flutter/material.dart';

class HomePageWithBottomNav extends StatefulWidget{

  // In case you wish to create constructor
  // In Flutter we must pass a key for the widget 
  //HomePageWithBottomNav({Key key}): super(key: key);  // Passing the key in the constructor is required :)
  
  @override
  createState() => HomePageWithBottomNavState();

}

getListView(){
  return ListView(
    padding: EdgeInsets.all(8.0),
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.account_box, color: Colors.red,),
        title: Text("My Account"),
        subtitle: Text("Your Account Details", style: TextStyle(fontSize: 12.0, color: Colors.grey),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){

        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.attach_money, color: Colors.red,),
        title: Text("Banking"),
        subtitle: Text("Your Banking Details", style: TextStyle(fontSize: 12.0, color: Colors.grey),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){

        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.settings, color: Colors.red,),
        title: Text("Settings"),
        subtitle: Text("App Settings", style: TextStyle(fontSize: 12.0, color: Colors.grey),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){

        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.help, color: Colors.red,),
        title: Text("Help Support"),
        subtitle: Text("FAQ's and Help Topics", style: TextStyle(fontSize: 12.0, color: Colors.grey),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){

        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.rate_review, color: Colors.red,),
        title: Text("Rate Us"),
        subtitle: Text("Kindly provide your feedback", style: TextStyle(fontSize: 12.0, color: Colors.grey),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){

        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.share, color: Colors.red,),
        title: Text("Share"),
        subtitle: Text("Share if you like us", style: TextStyle(fontSize: 12.0, color: Colors.grey),),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){

        },
      )
    ],
  );
}

class HomePageWithBottomNavState extends State<HomePageWithBottomNav>{
 
  int index = 0;
  
  List<Widget> widgets = [
    // 0
    Text("Welcome Home", 
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
    // 1
    Text("Search Something",
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
    // 2
    //    Text("Account Management",
    //      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
    getListView()
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
        title: Text("Welcome"),
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
              title: Text("ACCOUNT")
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
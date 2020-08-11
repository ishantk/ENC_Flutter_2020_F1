import 'package:flutter/material.dart';

class GridListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridList Page"),
      ),
      body: Center(
        //child: getListView()
          child: getGridView()
      ),
    );
  }
}

getListView() => ListView(
  padding: EdgeInsets.all(16.0),
  children: [
    getListTile("BCC", "BCC News Channel", Icons.accessibility_new),
    getListTile("CNN", "CNN News Channel", Icons.contact_mail),
    getListTile("NDTV", "NDTV News Channel", Icons.email),
    getListTile("IBN", "IBN News Channel", Icons.settings),
    getListTile("AAJ TAK", "AAJ TAK News Channel", Icons.sentiment_neutral),
  ],
);


getListTile(String title, String subTitle, IconData iconData) =>
    ListTile(
      title: Text(title,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.green),),
      subtitle: Text(subTitle,
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.lightBlue),),
      leading: Icon(
        iconData,
        color: Colors.amber,
      ),
    );


//List<Container> getGridTiles() => <Container>[];
//List<Container> getGridTiles() { return <Container>[]; }

/*
getGridTiles() => <Container>[
  Container(
    decoration: BoxDecoration(
      color: Colors.greenAccent,
      border: Border.all(width: 2.0, color:Colors.amber),
      borderRadius: BorderRadius.all(Radius.circular(8.0))  
    ),
    margin: EdgeInsets.all(8.0),
    child: Image.asset("assets/larry.png"),
  ),
  Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(width: 2.0, color:Colors.amber),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    margin: EdgeInsets.all(8.0),
    child: Image.asset("assets/steve.png"),
  ),
  Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(width: 2.0, color:Colors.amber),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    margin: EdgeInsets.all(8.0),
    child: Image.asset("assets/bill.png"),
  ),
  Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(width: 2.0, color:Colors.amber),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    margin: EdgeInsets.all(8.0),
    child: Image.asset("assets/steve.png"),
  ),
  Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(width: 2.0, color:Colors.amber),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    margin: EdgeInsets.all(8.0),
    child: Image.asset("assets/bill.png"),
  ),
  Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent,
        border: Border.all(width: 2.0, color:Colors.amber),
        borderRadius: BorderRadius.all(Radius.circular(8.0))
    ),
    margin: EdgeInsets.all(8.0),
    child: Image.asset("assets/larry.png"),
  )
];*/

getGridView() => GridView.extent(
    maxCrossAxisExtent: 150, // max extent of tiles in the cross axis
    padding: EdgeInsets.all(16.0),
    mainAxisSpacing: 3,
    crossAxisSpacing: 3,
    children: getGridTiles(),
);

/*
getGridView() => GridView(
  children: getGridTiles(),
  padding: EdgeInsets.all(16.0),
);*/

getGridTiles() => <Container>[
  getGridTile("larry.png"),
  getGridTile("steve.png"),
  getGridTile("bill.png"),
  getGridTile("larry.png"),
  getGridTile("bill.png"),
  getGridTile("steve.png"),
];


getGridTile(String image) => Container(
  decoration: BoxDecoration(
      color: Colors.greenAccent,
      border: Border.all(width: 2.0, color:Colors.amber),
      borderRadius: BorderRadius.all(Radius.circular(8.0))
  ),
  margin: EdgeInsets.all(8.0),
  child: Image.asset("assets/$image"),
);

// Exploratory Task: How can we fill the entire image in the Container :)
// Assignment: Change the UI of the App from List to Grid and vice versa from AppBar Action Item Click
//             Hint : StatefulWidget |and execute setState function when we click the ActionItem on ActionBar
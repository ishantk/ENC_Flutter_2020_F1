import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/restaurant/menu.dart';
import 'package:flutter/material.dart';

class RestaurantSearchWidget extends StatefulWidget {
  createState() => RestaurantSearchWidgetState();
}

class RestaurantSearchWidgetState extends State<RestaurantSearchWidget> {

  String keyword = "";

  @override
  Widget build(BuildContext context) {

    return ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            onChanged: (String value){
              setState((){
                keyword = value;
              });
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search)
            ),
          ),
          SizedBox(height:10),
          Restaurants(searchKeyword: keyword,)
        ]
    );

  }
}

class Restaurants extends StatefulWidget {

  String searchKeyword = "";

  Restaurants({Key key, this.searchKeyword}): super(key: key);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  fetchSearchedRestaurants(){
    if(widget.searchKeyword.isEmpty) {
      return db.collection(Constants.RESTAURANT_COLLECTION).snapshots();
    } else{
      return db.collection(Constants.RESTAURANT_COLLECTION).where("keywords", arrayContains:widget.searchKeyword).snapshots(); // As per the filter
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fetchSearchedRestaurants(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if(snapshot.hasError){
          return Center(
            child: Text("Something Went Wrong. Please Try Again !!"),
          );
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
              child: CircularProgressIndicator()
          );
        }

        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(8.0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return InkWell(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(document.data()['imageURL']),
                      SizedBox(height: 2.0,),
                      Text(document.data()['name'], style: TextStyle(fontSize: 24.0, color: Colors.amber),),
                      Text("PricePerPerson ${document.data()['pricePerPerson']}", style: TextStyle(fontSize: 18.0, color: Colors.black),),
                      Text("Ratings: ${document.data()['ratings']}", style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),),
                      Divider(),
                      Text("${document.data()['addresses'][0]['city']} | ${document.data()['addresses'][0]['label']}", style: TextStyle(fontSize: 20.0, color: Colors.blueGrey),),
                    ],
                  ),
                ),
              ),
              onTap: (){
                MaterialPageRoute route = MaterialPageRoute(builder: (context) => RestaurantDishes(restaurant: document.data(), restaurantID: document.id),);
                Navigator.push(context, route);
              },
            );
          }).toList(),
        );

      },
    );
  }
}

// Local Search Code :)
class MyWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Search"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    showSearch(context: context, delegate: SearchAppBarDelegate());
                  }
              )
            ]
        )
    );
  }
}

class SearchAppBarDelegate extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(color: Colors.blue, fontSize: 24.0, fontWeight: FontWeight.w900),
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<RestaurantItem> items = [
     RestaurantItem(title: "bens Restaurant", pricePerPerson: 200),
     RestaurantItem(title: "fionnas Restaurant", pricePerPerson: 300),
     RestaurantItem(title: "jacks Restaurant", pricePerPerson: 500),
     RestaurantItem(title: "jims Restaurant", pricePerPerson: 250),
     RestaurantItem(title: "georges Restaurant", pricePerPerson: 400),
   ];

   List<RestaurantItem> suggestionList = query.isEmpty
                                          ? items
                                          : items.where((element) => element.title.startsWith(query)).toList();

   return suggestionList.isEmpty
       ? Text("No Result Found :(")
       : ListView.builder(itemBuilder: (context, index) {
         return ListTile(
           title: Text(suggestionList[index].title),
           subtitle: Text(suggestionList[index].pricePerPerson.toString()),
           onTap: (){
             showResults(context);
           },
         );
       },
       itemCount: suggestionList.length,
   );


  }

}

class RestaurantItem{
  String title;
  int pricePerPerson;
  RestaurantItem({@required this.title, @required this.pricePerPerson});
}
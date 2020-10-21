import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/restaurant/menu-provider.dart';
//import 'package:enc_flutter_2020_f1/restaurant/menu.dart';
import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {

  String filter = "";

  RestaurantPage({Key key, this.filter}): super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  fetchFilteredRestaurants(){
    if(widget.filter.isEmpty) {
      return db.collection(Constants.RESTAURANT_COLLECTION).snapshots(); // All the Restaurants
    } else{
      return db.collection(Constants.RESTAURANT_COLLECTION).where("tags", arrayContains:widget.filter).snapshots(); // As per the filter
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: fetchFilteredRestaurants(),
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

          // ListView with ListTile
          /*return ListView(
            padding: EdgeInsets.all(16.0),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.data()['name']),
                subtitle: Text(document.data()['pricePerPerson']),
              );
            }).toList(),
          );*/

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
                  //MaterialPageRoute route = MaterialPageRoute(builder: (context) => RestaurantMenuPage(restaurantId: document.id,),);
                  //MaterialPageRoute route = MaterialPageRoute(builder: (context) => RestaurantDishes(restaurant: document.data(), restaurantID: document.id),);
                  MaterialPageRoute route = MaterialPageRoute(builder: (context) => RestaurantMenuPage(restaurant: document.data(), restaurantID: document.id),);
                  Navigator.push(context, route);
                },
              );
            }).toList(),
          );

        },
      );
  }
}
